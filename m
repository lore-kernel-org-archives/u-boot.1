Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83546606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eZvRvHM0;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=rj6RBL/b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61F1460606;
	Tue, 24 Nov 2026 06:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFZD-e7NB69U; Tue, 24 Nov 2026 06:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF74B606E5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795502197;
	b=CLuoSIzs3T2bXCs/pj+0tdDy1FTkSupfGH+lGOXOZJhvJJwNmaMJoTwLw2g7Qm4QxoaC
	 kchBO6uS63KBBWOkMOzuCR+e28d4uD3ozeKw7XdfN/znXYPZaINNwzwJSHrpR8lQOgWur
	 Lh5kcTiX7SbTvZt+S+s01T07+QuVALpMDK00apIBdsOvOtPj6FlZ2a3vAR8vGDXWww7Cl
	 cR4LWvW5MNU5NdWsJcNqaAIRz+KJP4FtgFkjlsJbHWkEbMjafoo+VyJFTAJ8oQ2FzSS8T
	 yj42h3HEo1gzOxDRXL18QXWqmMFIjR2aSB3AilzS/3YWYfI3clUjfwRZGu/tQvoRimw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795502197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i4CbxcZWFFAGhXJ4VU2jdXtCOByZ21GFEgij4B7xv9I=;
	b=MOBbAvFaMEtilG2gEMwFNVm2n+M5A8K+SGvz/r891NXOcwuA4c8Lae6cQeFAdXfc6hzN
	 OVTTbhnSZmuaxbAWzgdNzmgmdUnTYqlhl+BrfeoIL8pcRPx2ZBkQcmYxNbkV74rkiLlkF
	 FgDMbbeElaRUZSfNlsdpdUH/m4qdoeCkDTWQoaZpHXK42rkEwph2SrWu/DT5q9aSy7jmZ
	 SDw1JFjewwCowZCEGyrsdC3pDMhWJycuXva8dxHXCy63tzPeXctvO14fNlueehgw6duwA
	 WdAHT/expGXALV+LaFDsoznXzh9QvfCYndpboIMZVDWsp77hi2M2EUDXJ8OPQQQ62Ow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b="rj6RBL/b";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795502197;
	bh=i4CbxcZWFFAGhXJ4VU2jdXtCOByZ21GFEgij4B7xv9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eZvRvHM0GbH5XSknfrTuhklGDdiojX0KRduyy8W6k7grOHBm2xI43D8xURUTMxUaM
	 3+xNaofghWYc7NqstJPI6X0uNyssEZFpZNHqu3HxnaDgqK3uKzx1AJZ8q4BsbWifqJ
	 cTjV2QFiFfBS1UWspLS32Tnm3aK7ywt6e73LJyV4K8WZeo9QUvgiV2QuWyf8IJsWTg
	 AcN/MEeu4++SkdBNh3T9LpQ6wqVmBnrxjitSwqrxxdq3fC4zSzsBDNGARmKNqQGM/3
	 A3wjXdM6H/s8H7SRcSb1N6XVfV6emQ9M6ZMkhRDP36n+kBNzgSwNtdpBCrOtsoDfQ8
	 oNJj6l8r7CSpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF74B606E5;
	Tue, 24 Nov 2026 06:36:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB7F61AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF0A0606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WzURiYyJkm6 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7597460606
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=rj6RBL/b
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7597460606
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:36:32 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 168121F935;
 Tue, 24 Nov 2026 07:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1795502187;
 bh=i4CbxcZWFFAGhXJ4VU2jdXtCOByZ21GFEgij4B7xv9I=; h=From:To:Subject;
 b=rj6RBL/bABGDrDuH7KlMsK0W1dTOL2HL0VOmp57mhVOSwmxyzSRbBO7l/kqI9Gp6A
 b2QnDVeNqxQp9hRtfs/oW0izQcE6nobcRQDhHHRdNh2/O3S5HDGYt7g7sMWcc5sigS
 AvP+o4pPVhRayWnimspBV2H4k1QX0mJJLAfxxE23UFzb9roRhr+yF3pn3j2uBZ0AMN
 0PDQ83tuCHMq1O2fOEKlMyJHXnYhCqAlXxQm0VB6zhYkqAAmEgBFc+9b5ERxHkjoPc
 E4rjgIhEvWQBbSm4tX1WmBlziEYfnnzmHt3vhvTNVeuR3tXiWoOeUl+FukLh/PQ9X/
 SMJbe3g2Zj2ig==
Date: Tue, 24 Nov 2026 07:36:22 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Joy Zou <joy.zou@nxp.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
Message-ID: <20261124063622.GA5917@francesco-nb>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
 <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 10:16:20AM +0530, Kumar, Udit wrote:
> Hi Francesco,
> 
> On 11/23/2026 3:41 AM, Francesco Valla wrote:
> > The TPS65219 is a family of fixed-function PMICs for which the output
> > configuration is determined by the part number. For this reason, usage
> > during the SPL phase is unlikely.
> > 
> > Add a SPL-specific option for the drivers of the TPS65219 itself and its
> > regulators, to allow its exclusion during the SPL build. Since none of
> > the supported platforms that have this PMIC onboard modifies its
> > configuration during SPL, default it to N.
> > 
> > This fixes boot hangs on the boards compiling this driver but that don't
> > have the regulators sub-node marked as bootph-all; since commit
> > 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
> > this absence was leading to a silent boot failure.
> > 
> > Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
> > the same configs, so it's affected as well.
> > 
> > Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
> 
> Thanks for update,
> 
> I see this PMIC is enabled for below boards,
> 
> configs/am62_pocketbeagle2_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/am62x_beagleplay_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/am64x_evm_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/am67a_beagley_ai_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/verdin-am62_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/verdin-am62p_a53_defconfig:CONFIG_PMIC_TPS65219=y
> 
> 
> I am wondering, if PMIC is really needed here,
> Do you see possibility to mark PMIC as N in respective board ?

Verdin AM62 and AM62P are booting fine with
U-Boot 2027.01-rc2+git.eb7af371cb8c (Nov 23 2026 - 15:22:38 +0000)

No bootph properties on the PMIC node, and I guess also not used on the
SPL. We could save a little SPL size disabling it.

Are you sure you need to enable the PMIC in the SPL? For what is needed?
Setting the sdcard voltage to 1v8 (I do not know these two beagle
boards) ?

Francesco

