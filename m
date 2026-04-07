Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F375FEEF44
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 711DF840AB;
	Tue,  7 Apr 2026 15:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qC0ds3IR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4AC8412A; Tue,  7 Apr 2026 15:38:30 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDB183F98
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=esK0Q1ih9yvLYzseeMWQSungjBU59y21FQu3mgfReJE=; b=qC0ds3IR1DyAJ2gMtIcilEwiMV
 ZR0/eIj87s3NFxFYH+JepkPYVbmgpFy87bQaIkw9ROcSu19A2fxN8uIpP35EP9YcmDABReJKB9lGY
 ABsuoC/L+2c8I2zdwPlgNtzrEJEkMtvkKaflkIGgK/+6QOKch1ArLTfvrZsV0c/A5IIdvcFIrik7e
 twqmcZ4FMjvTFNkLM8yi4YoYBQrHz2aXqWyOgpx9yyHiS9YsXyB/zuZqnmV1SWPDDaqPXfFS7FrXC
 7wecp5Jv8aOijfeimHNTtjK9lXPB5cVEgxLI8KYZcB5+KYbe/bobT2aPKvjW3syCI4gy+1+th3TI0
 0GD3XMJg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wA6dM-000D7a-1P; Tue, 07 Apr 2026 15:38:24 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wA6dM-000Pyf-0H; Tue, 07 Apr 2026 15:38:24 +0200
Message-ID: <c4c6afef-ba6a-487b-8cbd-14bdbe1c3072@ew.tq-group.com>
Date: Tue, 7 Apr 2026 15:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add support for TQMa7x
To: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
 <CAOMZO5DiHkQfjthe1Yyur86vpAX6-zNZZH-JcKADXNRhfZxV5A@mail.gmail.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <CAOMZO5DiHkQfjthe1Yyur86vpAX6-zNZZH-JcKADXNRhfZxV5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 02/04/2026 18:36, Fabio Estevam wrote:
>The doc part does not pass CI:
>
>https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1418796
>
>For v4, make sure to pass it in CI and send me a link for the CI pass.
I set up a repository on gitlab.com and configured a shell and a docker runner
on my local machine. The shell executor successfully runs the first stage but
fails to run the subsequent stages because of
`fatal: destination path '/tmp/uboot-test-hooks' already exists and is not an empty directory.`
The docker executor fails because of missing ca certificates and some jobs just
get stuck at `Created fresh repository.`with the runner log repeatedly showing
the following message:
ERROR: Appending trace to coordinator... error measured raw request: execute
raw request: execute request: couldn't execute PATCH against
https://gitlab.com/api/v4/jobs/13810408111/trace?debug_trace=false: Patch
"https://gitlab.com/api/v4/jobs/13810408111/trace?debug_trace=false": EOF  
runner=orOc9hIHK runner_name=FEILKEA-DOCKER
Is there documentation on how to set up the CI properly, including ca
certificates to surpass company restrictions?
Thanks,
Alex
