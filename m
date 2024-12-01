Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD84AD4978C
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 21:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4906893B3;
	Sun,  1 Dec 2024 22:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qxI4sUfq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iK9+gzoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4968B89385; Sun,  1 Dec 2024 22:08:18 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F971893E5
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 22:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y1fdl2W4wz9svS;
 Sun,  1 Dec 2024 22:08:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733087291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+7bQ+f5RKtsG/UIlzSnnMDBdy0y4ocmqEn7u6Q4OrA=;
 b=qxI4sUfqWXow4bjYXIrmr1bXaW1affTiD6Ar6xa+nln9dE1yMLhhUWh8KEQuoA6ql5bgHQ
 XXyYQlt4zL3BTE+tjYHlVAXOcvefEJ6ApSAZIx7InnUFJBzpXaqm+3I6L1LsYXY776KBBk
 +YNwh8xUxXtEGnnoEEAMmUIylQicMlR4yTAbA012rrLlHnetqQVA8ayE56etfvcPWo3UgR
 YQAdddX5exNSvpkx20kCEx1vFCsipSSoOlBqpynst8TAQwgDMGlqvPHWltU4nvY0W95ISA
 nXolp7CDC5fZAJoNMXpgmwXjLF2PrixyypujBwmBHtau6xIz5MMBtpbCg3IcEg==
Message-ID: <ca0d025b-0ffe-4640-b6cb-58403e427fdd@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733087289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+7bQ+f5RKtsG/UIlzSnnMDBdy0y4ocmqEn7u6Q4OrA=;
 b=iK9+gzoMt18yw70jiwysF9JAuCIjKCf9ibltqHNWb4r3EShkY5AtBHhBdQVRrZIppAXuDY
 0TW2cKaL6KB+U24+cobcFMFSKp+2t4ypQIihmCPwYoBDiUiIAsRE4tKGiIvvkBQCY81hAu
 lm4rZJaayNG9FQJ1NL/Ukli+RdGVOOSTO1X0fSSWHQ1w9tFAw2+vPDI3Nom+JlOb8To9rE
 JCIStZHvks7Ytuj4VqsflgL/pb8M/G0lW1dYLJNqHWy3ii8FyBWuEr22IT+zrH8F5MwluC
 Pv4sb3AWD2AreYD9WAASsPgC+bQcBnoPG19BIjZ9QTWXiOC0rdBY7DUk/+w7HQ==
Date: Sun, 1 Dec 2024 22:08:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: ravb: Simplify max-speed handling in
 ravb_of_to_plat
From: Marek Vasut <marek.vasut@mailbox.org>
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241120094939.129-1-paul.barker.ct@bp.renesas.com>
 <17cde70a-c85c-47c0-86ac-b22473004426@mailbox.org>
Content-Language: en-US
In-Reply-To: <17cde70a-c85c-47c0-86ac-b22473004426@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b8b7b97b147d010f8de
X-MBO-RS-META: b9xjmf9xua7me836bjnoymo8r7wf4ati
X-Rspamd-Queue-Id: 4Y1fdl2W4wz9svS
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

On 12/1/24 7:48 PM, Marek Vasut wrote:
> On 11/20/24 10:49 AM, Paul Barker wrote:
>> We can call dev_read_u32_default() instead of calling fdt_getprop() then
>> fdt32_to_cpu().
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Applied to sh/master, thanks.

I think this one triggers some build failure -- 
https://source.denx.de/u-boot/custodians/u-boot-sh/-/pipelines/23670 -- 
https://source.denx.de/u-boot/custodians/u-boot-sh/-/jobs/965285 on 
these boards:

rzg2_beacon hihope_rzg2 r8a77995_draak r8a77970_eagle r8a77990_ebisu 
r8a779a0_falcon r8a779h0_grayhawk rcar3_salvator-x rcar3_ulcb 
r8a77970_v3msk r8a779g0_whitehawk silinux_ek874

You need to drop the *cell variable. I've fixed that up and retriggered 
a build, I hope that's OK?
