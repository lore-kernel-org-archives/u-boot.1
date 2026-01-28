Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53B4D25B6E
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 13:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FAC83E63;
	Wed, 28 Jan 2026 14:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N9trBcHU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HnOLfd9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEB483C65; Wed, 28 Jan 2026 14:28:49 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E513183E76
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 14:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1NQR568Xz9tVR;
 Wed, 28 Jan 2026 14:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769606927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z788ViUDkFHu/ugIUlwK80afLn1jEnXhGwYNX3sCU8c=;
 b=N9trBcHUNtilS9Ni+fzBdsMBIqcbfIgDDrQs1aZYA8BPJ+NPlfhY3hUINDgwuFRARX2C2N
 ZI49/zTY6zbrSfBb2qpolmEO1zkwTNeGuAsudsVsxQUx6jHoIJgxJbyMsyclFdtZ3yLRCh
 GjJaP1xfHBfoplfEx2m5kzNN6h3hQ45NwkTV4tg/FbqfyFgBagRcDUVld+99ONPvDl58Y3
 TdtpM094Oc5cjTuolV5qoJEDway9C1zowkQLAiZvURX0KQ2i/fdY8htgsCCf2lMZqdcR+Z
 8Jbptn90d4V4BaRkBdZh7Rl09JfvdUhHqGzhYfbFGtavJosUL164iwpDM90KCQ==
Message-ID: <24e2f79f-534e-4471-b205-9697ff54f129@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769606925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z788ViUDkFHu/ugIUlwK80afLn1jEnXhGwYNX3sCU8c=;
 b=HnOLfd9LC5BjPcn04mOaf1gNkchpVf+YZtw+WeofWYsje6AMSLVxlMbIA73SdxGiCIyxEH
 LaStfGO8zgyHNECk5x0gyR8YktDCdEQ6xIsJNJULttcJV3SNbGUEeJnbOMMTyGxemXZq8N
 5TphgUIZ7gS/yhOhAg37YUeINTagnQbzr65aw8CwOsspnQ4ypBAnq+1V9LuN/oixK4hI5Y
 ye+WGmz/Pphper595BAXMXPVgLpA5AH2RMtqfbM34Sf5Db2WaBqA74iCySPraEb5T3pwnN
 TJmrFou+xFAgz8BQAbkVCa2BZnbcueSADWOItZjI4onHZsbVSGQEVctriDOu8Q==
Date: Wed, 28 Jan 2026 13:16:51 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: zip: Use map_sysmem() with buffers in the zip command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260127235339.1503312-1-marek.vasut+renesas@mailbox.org>
 <CE08F0E4-6577-4CC8-9512-76790D72830A@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CE08F0E4-6577-4CC8-9512-76790D72830A@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: o54k4f1fgts4cg6pbh4416wdgx4zcdyn
X-MBO-RS-ID: cd254c1c06468b71929
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

On 1/28/26 5:53 AM, Heinrich Schuchardt wrote:

Hello Heinrich,

>> static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> @@ -27,8 +28,10 @@ static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> 			return cmd_usage(cmdtp);
>> 	}
>>
>> -	if (gzip((void *) dst, &dst_len, (void *) src, src_len) != 0)
>> +	if (gzip(map_sysmem(dst, dst_len), &dst_len,
>> +		 map_sysmem(src, src_len), src_len) != 0) {
> 
> Wasn't the idea of map_sysmem() with a non-zero length to have a matching unmap_sysmem()?
> 
> @Simon:
> 
> Does the sandbox really need the mappped areas or can we get rid of the length parameter and of unmap_sysmem()?
> 
> Best regards
Let me add the unmap_sysmem(), also for do_unzip() where it is missing too.
