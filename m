Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB7606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zplMkUK1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rAc5KXsm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 216E5405AB;
	Mon, 16 Nov 2026 16:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1ZhHyYKKjHx; Mon, 16 Nov 2026 16:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55D5F40585
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846640;
	b=ZRUwkMtJi00G+zBD4RpNNGTsjiYUAAcn3ORMbVyghbVhHLiXdrmmUaWeDHFUImztOprN
	 xikD++PuNK0gZEM5HTIjXnHv54GGAdmjX4p3IHhHVOWAfkTcl6lXsxKK9n+Tw68mRMjvP
	 KOs20yLiMNDve3gw2HjAQHOCRZduU/2I2wBk/MZs7lmSOvINYRKVV2buJXjgoOjj5JoDb
	 9xNrnaoV4mKF7/Vmza5Tc3nKzgnQmQW9c9pqm4BGMEM1F/WGNqF3NeWviCi34KjQxZpHH
	 0Ii78ex9k9BSyhiOuUX97+XcWXJ1t8jS0I1kesaBOAxfDjKR6MGTkEOS2oz8egBJa6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NySvmkGp1RxD6sMzhJnDatOi8YA5ff9AsoHmXQ3BHcI=;
	b=rQmfqRgbWiD+6r9FEIWpG5Q95goErlndvx1045yKu6urJ6GnmGWTZENgvHJbkfVmK0uB
	 i1HnKDyb0WLrt3TFneWKxhKgqQzWzbirF4oO4SaPO3sYUCuP9Oe6saYDWw9h8S08KsX5i
	 afJSS5y4GCdwQGYkyWciq+Rnxjjw8pRroI27PI/3fncjeVc7zIraBdLDIPLesWcmsLMJb
	 LW69Ftrm2KPcgiSbV0AtcO1fvKpy09Ytu+8Ke4PEsz2vuVerOH6hu8hgu7MgL3KeQ5YNV
	 MvLdIUtQ5kah5+wA1Pyd8bQoTWDx1OaSYBnIF0eo+XinPG+f/E8b+dlspMwuj2q6+gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846640;
	bh=NySvmkGp1RxD6sMzhJnDatOi8YA5ff9AsoHmXQ3BHcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zplMkUK1+4tm8UssRyNh3ks2fil+sebey70D/tKeW3gCN8UtCLqVf+DEhQL50rumh
	 G8TM+jl8zxwHHMEtuBN1Qo4OZlaAnnYM0DeIfkIMoiRIHWbNoGhDyLpgu/lGgjY4ZT
	 0fZoSyopN9kkT1TmE0WwfzIhuMEp93a2ST0PwZkNbdqFjP/PldB3CsNCJfDbWq7Ens
	 6EkNtudc/hbv1Vtv9MensT4BN9uoaAypwW01yxyoQ5DEPhT1n61NAToUqfn6aJE99U
	 DnGw0Rf125m8cKTJM6ta6ytLEhrseuubaL77CKguIOBNzCqZUfRLP8JkUf9LwGl3Nx
	 A49q2hlnOnsTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55D5F40585;
	Mon, 16 Nov 2026 16:30:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 44A43176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A3F1402B0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jpb-GGYVfx5X for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:54:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5CBB64029F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rAc5KXsm
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CBB64029F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:54:53 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-71ad5f20016so1113813eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794840892; x=1795445692;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NySvmkGp1RxD6sMzhJnDatOi8YA5ff9AsoHmXQ3BHcI=;
 b=rAc5KXsm53evq19ocERNdQCC8Blxza/QT11q0uFJr5cC4kZnf1/wWy0zSma6ul7aCL
 8x+nSjEZ7V8V3wgqmI0ci9m3+RRqYV0vi6/H+Tn06P+pbkvz/Hb18J8dabZ42P/BLMet
 2WpJ8I1XwwN2imypieTt7jV91QqccVjTGPzGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840892; x=1795445692;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NySvmkGp1RxD6sMzhJnDatOi8YA5ff9AsoHmXQ3BHcI=;
 b=JZ4KFiJxbE0l8SqDBIRWT4OXTxwlCYYc85xlfy7hhm16eZwzyG0AZlPmMHwg3bEHVe
 RQkqhbf4KhiZ2oR1+kEqZ24Qwa97owG58e58tC765oWJbteyspQoNaIyegYRUo78wBBK
 ZsY0MOaYyLFsGrOZeXhLBmGQJ635/uD4U0sXEPLFH7dZwtOZS++2ens0Y/jkNQI63muA
 /bLU3A68T9rw8Ef2B943yEZPFJ0LVJv8sxgstsBK0IUJhdL/BALCBLkhF4SX0dR5Tuq5
 qqo1tuaUMyrn//mvqfxAMcmDYyGgjQh7PuOXVDlw/n+tdBX9Ps4ck9NLJEVooim6nHS7
 tQsg==
X-Forwarded-Encrypted: i=1;
 AL+hErE8NKFFDb4uZm5qUw9xVPdUILCP65HP+5so22Z1SdhBGnvQwpW0VVBCVHWQOw1liqDgSST3NIo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8zmMTNwDjw9j3jCRPvSQaRFi+x5LiSDF6kNoDuCu9MpF4UQ++S
 sOCczQ01fO7Ix68DM+ZjuhQ4lsi09vgb3DOuCxCTgDuCASLbnmSMlCPMTjSPzmJ8x8U=
X-Gm-Gg: AYBFou2YZJJPe0TcD0yP6xaJyGHL0bIKPKT8+rBzkpYQWMy0Jmc9HX0CELU3fWtwhBT
 iyWqP8jDmArNOgvgba2IvCdQj1ItcHSRAWBlNQPkBZqPOBouzELbDXRf+0ss41znx01QDfLWajP
 fZK+NvvSFBIMwO003VnPZjGK+ycWa/xVXjMMJyfagrLXDvKHPLbv5TFMued5lViR5qDb/PySSfC
 fkFAvwXgEAuBN/+zEKdJGVGX9lCAOkYwmKnKgPDInzPIaGj7SPNP4+eyvh53B29eNEeWEUWmxNH
 t7uOni2IvZFAvV0vMk+Qu7mR+bBX4H0Rk/CS2h5OTGQhTAMFd0esVRvWSLteDwGyMfcm29hDr4H
 wsfjJf21ucE/mSBZfwXVU1MkoprP1wtUzJqRBSxFlNyv69W6osBlM9+mCGwC6DzEX3pAzlzVrAf
 EkyJJlHPaz5ZaAIZ0UeLNv4z+4EebjpZ2TiHMXyO/4D1UzpkHT5DzirMSPb0LlAddcdzONh0dwo
 np2T9l5R2b0pxN+wfBXLbXslfvDLSRRORgJ8/oTotqnArxzXegj0Snsm1Hvh+4MOK8vW+uWb2b2
 pNBJtNZJBGIY9WRV3cRJnCpccNFPhfLuhVJB8KvfB02F3EkfUmRSLyvkPsBL2eJ3Kmtt2gHgAk5
 g03tuIKT7s93BtJfYgm3bH7PNx39vzsmy9hKzug7AHJAEBGEHEGW/jpx4IRhQm5pbHbnYUqWeEV
 jqcUPmSrK8uqsnBdpGbDNvkCgVtEeGTg==
X-Received: by 2002:a05:6820:f016:b0:71a:ce4f:4a7b with SMTP id
 006d021491bc7-71ace4f77fcmr4531594eaf.0.1794840891981; 
 Mon, 16 Nov 2026 06:54:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ae6868fc2sm4482988eaf.2.2026.11.16.06.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:54:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
Subject: Re: [PATCH v10 00/24] am62: IO+DDR resume support
Message-Id: <179484088932.2109674.11876642701070378442.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 08:54:49 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:30:39 +0000
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

On Tue, 03 Nov 2026 10:55:46 +0100, Markus Schneider-Pargmann (TI) wrote:

> this series introduces support to resume from IO+DDR. IO+DDR is a low
> power mode of am62a and am62p in which nearly everything is powered off
> except DDR which is in self-refresh and a few pins which detect
> activity and can wakeup the system again.
> 
> On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
> it is, the DDR initialization sequence in k3-ddrss differs slightly as
> it has to get the DDR out of the self-refresh.
> 
> [...]

Applied to u-boot/next, thanks!

[01/24] arm64: dts: ti: k3-am62a-phycore-som: Fix wkup R5F memory region size
        commit: 7af795a1179dfa782f79e6e6792f0902a55a02b8
[02/24] arm64: dts: ti: k3-am62d2-evm: Fix wkup R5F memory region size
        commit: 63cdfa2df0ddc691ffbf272db21253ce2f67f793
[03/24] arm64: dts: ti: k3-am62a7-sk: Fix wkup R5F memory region size
        commit: e7e1efc37a3f418d5bc46959d2964b10600b1f8b
[04/24] arm64: dts: ti: k3-am62p-verdin: Fix wkup R5F memory region size
        commit: 47a399a23038fe6273e8410913789c96182c511b
[05/24] arm64: dts: ti: k3-am62p5-sk: Fix wkup R5F memory region size
        commit: 7dd9dcb412d22e9f32570b86d71b3ad8e56367c8
[06/24] arm64: dts: ti: var-som-am62p: Fix wkup R5F memory region size
        commit: f27694f7ae4927b67d079c1f8fa3d18400b363a3
[07/24] arm64: dts: ti: k3-am62a: Split r5f memory region
        commit: 50890d63d29076122e5d886b3e2cf563870f4726
[08/24] arm64: dts: ti: k3-am62p: Split r5f memory region
        commit: 3d887790b88233da4be33cb7e06bf6f11392cf5a
[09/24] arm64: dts: ti: k3-am62*: Add wkup R5F nodes to pre-ram bootphase
        commit: 760ffb01d979c74a3bc8bb1d813809550cfcc161
[10/24] arm: mach-k3: Kconfig: Add symbol for IO+DDR Low Power Mode
        commit: 4619afbac2e9634a123a85d8f2d43763fd1b5bf6
[11/24] arm: mach-k3: am62xx-lpm-common: Add CANUART wakeup check helpers
        commit: f3619c18f9c81ff8bebb14633b93c7a0411c9f70
[12/24] arm: mach-k3: Remove CANUART IO isolation
        commit: c5992801aa6d3125725bf57a0b4f7052e281a1e5
[13/24] ram: k3-ddrss: Add support for DDR in self-refresh
        commit: 82c19a5f597eed232801479e9fc99a063b01726a
[14/24] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
        commit: dc5e1595ce4d411285ba3bc56b90d5b7ae3f6080
[15/24] arm: mach-k3: am62xx-lpm-common: Add lpm_resume_from_ddr
        commit: 8b90cae794b181a30047993c30533637d2d83206
[16/24] arm: mach-k3: am62xx-lpm-common: Helper for LPM meta data address from DT
        commit: 25b5301c11a757e7133e17e22f4cf6444d7ce529
[17/24] arm: mach-k3: am62a7_init: Resume on LPM exit
        commit: fdcdd6248a6a10ec36c687c7838dfa6e143fe7dc
[18/24] arm: mach-k3: am62p5_init: Resume on LPM exit
        commit: 92f3686a427851623f5d2ee88b5225e5bf9f2a7b
[19/24] ram: k3-ddrss: Add workaround sequence for errata i2487
        commit: 7942f37926c7cd38fc6138fb4f290c06e39b34c1
[20/24] arm: mach-k3: am62xx-lpm: Add 32kHz LFOSC enable function declaration
        commit: 24ebe71f8abf950c49f7cb6cfa7577317bdc901a
[21/24] arm: mach-k3: am62px: Enable 32kHz LFOSC during LPM resume
        commit: 6e2dd52af5b59c7b3a5e48ad025a85fcc00e2b25
[22/24] arm: mach-k3: am62ax: Enable 32kHz LFOSC during LPM resume
        commit: 111b9a79c4de2ecfc15c37591bc4f9536e80f8d0
[23/24] configs: am62ax_evm_r5: Enable IODDR resume support
        commit: 3f75dad4dd9277b8eeb0c2f757fab2a0fa228dc1
[24/24] configs: am62p_evm_r5_defconfig: Enable IODDR resume support
        commit: d1943bc30b28a103e3e92667f23e6880f4909462
-- 
Tom


