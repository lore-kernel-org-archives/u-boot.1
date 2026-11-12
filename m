Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9A606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QWv6HCfZ;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Z7TXgj7b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83A4081684;
	Thu, 12 Nov 2026 20:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1hwKyGbprQ4; Thu, 12 Nov 2026 20:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDB1E81553
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794514435;
	b=ZapnT1x/CpGKD9A8iCfoQB/7uboZb/aQYhtFeQ+F81BmcXbubXj91maobOzUGwDf0gGY
	 HbZHqcS2gE+h3R6hk/oMMuQhucPuje76bz68fXcBKxrKXEpanH7JsjWl2VVBw2tctaATs
	 gL2FUKT8/sxziaTr7vK5tFAE5oimJdvP8CBHMbKJHRi9T0sTcRrNvTrpZSzmxZVNR7GF+
	 r9j/F5ZbwmmoCpJBVneDMhmIyN09+uO49Uo9vzw/X52ORLfcy6lsFcHWmkCNuJ/fZ7Hjk
	 rxG8pxmMDA4Y5OCbAGLjXgpJi44LCKISzJbfEsAK7xGqY5piosmWCR+R+CSxR8KmWLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794514435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G4BchMdO+Z+nfQMpxObQOA3hGpZDmtRtiIen8fain48=;
	b=D8qvrVkAd5qtGObsd1yxzrhRApq3JlFQgGCRH9RKzyBFA5QYzZuks/rkfMKytL1tNOS5
	 VrawhH32Bks9m1OKzuGcZvmuXF3dvUqCspu90/wuYBHWt71UW/doexxZBhy0UqkXk6i3i
	 L9bjMJ1q9/orA8Tr43iuAFDEa7oNkgpQWU8au8+sENneQtSWU2Qvry5LZQoJT42xXoOc6
	 kWcj4xpu3E0JY18mdN84zyEhRlZ4GEfDWMnUhDzCVFx8aQ7mzoBFpj9UmzrNPI8PW00xo
	 IqinB+ExRMcRNlSjHS97A1PYPmnmUtqSxZIY+0gXmzUWMc8u49edCYON/SUwnu6q1mg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794514435;
	bh=G4BchMdO+Z+nfQMpxObQOA3hGpZDmtRtiIen8fain48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QWv6HCfZcFLAo1NZ1vq/CKoL4tZuGcEEsVy+2AXZSS9TRzYAmtQR6Bv7l/ELyWKf9
	 pdExST0gepQjED93UemcLs3ZxQ00eShJdRfCinlqw78cS5SrHK8q/eBrV0h4jeuwgo
	 57vjNW0jVc+2/9IqaK+Tqa52L0/romgsVRUwd7fR0yHRLzLCRLLVrlII/5mqVlBY8O
	 TG18+YIFxcrQSO1RGgbeMp77B2dHT5iTCB8wqUqMkGpP0NcIVDJ7Ytb9GAK8qmox8h
	 gqflUQWfyMHlH9GxYPZwheRMZg44Cgvq7DhDeGZdH/SPd2BQLrD4dKNRRy8Nt3vxx3
	 h1JkCWDSDP1gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDB1E81553;
	Thu, 12 Nov 2026 20:13:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CB8B2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7327340082
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83G_xeVK3PsB for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 20:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A45D04005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Z7TXgj7b
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A45D04005F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:49 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-84e513877a3so265387a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794514428; x=1795119228;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G4BchMdO+Z+nfQMpxObQOA3hGpZDmtRtiIen8fain48=;
 b=Z7TXgj7bIbOcBWMt/DBWSKOHGP5acUvGixt1E2WNk83soLOnQAeg0ojmrCUwE1Jw8T
 +McwQs8eWQiFmgIuA2/3XUQKfKGNxOoL/0owRMCQoelSghpU2HqsDnGPJc3Fvwmf1qAK
 uOU8b1WViMIqWbMcDnAa+Vn73DqujL0Qzyelo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794514428; x=1795119228;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G4BchMdO+Z+nfQMpxObQOA3hGpZDmtRtiIen8fain48=;
 b=JDGe7Rqu2ymt1AZdSHLdXQo+SS7bSfSW39iRzbRJFKTev7RS0eRLCqYOsGrxxfyoMG
 YxSSyEB0leH9MAFz2O0Z9y/PG/kH9KxyBqgBLCCkNYDnaMmtlYQa4KKsIbVkWOVz9fTB
 qfMDYNmOoHgZBIyT8rkxSBNn3NzlFqCX+CYHQMpGOGOKfjrA4HEbcalCpkpI262ORrbn
 MAJORTSkXRVS1wg3kRy8lxbHn5ZCa9ZCegevDdl8KwPmNviuL/7oxuetYtjKJeZIl7AU
 xBLYI93w5Knk1m8tZyFz6f/2gdf9uZhdf06mGyBPV+5N2yJpM3mscw7lwy09ayD/QyES
 purQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFe4leuMaq3Q3JMwEgjBWc0j7cO1ygqyQ0MMPmyiCjdtsrZB5INsOt8JunpV3jHtm74qAE0TLY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+XyGcOjm1G73VtxqS3ghPHUJ9jjyBBugACLU3dQJ4FGIOTOqKB
 VeJX26hj7Lp01okS9IVX2/oNfZNYUtrVtZoBr4CF8a9MpSad1FCM2xu71EjbxqQ48SY=
X-Gm-Gg: AYBFou3g+Rr/dmOr+pnaUibg+XRPhrYronxUBk7cdmNaJQAJe8wKbv2/CUUGrWu9TEZ
 gBwGBEI3vGULmR+QgVSUhR+gAQLOWheuj+lSp3zPBzbCBmHh+coCOoSApALuFL61Kwa+3R5v79M
 n8yBzdoJEY9tdy73qbNNIlEysJXEkcaCfWpLnEkVZHEB8rYbM33+ecZki55AbrYYEL1u/EDEtfj
 pFucgpQtXqtU0Mcn5wsb1OrSdWI351mCTKmIQtUAmTGUJ7WzDsdG5vAJghlrzRcm1k2jTAoBzpY
 asuEO+gLVjB+XsdejvsDtn8DT5Eb6y1jekvrs7GUaZY2kOGYb6Cw3OMqIG4m3rroggIgabAnxrH
 WDV40a0tyxSgN+9Cf9NkdGgpfT/kGZc/FcJNIg27pm0eihmegiUH/4hxUSq62sx3nrTGGejhfby
 zJY8RT/ojKGFCmLD/9sExhuQWMnBF54yt53kVkF9f4/ixNx6yeBs71NtlDy8U8iminiNysP/9f9
 v5P8LXArRMSsZX/zxA3RzOO3GiyeH5QwigupBp/EgLrOLTBvvIEsurGyJS9MyYnSLFpF4yXWZLc
 QlMAP5Hm1CizKgyVNqF6DKOc4r8XofmuLqYR3o++X//9GM3IWR/C3FPAOjjDaV99M37gCq9EZET
 U1XjGyO20maE7XcOp+agRnRFiqt1GgVPUA8azDUUQfhOLpjuiRzUHLkzitDu2HCfI9GcA7ts2id
 2EE3yJOUSeKdPlRhGAW7Hhj7SElvWDggrEfkV7OflbfQfuj80anKA=
X-Received: by 2002:a05:6830:82f6:b0:821:80ae:17a6 with SMTP id
 46e09a7af769-861527640b3mr2418270a34.27.1794514428218; 
 Thu, 12 Nov 2026 12:13:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a4e4csm613222a34.8.2026.11.12.12.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:13:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Frieder Schrempf <frieder@fris.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
Subject: Re: [PATCH v2 00/12] bootstd: rauc: Fixes, partition names and
 built-in boot command
Message-Id: <179451442703.966571.13362324484529346831.b4-ty@konsulko.com>
Date: Thu, 12 Nov 2026 14:13:47 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 17:20:17 +0100, Frieder Schrempf wrote:

> This series fixes some issues in the RAUC bootmeth and adds two
> options to make it safer to use on real devices, together with tests.
> 
> Patches 1-4 fix bugs in bootmeth_rauc.c: an uninitialised pointer when
> a bootflow has no block device, a leak of the active slot name, a stack
> buffer overflow with long slot names in BOOT_ORDER, and a leak of the
> boot script when a boot attempt fails and is retried.
> 
> [...]

Applied to u-boot/main, thanks!

[01/12] bootstd: rauc: Initialise desc in distro_rauc_scan_parts()
        commit: ba04ce9bf8917fc445011af06bc52a19480f6ffe
[02/12] bootstd: rauc: Fix leak of the active slot name
        commit: c41bafb348c31025b13d545d9c8cb884565644ed
[03/12] bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
        commit: ffc23ed61795699070bdd5d0b401b1b390ae192d
[04/12] bootstd: rauc: Free the boot script of a failed boot attempt
        commit: 20b5083334c6e5c6c617cb4fce34c6c4e8e18ac4
[05/12] test: boot: Restore the bootdev order if the RAUC test fails
        commit: 046d25230db117bd037035aa4ec00c62ab8abdae
[06/12] test: boot: Test booting a RAUC bootflow twice
        commit: acf2c9b7952f4e93b585f2387672645c9fdaa51e
[07/12] bootstd: rauc: Only set the RAUC variables for a RAUC device
        commit: 48dd34a34ebf33a58bad7b51882a7e26c97ce719
[08/12] bootstd: rauc: Optionally find the partitions by name
        commit: 4ca14703dc38a33110619ff1b41671dde2714548
[09/12] bootstd: rauc: Optionally boot with a built-in command
        commit: 3cf09c8b5033c85310e4a8f77874731b19da0995
[10/12] test: fs_helper: Support GPT in DiskHelper
        commit: 17defa32cbe0afdd83178150a20cee24769e0fb0
[11/12] test: boot: Test finding the RAUC partitions by name
        commit: 7107800ed761a77e51f89f7217f62cf9f09e5fbf
[12/12] test: boot: Test the RAUC built-in boot command
        commit: a44a9004c1cd79ac638e6804258242be036c0d88
-- 
Tom


