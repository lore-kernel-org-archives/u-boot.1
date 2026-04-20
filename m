Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43389F5A8CA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC030842E1;
	Tue, 21 Apr 2026 02:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jNrBVFrL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UAKfiTYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84F1842E1; Tue, 21 Apr 2026 02:48:10 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA3984198
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g03cS4MDXz9tfd;
 Tue, 21 Apr 2026 02:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bq2m04ngUKRvxqx5L4X+09tpyDVW3cUIFf8mIJkbVCs=;
 b=jNrBVFrLLdLsMaMQWXC/RSMXKB9s28o8XC/9eCeQpwyrRH8bxty7z9UWW1/JTOsZXSXhny
 fjSiWYJhpIRoxgKg+Wuc9Tjay0ULwl1kocBeOU7V5BdM8OIh5Ltj98qYKYce/vjCKd9JoJ
 IczpF921dtBnZJJ05yAbJiCxB/gwzGpXHnT4y9C7RnpFGK4rbjY37Xk9iqzLMULwMBvl+K
 8cby/o+p9BTEsqkhK0vKOkH2jZnIq6IddQg5eZ2zr5cRUrHp4qHvmVLIfUMz6Mmd3kAD77
 +DD8U7wRc70LfId9iBrvaTRTJuRs9Vdl5RbwmvNGy+RFjMTswmbsh3FUsYSFog==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=UAKfiTYq;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <0c112980-e5db-4acc-97df-c1097c41112b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bq2m04ngUKRvxqx5L4X+09tpyDVW3cUIFf8mIJkbVCs=;
 b=UAKfiTYq+ybVN/sbogGRNmpuecNzNvgBlKyPVnVIODnoW/a6V4CYOuMPTOwHi2CgEeIbVB
 CDsSppDRLAVyQLi+Rp4fJTboMr9GKIzhGFD+nA8YVd2TGGeEvWKHfuf58VZhNxg28VORxe
 B/urELRu3+KQznQ4Qty1cj7lqtrWhmeDQJPAxDRNP5fBD1DfzyY0YzH9ZK5MJ93uAmNVUa
 1PdglRQ/19MF72Pdmmp5XD0fdhpr2iAv7R1UJl9EtLyBDGwfegCd1/ovrK/++y1AcJCyVX
 3WuA8MxZxvSgewocHHSfRfayV+7oVLhO5Fnh5T2ky6HiFRUcMUdvZGQJOZiNKw==
Date: Mon, 20 Apr 2026 14:43:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
To: Simon Glass <sjg@chromium.org>, marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg+nfKGCaHGz6-GHoQ+KntLYYdUTZqfYGpBdsvLSW9FZQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTg+nfKGCaHGz6-GHoQ+KntLYYdUTZqfYGpBdsvLSW9FZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d89125dedeab75e8749
X-MBO-RS-META: 5xzpp8gjduyqqo9qi6g3udrfjoctstqn
X-Rspamd-Queue-Id: 4g03cS4MDXz9tfd
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

On 4/20/26 6:14 AM, Simon Glass wrote:
> On 2026-04-20T01:23:26, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>> kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
>>
>> The fdtgrep command will reduce the DT to minimum size, thus eliminating
>> the extra padding configured via CONFIG_SYS_DTC_PAD_BYTES. Reinstate the
>> extra padding by running the output DTB from fdtgrep through DTC with the
>> -p CONFIG_SYS_DTC_PAD_BYTES flag again in case CONFIG_SYS_DTC_PAD_BYTES
>> is not zero.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> scripts/Makefile.lib | 7 +++++++
>>   1 file changed, 7 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Is this something which can be added into fdtgrep itself btw ?
