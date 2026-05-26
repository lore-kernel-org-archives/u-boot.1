Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CDCCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62B8B84874;
	Tue, 26 May 2026 15:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="jfVfzFIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 161DA84879; Tue, 26 May 2026 15:18:36 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D475E84873
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A57FB26A04;
 Tue, 26 May 2026 15:18:33 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2zKGUUqtkVgg; Tue, 26 May 2026 15:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779801512; bh=1uVSqChrc2FnYu+KVFtj2D4Yp820J/03Af6Fmg02JhA=;
 h=Date:From:To:CC:Subject:In-Reply-To:References;
 b=jfVfzFIAHtoPapIo8z0RxtbIWfYW2ikzCMK3zUqva73m3vfk9Vn9PTqIofyn9aGjq
 Do3SaNexuovdI8e2WjxlGB2A8cNeoejE4T1Yo1gqvtcpd/K4q4iZIyHVk7Yb59jKLi
 M87Z3OZsj0Y6vE9TJAPXINNpJ2UWjcEJrgYsebxg6BekLAcfxirFcuWn+fwOMDAooz
 Ib2pfdwb8NmffQx4y7ppwfIWZChz1qd1VgPre9LaZpaXCEDtEsj7I/LyAuAvX7LNQu
 Uzg1yALzk1PBU/IXRNHFcwf42y7QMh2r1HPVMkElxRBVpw9PJtdQ3mZwLhiWIlffNJ
 aub7ZPtIFaz0w==
Date: Tue, 26 May 2026 14:18:33 +0100
From: Josh Law <josh2@disroot.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, mkorpershoek@kernel.org, igor.opaniuk@gmail.com
Subject: Re: [PATCH 1/1] libavb: fix avb_replace() OOM handling
In-Reply-To: <87se7efgyz.fsf@kernel.org>
References: <20260521163248.15866-1-josh2@disroot.org>
 <20260521163248.15866-2-josh2@disroot.org>
 <20260522183537.GA1858239@bill-the-cat> <87se7efgyz.fsf@kernel.org>
Message-ID: <711D032B-526D-4BAC-A087-19F0D9AE987D@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On May 26, 2026 2:17:08 PM GMT+01:00, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>Hi Josh,
>
>On Fri, May 22, 2026 at 12:35, Tom Rini <trini@konsulko.com> wrote:
>
>> On Thu, May 21, 2026 at 04:32:48PM +0000, Josh Law wrote:
>>> avb_replace() promises NULL on OOM. Once it had built the first
>>> replacement, a later allocation failure returned that partial buffer.
>>> Callers treat any result as success, so AVB could keep booting with
>>> truncated bootargs.
>>> 
>>> Free the partial result and return NULL. The existing callers can then
>>> take their OOM path.
>>> 
>>> Signed-off-by: Josh Law <josh2@disroot.org>
>>> ---
>>>  lib/libavb/avb_util.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/lib/libavb/avb_util.c b/lib/libavb/avb_util.c
>>> index 8719ede15a7..9e2e6ea3495 100644
>>> --- a/lib/libavb/avb_util.c
>>> +++ b/lib/libavb/avb_util.c
>>> @@ -272,7 +272,7 @@ char* avb_replace(const char* str, const char*
>search, const char* replace) {
>>>        num_new = num_before + replace_len + 1;
>>>        ret = avb_malloc(num_new);
>>>        if (ret == NULL) {
>>> -        goto out;
>>> +        goto fail;
>>>        }
>>>        avb_memcpy(ret, str, num_before);
>>>        avb_memcpy(ret + num_before, replace, replace_len);
>>> @@ -283,7 +283,7 @@ char* avb_replace(const char* str, const char*
>search, const char* replace) {
>>>        num_new = ret_len + num_before + replace_len + 1;
>>>        new_str = avb_malloc(num_new);
>>>        if (new_str == NULL) {
>>> -        goto out;
>>> +        goto fail;
>>>        }
>>>        avb_memcpy(new_str, ret, ret_len);
>>>        avb_memcpy(new_str + ret_len, str, num_before);
>>> @@ -308,7 +308,7 @@ char* avb_replace(const char* str, const char*
>search, const char* replace) {
>>>      size_t num_new = ret_len + num_remaining + 1;
>>>      char* new_str = avb_malloc(num_new);
>>>      if (new_str == NULL) {
>>> -      goto out;
>>> +      goto fail;
>>>      }
>>>      avb_memcpy(new_str, ret, ret_len);
>>>      avb_memcpy(new_str + ret_len, str_after_last_replace,
>num_remaining);
>>> @@ -320,6 +320,10 @@ char* avb_replace(const char* str, const char*
>search, const char* replace) {
>>>  
>>>  out:
>>>    return ret;
>>> +
>>> +fail:
>>> +  avb_free(ret);
>>> +  return NULL;
>>>  }
>>>  
>>>  /* We only support a limited amount of strings in avb_strdupv(). */
>>
>> Thanks for the explanation and patch. This seems fine but I'll defer to
>> Mattijs as it's his area.
>
>This patch seems to posted a second time here:
>https://lore.kernel.org/all/20260521165122.17475-1-josh2@disroot.org/
>
>Can you explain why it has been send twice, please?

Heh. The like guardian of the "first post" lists, took a while, so I
subscribed to the list, thought that would get it approved on-list

It happens. Honest mistake :)


>>
>> -- 
>> Tom
>

Thanks!
