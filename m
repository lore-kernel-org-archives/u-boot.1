Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3501EC4829A
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 10:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738FC87C09;
	Tue,  6 Feb 2024 11:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Rt176Uxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8143B87C56; Tue,  6 Feb 2024 11:37:30 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9514687B8A
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 11:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707215848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urhKVDWTmzbTUkFzapI6jrR5PI+UUwJuKm8Qn5itkNw=;
 b=Rt176UxyVhZpeaSTjMjX1VsxLxEnsDQBliJ/XnMj4SSiDCkeI1sFG+Z2sThljSoTATF1oe
 ta8S/4XJUk3jEKqlXJLQQruVE86RjageSns8GK38fK0JJHKMOVccNkFtQbqmsqftuCb4Cb
 kxydYzgOqZR7WsNo7kbEvZ1TinEkEfEXdDC6aVdb2j29RRPVHt7jmZkXnnPMlWyIMNy6Mc
 6pLH2my/3JXkv0vIdB3B8yL6f1+iba2MCzTq7k/8CMll3ez/VHH2/R6mHGIs7F5nv0FXAp
 5BJzfuxJK2wbvRfn3ZdrXfBZUeIE9MKevBQarW7ekH6NnOEnUk8Cpvb5sCBcKA==
Date: Tue, 06 Feb 2024 11:37:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com,
 martin@geanix.com
Subject: Re: [PATCH] scripts: dtc-version: Don't show error messages
In-Reply-To: <2493a32f-8795-4c71-b719-039db0f0ad24@theobroma-systems.com>
References: <aebd96be57ec59ace348287094ab919ce82711c9.1707191569.git.dsimic@manjaro.org>
 <2493a32f-8795-4c71-b719-039db0f0ad24@theobroma-systems.com>
Message-ID: <ba0ff826dbaff3b23a8a9fa27e5d663d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

On 2024-02-06 11:25, Quentin Schulz wrote:
> On 2/6/24 04:56, Dragan Simic wrote:
>> Prevent the error messages produced by which(1), such as the one 
>> quoted
>> below, from being visible in the build outputs.
>> 
>>      which: no dtc in (./scripts/dtc)
>> 
>> This makes the build outputs look a tiny bit cleaner.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>   scripts/dtc-version.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
>> index 53ff868bcdce..6d3d7b68fdfa 100755
>> --- a/scripts/dtc-version.sh
>> +++ b/scripts/dtc-version.sh
>> @@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
>>          exit 1
>>   fi
>> 
>> -if ! which $dtc >/dev/null ; then
>> +if ! which $dtc >/dev/null 2>/dev/null ; then
> 
> What about
> 
> which $dtc > /dev/null 2>&1
> 
> instead?

That's exactly what I intended to use, but IIRC some shells
or some older versions of some shells may not recognize that,
so I went with a more verbose, but slightly safer option.

> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks for your review.
