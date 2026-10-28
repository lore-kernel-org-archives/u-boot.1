Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AD606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gSrpz5X/;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ijJw+baG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B7D8125F;
	Wed, 28 Oct 2026 14:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnKz3UZr0XY7; Wed, 28 Oct 2026 14:48:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4209E8110D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198822;
	b=OtxRhkyLJQ1XRr4d55msLRhzTjl7jeYF2MwrlrpJtKJg2Q4TQDApX/2mP64ZWp2klZs0
	 exGKtLRx2m6d7Np2offpydaMQ7/qE0Ny6HgQuj3X6fi7coaYBISfb03GWdlojd602QMoT
	 rQdimLPT45514m5FkY58rIl3r33N6fhlCZ85XUMqcKvzv2vTfbZBXuZQHoP9Bym4p+ikS
	 YSCF0YF+caNIb+gg2g3ZFXUBhnEWXc+qH63gIcaZMubmIhzyXbcdFmUp8v9BHLbyHzCVc
	 z5s3HkMw+dbM7MvGimpCV34mTvKi3Owo0N0NOvkxJmOdUtvoc8y3sfUs11O22hWOnBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SqV+45yMNSgpTsOM5XcU4u5vo+UVUV/XrS1iWomXVpE=;
	b=E8q9QRBJvN+BM2GVlwknRZEdbvuY8H9zrvJQSsMvPKdFI9oWOJYlwotpAx+yMJZe7iR+
	 j9mOPGzfck2kXnWXV7f+R0jWjI0aNPWAIP/hN8wv2s5Y48Vst0Zxg8fTcMDWUcmG0k8of
	 kVWnNc6cTL9Jee2OqW5bH8Pt15JCK815YT8oYM/jIG/sVoNp57n4kNN82kXgNO39jstPq
	 o+PCBEUS7yU0BXB2MW7Io3lY3IBNbnoN1qKcdfexkUaDYLogeUiaBKxPpQXPyIvz/p7EN
	 uFLIn+w9I5Wmgt9ULVW7zGRAjA7iuTqqufuiubKDcZddcPoDI2n42fET+QYImTd3uUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198822;
	bh=SqV+45yMNSgpTsOM5XcU4u5vo+UVUV/XrS1iWomXVpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gSrpz5X/rKAA9UldEK0gBrCw40PeZFxOHDv92vX8KVMN4VR8CVq4OkCrzhXgjxnsq
	 GQwNDywj88qlySPORuB8gL6Y5EaRKCWCATEue5LdF58czL2WiiW31oEEb5nau2hNqQ
	 q59vvRWoZsMUz3ukXWrxqhfmR2zBuab2OPnsiW6bREO3YfJHNxr8BsWUx/TgO2xWmk
	 78y0GykTpbcNH+rUTREjfHRw0K24j7wuJ0fvzvHj5b9uutf78zpzMyJtP1C0+ziTyo
	 r6vdJKzGPrkmzP/Z+GjGms7afeqwt2x0NbBpk46woG9dSHt30QUs6b25oHYl/WmZwu
	 tNI7YNj1klmmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4209E8110D;
	Wed, 28 Oct 2026 14:47:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58186356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FB9B6060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upT5sCy5SluW for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F1ED605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196752;
 b=VdHGUVIe2EQM1r+TEeoH0T1suXTkj0Joi8C9wSzbYqqjiXG+hooyrndx9St2IOvW8O5O
 en+EwNFoASlwcy6g0fhxsLRWSEE6BmFYLrdcHKAzkj344fsOwaO/VJCCVM/E+DOUad5YW
 t2TdJ/uwggfBzuD8xeD+7/N7OIVocdSy5j1sa+Y3voCmbqo4yWxnxpRAuWqOoP0LkfBft
 xCj87XUdj3gshGEuJ1xqD+xaCu3Cq25pkY6HcKmPC8doV9Lv4BjVv/NXtj8KNRNbLBkKd
 rzEY4HU/vUcj0zjnbER3cZLy8OQu45a4AyA9JeM8nI9qBWJlFSLwjF2fI7OUUX/RVoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196752;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SqV+45yMNSgpTsOM5XcU4u5vo+UVUV/XrS1iWomXVpE=;
 b=Ojt+8SA2zDcen7cZDUGAkwF9GOrsYqDEUQP1BeRSVwDwemb6Zwcq29rXbg/yVgVcTMNe
 nt+uFmJDurTW24qPl2tHXQaxYw+xiO4GXEjeltDLRDfpEXmMBMIUtQUpSsP9IlAZSGbIw
 7xNJKChx3mryHIwFhc/lL9Fnf1fOdEOpNhatqa1Psid5nwcyfkseymJQwVPeMzS3gQmF0
 cVVxx3SMY+vfXXo5RniPNxFidtA5qAv+stnD50Uo4euBPkuk9w1zzZQt11LyFGzAvtL4B
 g4csOits3X+/R4fmDL3KA46ao7ju4EAHye3Q8k9kuMqBD6dahpc1U7zvNWy7POVzikA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ijJw+baG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ijJw+baG
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F1ED605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:31 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c499b5be0f1so11795966b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196749; x=1793801549;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SqV+45yMNSgpTsOM5XcU4u5vo+UVUV/XrS1iWomXVpE=;
 b=ijJw+baGUkcJ4smqeFIqepfuD4iUXnDawwaotkFW5gba3ny94/+dy8c7idJFW55ywE
 DFzeMrBq1CRDxREsYDsAi8QdZcl1p0cmpb33W3ZVOCbMxScazPuwS6aEvQY5iK20PGRt
 dRvpkyrlBskOoDLSQYv/OVksUww+mwvrYIXl5cXXIZSAZj1PLbxgJeB+k2bjBrn21Xwp
 wwajDVDup6ACIenTU4Rik2/LtdgG8G5Z4WtGs1dRVEpDk+I+QA+pm9L3GrmhwRHTP788
 olBXhS7LkMBp/eS7aa678sq2of3b/KVD+uEAwwSUJoEgxVMSOSddE8afnPclK+fjNWt3
 DG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196749; x=1793801549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SqV+45yMNSgpTsOM5XcU4u5vo+UVUV/XrS1iWomXVpE=;
 b=ao2h/ne+NYlObRiMREq8kfyujT3/5vR4U1jbx+A1sYY8/IrzynSEG24N5OFRio49Vm
 FKKEOnqIb+J7CjcRLlGtAeLjb7YCcm4meKqxfSNkRKUFIow4rLawOj8+aV3SywRlDE0/
 XS0Z0ol1oTlP2f6UE1ixg/t3sKLNnE5WZ3O9moMQ2ZC+ihYadkUcqDoV3s+CMKZ1/8OK
 0MiZh3xHaEwQ7MWJ4jcLeCoeCIetxwCyqt5UECi2VBZAQRAWBXgHWdtbsJv/jTPO4N+B
 pdD0JRgmHdbg1c499dnUUazJgC3wiVqTI4GKO5pcoz58CAdTe8hLo5rRF93Yy+X4PJL8
 itDA==
X-Gm-Message-State: AFq9FYLS+3DRD2+9dUl4YCUjufMLQOnaCEiBihTJgk6FQuJbSa6a799a
 rZ8h8pdhPrQ2oos+koueB+11DtudPe8Dlc3/dXQidufD4XNqve/Xnu2WXqDh8vh+Wt0shRqHQok
 MPs19
X-Gm-Gg: AYBFou3xPDSp2hqILxh+3eUtwsAnR4XZobFBDCCaEcOQHfthp40vMNcK1qmnZZovBZn
 aF5MfIInU9wTU0vG9ozZAWEoV2Lry4aDOXcHq+yLxR9OMyG2jqzlTiGZKuFmR6IpU9xkpTq9esB
 NMcUyUYa+GLDE2pAFixEm6fewfC5Ib9APg8rle/Nzcl2GhN4DTOnH5akqghcXu8ZIGY71ih3DTq
 y/uUoJCgVPVGcf60eLy95W85WNDqmxD8uPvcAYyZxjDZ4wmbG1Qc6epkv21V83WkpTYhRlFawFC
 74lv0XfsbYstM1cEk70iClclt9/jcnxs8+k7zjbqaVKg3XltvtbkFXPmkMephAzcnlWx4pB1XnB
 /VQU8g5zp/UzUvp0jEEMWIxcirt+ia400xwjZy6aQorehNH00CNyHQVUPc6XdTuKH4xbhlplUN3
 3WyMv3nlBVWMXoeijhhqmghmq0m1U+iyzJum0gGcrSFWam+ozqiNVsoVLunEEOep8HfyChcnoqS
 CNB5qtutye63Vycev0FzHZ5khHeUDk0VSDNdYUC/3r5vfWZIVjak8KAEkMHSZknnVv3S5qvA3TB
 az0erE9C1GNUaHqFyjKAOrqsxGLXpPqtiw+A5FE0s2jTyRIkQn1ed7OtCIkgzXjOEsQGaC5pTbl
 gV09dStvasPrS6Dyt+yOBVxqh1vt0JT0=
X-Received: by 2002:a17:906:fd0:b0:c40:b180:db3b with SMTP id
 a640c23a62f3a-c49bdf8d67fmr245429766b.3.1793196749130; 
 Wed, 28 Oct 2026 07:12:29 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:28 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 35/63] usb: dwc3: import from kernel v5.10
Date: Wed, 28 Oct 2026 15:09:01 +0100
Message-ID: <20261028140930.3025368-36-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.9 to v5.10.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.9..v5.10
Commits imported:
cbdc0f54560f usb: fix kernel-doc markups
fa27e2f6c5e6 usb: dwc3: ep0: Fix delay status handling
e0a93d98f488 usb: dwc3: gadget: Support up to max stream id
2338484d14f3 usb: dwc3: gadget: Return early if no TRB update
346a15cdf652 usb: dwc3: gadget: Keep TRBs in request order
8dbbe48c7a99 usb: dwc3: gadget: Revise setting IOC when no TRB left
f9cc581badb1 usb: dwc3: gadget: Look ahead when setting IOC
d72ecc08dee4 usb: dwc3: gadget: Allow restarting a transfer
ae7e86108b12 usb: dwc3: Stop active transfers before halting the controller
f580170f135a usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc
7f2958d9ad58 usb: dwc3: gadget: Rename misleading function names
cb1b3997b636 usb: dwc3: gadget: Refactor preparing last TRBs
30892cba5596 usb: dwc3: gadget: Set IOC if not enough for extra TRBs
490410b2e73c usb: dwc3: gadget: Check for number of TRBs prepared
13111fcb0d64 usb: dwc3: gadget: Return the number of prepared TRBs
66706077dc89 usb: dwc3: ep0: Fix ZLP for OUT ep0 requests
a2841f41d07f usb: dwc3: gadget: Improve TRB ZLP setup
2b80357b773c usb: dwc3: gadget: Refactor preparing extra TRB
690e5c2dc29f usb: dwc3: gadget: Reclaim extra TRBs after request completion
ca3df3468eec usb: dwc3: gadget: Check MPS of the request length
8266b08ed90c usb: dwc3: gadget: Refactor ep command completion
03c1fd622f72 usb: dwc3: core: add phy cleanup for probe error handling
266d0493900a usb: dwc3: core: don't trigger runtime pm when remove driver
e81a7018d93a usb: dwc3: allocate gadget structure dynamically
dc336b19e82d usb: dwc3: core: do not queue work if dr_mode is not USB_DR_MODE_OTG
e319bd62292c usb: dwc3: gadget: fix checkpatch warnings
87b923a2e059 usb: dwc3: core: fix checkpatch warnings
c64b475b8488 usb: dwc3: ep0: fix checkpatch warnings
035cbca1360a usb: dwc3: debug: fix checkpatch warning
27c7ab0fdd0b usb: dwc3: debug: fix sparse warning
e518bdd9f02c usb: dwc3: core: Print warning on unsupported speed
b574ce3ee459 usb: dwc3: core: Properly default unspecified speed
d97c78a1908e usb: dwc3: gadget: END_TRANSFER before CLEAR_STALL command
c503672abe13 usb: dwc3: gadget: Resume pending requests after CLEAR_STALL

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  92 ++++--
 drivers/usb/dwc3/core.h   |  49 ++--
 drivers/usb/dwc3/debug.h  |   8 +-
 drivers/usb/dwc3/ep0.c    |  62 ++--
 drivers/usb/dwc3/gadget.c | 593 ++++++++++++++++++++++----------------
 drivers/usb/dwc3/gadget.h |   3 +-
 6 files changed, 499 insertions(+), 308 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2eb34c8b4065..841daec70b6e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * core.c - DesignWare USB3 DRD Controller Core file
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
@@ -119,9 +119,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	struct dwc3 *dwc = work_to_dwc(work);
 	unsigned long flags;
 	int ret;
-
-	if (dwc->dr_mode != USB_DR_MODE_OTG)
-		return;
+	u32 reg;
 
 	pm_runtime_get_sync(dwc->dev);
 
@@ -172,6 +170,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+			if (dwc->dis_split_quirk) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+				reg |= DWC3_GUCTL3_SPLITDISABLE;
+				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+			}
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -203,6 +206,9 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 {
 	unsigned long flags;
 
+	if (dwc->dr_mode != USB_DR_MODE_OTG)
+		return;
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->desired_dr_role = mode;
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -929,13 +935,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	 */
 	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
 
-	/* Handle USB2.0-only core configuration */
-	if (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
-			DWC3_GHWPARAMS3_SSPHY_IFC_DIS) {
-		if (dwc->maximum_speed == USB_SPEED_SUPER)
-			dwc->maximum_speed = USB_SPEED_HIGH;
-	}
-
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		goto err0;
@@ -1356,6 +1355,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
 
+	dwc->dis_split_quirk = device_property_read_bool(dev,
+				"snps,dis-split-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1381,6 +1383,8 @@ bool dwc3_has_imod(struct dwc3 *dwc)
 static void dwc3_check_params(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
+	unsigned int hwparam_gen =
+		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
 	/* Check for proper value of imod_interval */
 	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
@@ -1404,25 +1408,40 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	case USB_SPEED_LOW:
 	case USB_SPEED_FULL:
 	case USB_SPEED_HIGH:
+		break;
 	case USB_SPEED_SUPER:
+		if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS)
+			dev_warn(dev, "UDC doesn't support Gen 1\n");
+		break;
 	case USB_SPEED_SUPER_PLUS:
+		if ((DWC3_IP_IS(DWC32) &&
+		     hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS) ||
+		    (!DWC3_IP_IS(DWC32) &&
+		     hwparam_gen != DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
+			dev_warn(dev, "UDC doesn't support SSP\n");
 		break;
 	default:
 		dev_err(dev, "invalid maximum_speed parameter %d\n",
 			dwc->maximum_speed);
 		fallthrough;
 	case USB_SPEED_UNKNOWN:
-		/* default to superspeed */
-		dwc->maximum_speed = USB_SPEED_SUPER;
-
-		/*
-		 * default to superspeed plus if we are capable.
-		 */
-		if ((DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) &&
-		    (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
-		     DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
+		switch (hwparam_gen) {
+		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
 			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-
+			break;
+		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
+			if (DWC3_IP_IS(DWC32))
+				dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
+			else
+				dwc->maximum_speed = USB_SPEED_SUPER;
+			break;
+		case DWC3_GHWPARAMS3_SSPHY_IFC_DIS:
+			dwc->maximum_speed = USB_SPEED_HIGH;
+			break;
+		default:
+			dwc->maximum_speed = USB_SPEED_SUPER;
+			break;
+		}
 		break;
 	}
 }
@@ -1554,6 +1573,17 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err5:
 	dwc3_event_buffers_cleanup(dwc);
+
+	usb_phy_shutdown(dwc->usb2_phy);
+	usb_phy_shutdown(dwc->usb3_phy);
+	phy_exit(dwc->usb2_generic_phy);
+	phy_exit(dwc->usb3_generic_phy);
+
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	phy_power_off(dwc->usb2_generic_phy);
+	phy_power_off(dwc->usb3_generic_phy);
+
 	dwc3_ulpi_exit(dwc);
 
 err4:
@@ -1589,9 +1619,9 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
@@ -1865,10 +1895,26 @@ static int dwc3_resume(struct device *dev)
 
 	return 0;
 }
+
+static void dwc3_complete(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	u32		reg;
+
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
+			dwc->dis_split_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_SPLITDISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+}
+#else
+#define dwc3_complete NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+	.complete = dwc3_complete,
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2f04b3e42bf1..2f95f08ca511 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -138,6 +138,7 @@
 #define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
+#define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
 
 /* Device Registers */
@@ -380,6 +381,9 @@
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
+/* Global User Control Register 3 */
+#define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -634,7 +638,7 @@ struct dwc3_trb;
 struct dwc3_event_buffer {
 	void			*buf;
 	void			*cache;
-	unsigned		length;
+	unsigned int		length;
 	unsigned int		lpos;
 	unsigned int		count;
 	unsigned int		flags;
@@ -694,7 +698,7 @@ struct dwc3_ep {
 	struct dwc3		*dwc;
 
 	u32			saved_state;
-	unsigned		flags;
+	unsigned int		flags;
 #define DWC3_EP_ENABLED		BIT(0)
 #define DWC3_EP_STALL		BIT(1)
 #define DWC3_EP_WEDGE		BIT(2)
@@ -706,6 +710,7 @@ struct dwc3_ep {
 #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
 #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
+#define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		BIT(31)
@@ -893,9 +898,9 @@ struct dwc3_request {
 	struct scatterlist	*sg;
 	struct scatterlist	*start_sg;
 
-	unsigned		num_pending_sgs;
+	unsigned int		num_pending_sgs;
 	unsigned int		num_queued_sgs;
-	unsigned		remaining;
+	unsigned int		remaining;
 
 	unsigned int		status;
 #define DWC3_REQUEST_STATUS_QUEUED	0
@@ -908,11 +913,11 @@ struct dwc3_request {
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
-	unsigned		num_trbs;
+	unsigned int		num_trbs;
 
-	unsigned		needs_extra_trb:1;
-	unsigned		direction:1;
-	unsigned		mapped:1;
+	unsigned int		needs_extra_trb:1;
+	unsigned int		direction:1;
+	unsigned int		mapped:1;
 };
 
 /*
@@ -1010,8 +1015,8 @@ struct dwc3_scratchpad_array {
  * @has_lpm_erratum: true when core was configured with LPM Erratum. Note that
  *			there's now way for software to detect this in runtime.
  * @is_utmi_l1_suspend: the core asserts output signal
- * 	0	- utmi_sleep_n
- * 	1	- utmi_l1_suspend_n
+ *	0	- utmi_sleep_n
+ *	1	- utmi_l1_suspend_n
  * @is_fpga: true when we are using the FPGA board
  * @pending_events: true when we have pending IRQs to be handled
  * @pullups_connected: true when Run/Stop bit is set
@@ -1047,13 +1052,14 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
- * 	0	- -6dB de-emphasis
- * 	1	- -3.5dB de-emphasis
- * 	2	- No de-emphasis
- * 	3	- Reserved
+ *	0	- -6dB de-emphasis
+ *	1	- -3.5dB de-emphasis
+ *	2	- No de-emphasis
+ *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @dis_split_quirk: set to disable split boundary.
  * @imod_interval: set the interrupt moderation interval in 250ns
- *                 increments or 0 to disable.
+ *			increments or 0 to disable.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1079,7 +1085,7 @@ struct dwc3 {
 	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
-	struct usb_gadget	gadget;
+	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
 	struct clk_bulk_data	*clks;
@@ -1245,6 +1251,8 @@ struct dwc3 {
 
 	unsigned		dis_metastability_quirk:1;
 
+	unsigned		dis_split_quirk:1;
+
 	u16			imod_interval;
 };
 
@@ -1269,7 +1277,7 @@ struct dwc3_event_type {
 #define DWC3_DEPEVT_EPCMDCMPLT		0x07
 
 /**
- * struct dwc3_event_depvt - Device Endpoint Events
+ * struct dwc3_event_depevt - Device Endpoint Events
  * @one_bit: indicates this is an endpoint event (not used)
  * @endpoint_number: number of the endpoint
  * @endpoint_event: The event we have:
@@ -1456,9 +1464,10 @@ void dwc3_gadget_exit(struct dwc3 *dwc);
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode);
 int dwc3_gadget_get_link_state(struct dwc3 *dwc);
 int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state);
-int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
+int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params);
-int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param);
+int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
+		u32 param);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1472,7 +1481,7 @@ static inline int dwc3_gadget_set_link_state(struct dwc3 *dwc,
 		enum dwc3_link_state state)
 { return 0; }
 
-static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
+static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
 { return 0; }
 static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 3d16dac4e5cc..8ab394942360 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -371,7 +371,9 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 static inline const char *dwc3_decode_event(char *str, size_t size, u32 event,
 		u32 ep0state)
 {
-	const union dwc3_event evt = (union dwc3_event) event;
+	union dwc3_event evt;
+
+	memcpy(&evt, &event, sizeof(event));
 
 	if (evt.type.is_devspec)
 		return dwc3_gadget_event_string(str, size, &evt.devt);
@@ -411,8 +413,8 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 
 
 #ifdef CONFIG_DEBUG_FS
-extern void dwc3_debugfs_init(struct dwc3 *);
-extern void dwc3_debugfs_exit(struct dwc3 *);
+extern void dwc3_debugfs_init(struct dwc3 *d);
+extern void dwc3_debugfs_exit(struct dwc3 *d);
 #else
 static inline void dwc3_debugfs_init(struct dwc3 *d)
 {  }
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 59f2e8c31bd1..8b668ef46f7f 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -105,7 +105,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * IRQ we were waiting for is long gone.
 	 */
 	if (dep->flags & DWC3_EP_PENDING_REQUEST) {
-		unsigned	direction;
+		unsigned int direction;
 
 		direction = !!(dep->flags & DWC3_EP0_DIR_IN);
 
@@ -127,11 +127,11 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * handle it here.
 	 */
 	if (dwc->delayed_status) {
-		unsigned	direction;
+		unsigned int direction;
 
 		direction = !dwc->ep0_expect_in;
 		dwc->delayed_status = false;
-		usb_gadget_set_state(&dwc->gadget, USB_STATE_CONFIGURED);
+		usb_gadget_set_state(dwc->gadget, USB_STATE_CONFIGURED);
 
 		if (dwc->ep0state == EP0_STATUS_PHASE)
 			__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
@@ -172,7 +172,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * XferNotReady(STATUS).
 	 */
 	if (dwc->three_stage_setup) {
-		unsigned        direction;
+		unsigned int direction;
 
 		direction = dwc->ep0_expect_in;
 		dwc->ep0state = EP0_DATA_PHASE;
@@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		ret = -ESHUTDOWN;
@@ -325,7 +325,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		/*
 		 * LTM will be set once we know how to set this in HW.
 		 */
-		usb_status |= dwc->gadget.is_selfpowered;
+		usb_status |= dwc->gadget->is_selfpowered;
 
 		if ((dwc->speed == DWC3_DSTS_SUPERSPEED) ||
 		    (dwc->speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
@@ -450,7 +450,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 
 	wValue = le16_to_cpu(ctrl->wValue);
 	wIndex = le16_to_cpu(ctrl->wIndex);
-	state = dwc->gadget.state;
+	state = dwc->gadget->state;
 
 	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
@@ -524,6 +524,11 @@ static int dwc3_ep0_handle_endpoint(struct dwc3 *dwc,
 		ret = __dwc3_gadget_ep_set_halt(dep, set, true);
 		if (ret)
 			return -EINVAL;
+
+		/* ClearFeature(Halt) may need delayed status */
+		if (!set && (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+			return USB_GADGET_DELAYED_STATUS;
+
 		break;
 	default:
 		return -EINVAL;
@@ -559,7 +564,7 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 
 static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget.state;
+	enum usb_device_state state = dwc->gadget->state;
 	u32 addr;
 	u32 reg;
 
@@ -580,9 +585,9 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
 	if (addr)
-		usb_gadget_set_state(&dwc->gadget, USB_STATE_ADDRESS);
+		usb_gadget_set_state(dwc->gadget, USB_STATE_ADDRESS);
 	else
-		usb_gadget_set_state(&dwc->gadget, USB_STATE_DEFAULT);
+		usb_gadget_set_state(dwc->gadget, USB_STATE_DEFAULT);
 
 	return 0;
 }
@@ -592,14 +597,14 @@ static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	int ret;
 
 	spin_unlock(&dwc->lock);
-	ret = dwc->gadget_driver->setup(&dwc->gadget, ctrl);
+	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
 	spin_lock(&dwc->lock);
 	return ret;
 }
 
 static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget.state;
+	enum usb_device_state state = dwc->gadget->state;
 	u32 cfg;
 	int ret;
 	u32 reg;
@@ -622,7 +627,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * to change the state on the next usb_ep_queue()
 			 */
 			if (ret == 0)
-				usb_gadget_set_state(&dwc->gadget,
+				usb_gadget_set_state(dwc->gadget,
 						USB_STATE_CONFIGURED);
 
 			/*
@@ -641,7 +646,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	case USB_STATE_CONFIGURED:
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		if (!cfg && !ret)
-			usb_gadget_set_state(&dwc->gadget,
+			usb_gadget_set_state(dwc->gadget,
 					USB_STATE_ADDRESS);
 		break;
 	default:
@@ -697,7 +702,7 @@ static void dwc3_ep0_set_sel_cmpl(struct usb_ep *ep, struct usb_request *req)
 static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
 	struct dwc3_ep	*dep;
-	enum usb_device_state state = dwc->gadget.state;
+	enum usb_device_state state = dwc->gadget->state;
 	u16		wLength;
 
 	if (state == USB_STATE_DEFAULT)
@@ -741,7 +746,7 @@ static int dwc3_ep0_set_isoch_delay(struct dwc3 *dwc, struct usb_ctrlrequest *ct
 	if (wIndex || wLength)
 		return -EINVAL;
 
-	dwc->gadget.isoch_delay = wValue;
+	dwc->gadget->isoch_delay = wValue;
 
 	return 0;
 }
@@ -942,12 +947,16 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req)
 {
+	unsigned int		trb_length = 0;
 	int			ret;
 
 	req->direction = !!dep->number;
 
 	if (req->request.length == 0) {
-		dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 0,
+		if (!req->direction)
+			trb_length = dep->endpoint.maxpacket;
+
+		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr, trb_length,
 				DWC3_TRBCTL_CONTROL_DATA, false);
 		ret = dwc3_ep0_start_trans(dep);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
@@ -994,9 +1003,12 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 
 		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
 
+		if (!req->direction)
+			trb_length = dep->endpoint.maxpacket;
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
-					 0, DWC3_TRBCTL_CONTROL_DATA,
+					 trb_length, DWC3_TRBCTL_CONTROL_DATA,
 					 false);
 		ret = dwc3_ep0_start_trans(dep);
 	} else {
@@ -1042,6 +1054,18 @@ static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
 	__dwc3_ep0_do_control_status(dwc, dep);
 }
 
+void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
+{
+	unsigned int direction = !dwc->ep0_expect_in;
+
+	dwc->delayed_status = false;
+
+	if (dwc->ep0state != EP0_STATUS_PHASE)
+		return;
+
+	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
+}
+
 static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
@@ -1102,7 +1126,7 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 			 */
 			if (!list_empty(&dep->pending_list)) {
 				dwc->delayed_status = false;
-				usb_gadget_set_state(&dwc->gadget,
+				usb_gadget_set_state(dwc->gadget,
 						     USB_STATE_CONFIGURED);
 				dwc3_ep0_do_control_status(dwc, event);
 			}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c2a0f64f8d1e..78cb4db8a6e4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -227,7 +227,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
  * Caller should take care of locking. Issue @cmd with a given @param to @dwc
  * and wait for its completion.
  */
-int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
+int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
+		u32 param)
 {
 	u32		timeout = 500;
 	int		status = 0;
@@ -268,7 +269,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
  * Caller should handle locking. This function will issue @cmd with given
  * @params to @dep and wait for its completion.
  */
-int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
+int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
@@ -290,7 +291,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 	 *
 	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
-	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
+	if (dwc->gadget->speed <= USB_SPEED_HIGH) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
 			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
@@ -422,7 +423,7 @@ static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
 	 */
 	if (dep->direction &&
 	    !DWC3_VER_IS_PRIOR(DWC3, 260A) &&
-	    (dwc->gadget.speed >= USB_SPEED_SUPER))
+	    (dwc->gadget->speed >= USB_SPEED_SUPER))
 		cmd |= DWC3_DEPCMD_CLEARPENDIN;
 
 	memset(&params, 0, sizeof(params));
@@ -562,8 +563,9 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		| DWC3_DEPCFG_MAX_PACKET_SIZE(usb_endpoint_maxp(desc));
 
 	/* Burst size is only needed in SuperSpeed mode */
-	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
+	if (dwc->gadget->speed >= USB_SPEED_SUPER) {
 		u32 burst = dep->endpoint.maxburst;
+
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst - 1);
 	}
 
@@ -942,12 +944,13 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 }
 
 static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
-		dma_addr_t dma, unsigned length, unsigned chain, unsigned node,
-		unsigned stream_id, unsigned short_not_ok,
-		unsigned no_interrupt, unsigned is_last)
+		dma_addr_t dma, unsigned int length, unsigned int chain,
+		unsigned int node, unsigned int stream_id,
+		unsigned int short_not_ok, unsigned int no_interrupt,
+		unsigned int is_last, bool must_interrupt)
 {
 	struct dwc3		*dwc = dep->dwc;
-	struct usb_gadget	*gadget = &dwc->gadget;
+	struct usb_gadget	*gadget = dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
@@ -1031,8 +1034,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
-	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 1))
+	if ((!no_interrupt && !chain) || must_interrupt)
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1057,19 +1059,24 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
  * @trb_length: buffer size of the TRB
  * @chain: should this TRB be chained to the next?
  * @node: only for isochronous endpoints. First TRB needs different type.
+ * @use_bounce_buffer: set to use bounce buffer
+ * @must_interrupt: set to interrupt on TRB completion
  */
 static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, unsigned int trb_length,
-		unsigned chain, unsigned node)
+		unsigned int chain, unsigned int node, bool use_bounce_buffer,
+		bool must_interrupt)
 {
 	struct dwc3_trb		*trb;
 	dma_addr_t		dma;
-	unsigned		stream_id = req->request.stream_id;
-	unsigned		short_not_ok = req->request.short_not_ok;
-	unsigned		no_interrupt = req->request.no_interrupt;
-	unsigned		is_last = req->request.is_last;
-
-	if (req->request.num_sgs > 0)
+	unsigned int		stream_id = req->request.stream_id;
+	unsigned int		short_not_ok = req->request.short_not_ok;
+	unsigned int		no_interrupt = req->request.no_interrupt;
+	unsigned int		is_last = req->request.is_last;
+
+	if (use_bounce_buffer)
+		dma = dep->dwc->bounce_addr;
+	else if (req->request.num_sgs > 0)
 		dma = sg_dma_address(req->start_sg);
 	else
 		dma = req->request.dma;
@@ -1085,10 +1092,63 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	req->num_trbs++;
 
 	__dwc3_prepare_one_trb(dep, trb, dma, trb_length, chain, node,
-			stream_id, short_not_ok, no_interrupt, is_last);
+			stream_id, short_not_ok, no_interrupt, is_last,
+			must_interrupt);
 }
 
-static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
+static bool dwc3_needs_extra_trb(struct dwc3_ep *dep, struct dwc3_request *req)
+{
+	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+	unsigned int rem = req->request.length % maxp;
+
+	if ((req->request.length && req->request.zero && !rem &&
+			!usb_endpoint_xfer_isoc(dep->endpoint.desc)) ||
+			(!req->direction && rem))
+		return true;
+
+	return false;
+}
+
+/**
+ * dwc3_prepare_last_sg - prepare TRBs for the last SG entry
+ * @dep: The endpoint that the request belongs to
+ * @req: The request to prepare
+ * @entry_length: The last SG entry size
+ * @node: Indicates whether this is not the first entry (for isoc only)
+ *
+ * Return the number of TRBs prepared.
+ */
+static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
+		struct dwc3_request *req, unsigned int entry_length,
+		unsigned int node)
+{
+	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+	unsigned int rem = req->request.length % maxp;
+	unsigned int num_trbs = 1;
+
+	if (dwc3_needs_extra_trb(dep, req))
+		num_trbs++;
+
+	if (dwc3_calc_trbs_left(dep) < num_trbs)
+		return 0;
+
+	req->needs_extra_trb = num_trbs > 1;
+
+	/* Prepare a normal TRB */
+	if (req->direction || req->request.length)
+		dwc3_prepare_one_trb(dep, req, entry_length,
+				req->needs_extra_trb, node, false, false);
+
+	/* Prepare extra TRBs for ZLP and MPS OUT transfer alignment */
+	if ((!req->direction && !req->request.length) || req->needs_extra_trb)
+		dwc3_prepare_one_trb(dep, req,
+				req->direction ? 0 : maxp - rem,
+				false, 1, true, false);
+
+	return num_trbs;
+}
+
+static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
 	struct scatterlist *sg = req->start_sg;
@@ -1097,6 +1157,8 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 	unsigned int length = req->request.length;
 	unsigned int remaining = req->request.num_mapped_sgs
 		- req->num_queued_sgs;
+	unsigned int num_trbs = req->num_trbs;
+	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
 
 	/*
 	 * If we resume preparing the request, then get the remaining length of
@@ -1106,10 +1168,10 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		length -= sg_dma_len(s);
 
 	for_each_sg(sg, s, remaining, i) {
-		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
-		unsigned int rem = length % maxp;
+		unsigned int num_trbs_left = dwc3_calc_trbs_left(dep);
 		unsigned int trb_length;
-		unsigned chain = true;
+		bool must_interrupt = false;
+		bool last_sg = false;
 
 		trb_length = min_t(unsigned int, length, sg_dma_len(s));
 
@@ -1123,59 +1185,28 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		 * mapped sg.
 		 */
 		if ((i == remaining - 1) || !length)
-			chain = false;
-
-		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
-			struct dwc3	*dwc = dep->dwc;
-			struct dwc3_trb	*trb;
-
-			req->needs_extra_trb = true;
-
-			/* prepare normal TRB */
-			dwc3_prepare_one_trb(dep, req, trb_length, true, i);
-
-			/* Now prepare one extra TRB to align transfer size */
-			trb = &dep->trb_pool[dep->trb_enqueue];
-			req->num_trbs++;
-			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
-					maxp - rem, false, 1,
-					req->request.stream_id,
-					req->request.short_not_ok,
-					req->request.no_interrupt,
-					req->request.is_last);
-		} else if (req->request.zero && req->request.length &&
-			   !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			   !rem && !chain) {
-			struct dwc3	*dwc = dep->dwc;
-			struct dwc3_trb	*trb;
-
-			req->needs_extra_trb = true;
-
-			/* Prepare normal TRB */
-			dwc3_prepare_one_trb(dep, req, trb_length, true, i);
-
-			/* Prepare one extra TRB to handle ZLP */
-			trb = &dep->trb_pool[dep->trb_enqueue];
-			req->num_trbs++;
-			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-					       !req->direction, 1,
-					       req->request.stream_id,
-					       req->request.short_not_ok,
-					       req->request.no_interrupt,
-					       req->request.is_last);
-
-			/* Prepare one more TRB to handle MPS alignment */
-			if (!req->direction) {
-				trb = &dep->trb_pool[dep->trb_enqueue];
-				req->num_trbs++;
-				__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp,
-						       false, 1, req->request.stream_id,
-						       req->request.short_not_ok,
-						       req->request.no_interrupt,
-						       req->request.is_last);
-			}
+			last_sg = true;
+
+		if (!num_trbs_left)
+			break;
+
+		if (last_sg) {
+			if (!dwc3_prepare_last_sg(dep, req, trb_length, i))
+				break;
 		} else {
-			dwc3_prepare_one_trb(dep, req, trb_length, chain, i);
+			/*
+			 * Look ahead to check if we have enough TRBs for the
+			 * next SG entry. If not, set interrupt on this TRB to
+			 * resume preparing the next SG entry when more TRBs are
+			 * free.
+			 */
+			if (num_trbs_left == 1 || (needs_extra_trb &&
+					num_trbs_left <= 2 &&
+					sg_dma_len(sg_next(s)) >= length))
+				must_interrupt = true;
+
+			dwc3_prepare_one_trb(dep, req, trb_length, 1, i, false,
+					must_interrupt);
 		}
 
 		/*
@@ -1185,7 +1216,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		 * we have free trbs we can continue queuing from where we
 		 * previously stopped
 		 */
-		if (chain)
+		if (!last_sg)
 			req->start_sg = sg_next(s);
 
 		req->num_queued_sgs++;
@@ -1200,68 +1231,17 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			break;
 		}
 
-		if (!dwc3_calc_trbs_left(dep))
+		if (must_interrupt)
 			break;
 	}
+
+	return req->num_trbs - num_trbs;
 }
 
-static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
+static int dwc3_prepare_trbs_linear(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
-	unsigned int length = req->request.length;
-	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
-	unsigned int rem = length % maxp;
-
-	if ((!length || rem) && usb_endpoint_dir_out(dep->endpoint.desc)) {
-		struct dwc3	*dwc = dep->dwc;
-		struct dwc3_trb	*trb;
-
-		req->needs_extra_trb = true;
-
-		/* prepare normal TRB */
-		dwc3_prepare_one_trb(dep, req, length, true, 0);
-
-		/* Now prepare one extra TRB to align transfer size */
-		trb = &dep->trb_pool[dep->trb_enqueue];
-		req->num_trbs++;
-		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
-				false, 1, req->request.stream_id,
-				req->request.short_not_ok,
-				req->request.no_interrupt,
-				req->request.is_last);
-	} else if (req->request.zero && req->request.length &&
-		   !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-		   (IS_ALIGNED(req->request.length, maxp))) {
-		struct dwc3	*dwc = dep->dwc;
-		struct dwc3_trb	*trb;
-
-		req->needs_extra_trb = true;
-
-		/* prepare normal TRB */
-		dwc3_prepare_one_trb(dep, req, length, true, 0);
-
-		/* Prepare one extra TRB to handle ZLP */
-		trb = &dep->trb_pool[dep->trb_enqueue];
-		req->num_trbs++;
-		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-				!req->direction, 1, req->request.stream_id,
-				req->request.short_not_ok,
-				req->request.no_interrupt,
-				req->request.is_last);
-
-		/* Prepare one more TRB to handle MPS alignment for OUT */
-		if (!req->direction) {
-			trb = &dep->trb_pool[dep->trb_enqueue];
-			req->num_trbs++;
-			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp,
-					       false, 1, req->request.stream_id,
-					       req->request.short_not_ok,
-					       req->request.no_interrupt,
-					       req->request.is_last);
-		}
-	} else {
-		dwc3_prepare_one_trb(dep, req, length, false, 0);
-	}
+	return dwc3_prepare_last_sg(dep, req, req->request.length, 0);
 }
 
 /*
@@ -1271,10 +1251,13 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
  * The function goes through the requests list and sets up TRBs for the
  * transfers. The function returns once there are no more TRBs available or
  * it runs out of requests.
+ *
+ * Returns the number of TRBs prepared or negative errno.
  */
-static void dwc3_prepare_trbs(struct dwc3_ep *dep)
+static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 {
 	struct dwc3_request	*req, *n;
+	int			ret = 0;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
@@ -1289,11 +1272,14 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 	 * break things.
 	 */
 	list_for_each_entry(req, &dep->started_list, list) {
-		if (req->num_pending_sgs > 0)
-			dwc3_prepare_one_trb_sg(dep, req);
+		if (req->num_pending_sgs > 0) {
+			ret = dwc3_prepare_trbs_sg(dep, req);
+			if (!ret || req->num_pending_sgs)
+				return ret;
+		}
 
 		if (!dwc3_calc_trbs_left(dep))
-			return;
+			return ret;
 
 		/*
 		 * Don't prepare beyond a transfer. In DWC_usb32, its transfer
@@ -1301,30 +1287,32 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 		 * active transfer instead of stopping.
 		 */
 		if (dep->stream_capable && req->request.is_last)
-			return;
+			return ret;
 	}
 
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
 		struct dwc3	*dwc = dep->dwc;
-		int		ret;
 
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev, &req->request,
 						    dep->direction);
 		if (ret)
-			return;
+			return ret;
 
 		req->sg			= req->request.sg;
 		req->start_sg		= req->sg;
 		req->num_queued_sgs	= 0;
 		req->num_pending_sgs	= req->request.num_mapped_sgs;
 
-		if (req->num_pending_sgs > 0)
-			dwc3_prepare_one_trb_sg(dep, req);
-		else
-			dwc3_prepare_one_trb_linear(dep, req);
+		if (req->num_pending_sgs > 0) {
+			ret = dwc3_prepare_trbs_sg(dep, req);
+			if (req->num_pending_sgs)
+				return ret;
+		} else {
+			ret = dwc3_prepare_trbs_linear(dep, req);
+		}
 
-		if (!dwc3_calc_trbs_left(dep))
-			return;
+		if (!ret || !dwc3_calc_trbs_left(dep))
+			return ret;
 
 		/*
 		 * Don't prepare beyond a transfer. In DWC_usb32, its transfer
@@ -1332,8 +1320,10 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 		 * active transfer instead of stopping.
 		 */
 		if (dep->stream_capable && req->request.is_last)
-			return;
+			return ret;
 	}
+
+	return ret;
 }
 
 static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep);
@@ -1346,12 +1336,24 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 	int				ret;
 	u32				cmd;
 
-	if (!dwc3_calc_trbs_left(dep))
-		return 0;
+	/*
+	 * Note that it's normal to have no new TRBs prepared (i.e. ret == 0).
+	 * This happens when we need to stop and restart a transfer such as in
+	 * the case of reinitiating a stream or retrying an isoc transfer.
+	 */
+	ret = dwc3_prepare_trbs(dep);
+	if (ret < 0)
+		return ret;
 
 	starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
 
-	dwc3_prepare_trbs(dep);
+	/*
+	 * If there's no new TRB prepared and we don't need to restart a
+	 * transfer, there's no need to update the transfer.
+	 */
+	if (!ret && !starting)
+		return ret;
+
 	req = next_request(&dep->started_list);
 	if (!req) {
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
@@ -1539,12 +1541,12 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	if (!dwc->dis_start_transfer_quirk &&
 	    (DWC3_VER_IS_PRIOR(DWC31, 170A) ||
 	     DWC3_VER_TYPE_IS_WITHIN(DWC31, 170A, EA01, EA06))) {
-		if (dwc->gadget.speed <= USB_SPEED_HIGH && dep->direction)
+		if (dwc->gadget->speed <= USB_SPEED_HIGH && dep->direction)
 			return dwc3_gadget_start_isoc_quirk(dep);
 	}
 
 	if (desc->bInterval <= 14 &&
-	    dwc->gadget.speed >= USB_SPEED_HIGH) {
+	    dwc->gadget->speed >= USB_SPEED_HIGH) {
 		u32 frame = __dwc3_gadget_get_frame(dwc);
 		bool rollover = frame <
 				(dep->frame_number & DWC3_FRNUMBER_MASK);
@@ -1600,7 +1602,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
 
-	if (!dep->endpoint.desc) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;
@@ -1628,8 +1630,13 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	if (dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)
 		return 0;
 
-	/* Start the transfer only after the END_TRANSFER is completed */
-	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
+	/*
+	 * Start the transfer only after the END_TRANSFER is completed
+	 * and endpoint STALL is cleared.
+	 */
+	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
+	    (dep->flags & DWC3_EP_WEDGE) ||
+	    (dep->flags & DWC3_EP_STALL)) {
 		dep->flags |= DWC3_EP_DELAY_START;
 		return 0;
 	}
@@ -1648,9 +1655,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 			return 0;
 
 		if ((dep->flags & DWC3_EP_PENDING_REQUEST)) {
-			if (!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
+			if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
 				return __dwc3_gadget_start_isoc(dep);
-			}
 		}
 	}
 
@@ -1788,8 +1794,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 	if (value) {
 		struct dwc3_trb *trb;
 
-		unsigned transfer_in_flight;
-		unsigned started;
+		unsigned int transfer_in_flight;
+		unsigned int started;
 
 		if (dep->number > 1)
 			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
@@ -1822,6 +1828,18 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 			return 0;
 		}
 
+		dwc3_stop_active_transfer(dep, true, true);
+
+		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
+			dwc3_gadget_move_cancelled_request(req);
+
+		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
+			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
+			return 0;
+		}
+
+		dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret) {
 			dev_err(dwc->dev, "failed to clear STALL on %s\n",
@@ -1831,18 +1849,11 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 
 		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
 
-		dwc3_stop_active_transfer(dep, true, true);
-
-		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
-
-		list_for_each_entry_safe(req, tmp, &dep->pending_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+		if ((dep->flags & DWC3_EP_DELAY_START) &&
+		    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			__dwc3_gadget_kick_transfer(dep);
 
-		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)) {
-			dep->flags &= ~DWC3_EP_DELAY_START;
-			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
-		}
+		dep->flags &= ~DWC3_EP_DELAY_START;
 	}
 
 	return ret;
@@ -2010,6 +2021,21 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 	return 0;
 }
 
+static void dwc3_stop_active_transfers(struct dwc3 *dwc)
+{
+	u32 epnum;
+
+	for (epnum = 2; epnum < dwc->num_eps; epnum++) {
+		struct dwc3_ep *dep;
+
+		dep = dwc->eps[epnum];
+		if (!dep)
+			continue;
+
+		dwc3_remove_requests(dwc, dep);
+	}
+}
+
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
@@ -2055,6 +2081,9 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	return 0;
 }
 
+static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
+static void __dwc3_gadget_stop(struct dwc3 *dwc);
+
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2078,7 +2107,46 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		}
 	}
 
+	/*
+	 * Synchronize any pending event handling before executing the controller
+	 * halt routine.
+	 */
+	if (!is_on) {
+		dwc3_gadget_disable_irq(dwc);
+		synchronize_irq(dwc->irq_gadget);
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
+
+	if (!is_on) {
+		u32 count;
+
+		/*
+		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
+		 * Section 4.1.8 Table 4-7, it states that for a device-initiated
+		 * disconnect, the SW needs to ensure that it sends "a DEPENDXFER
+		 * command for any active transfers" before clearing the RunStop
+		 * bit.
+		 */
+		dwc3_stop_active_transfers(dwc);
+		__dwc3_gadget_stop(dwc);
+
+		/*
+		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
+		 * Section 1.3.4, it mentions that for the DEVCTRLHLT bit, the
+		 * "software needs to acknowledge the events that are generated
+		 * (by writing to GEVNTCOUNTn) while it is waiting for this bit
+		 * to be set to '1'."
+		 */
+		count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+		count &= DWC3_GEVNTCOUNT_MASK;
+		if (count > 0) {
+			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
+						dwc->ev_buf->length;
+		}
+	}
+
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2244,7 +2312,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (dwc->gadget_driver) {
 		dev_err(dwc->dev, "%s is already bound to %s\n",
-				dwc->gadget.name,
+				dwc->gadget->name,
 				dwc->gadget_driver->driver.name);
 		ret = -EBUSY;
 		goto err1;
@@ -2416,7 +2484,7 @@ static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
 	dep->endpoint.maxburst = 1;
 	dep->endpoint.ops = &dwc3_gadget_ep0_ops;
 	if (!dep->direction)
-		dwc->gadget.ep0 = &dep->endpoint;
+		dwc->gadget->ep0 = &dep->endpoint;
 
 	dep->endpoint.caps.type_control = true;
 
@@ -2459,10 +2527,10 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 
 	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
-	dep->endpoint.max_streams = 15;
+	dep->endpoint.max_streams = 16;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
-			&dwc->gadget.ep_list);
+			&dwc->gadget->ep_list);
 	dep->endpoint.caps.type_iso = true;
 	dep->endpoint.caps.type_bulk = true;
 	dep->endpoint.caps.type_int = true;
@@ -2508,10 +2576,10 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 		size /= 3;
 
 	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
-	dep->endpoint.max_streams = 15;
+	dep->endpoint.max_streams = 16;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
-			&dwc->gadget.ep_list);
+			&dwc->gadget->ep_list);
 	dep->endpoint.caps.type_iso = true;
 	dep->endpoint.caps.type_bulk = true;
 	dep->endpoint.caps.type_int = true;
@@ -2572,7 +2640,7 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 {
 	u8				epnum;
 
-	INIT_LIST_HEAD(&dwc->gadget.ep_list);
+	INIT_LIST_HEAD(&dwc->gadget->ep_list);
 
 	for (epnum = 0; epnum < total; epnum++) {
 		int			ret;
@@ -2652,12 +2720,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	}
 
 	/*
-	 * If we're dealing with unaligned size OUT transfer, we will be left
-	 * with one TRB pending in the ring. We need to manually clear HWO bit
-	 * from that TRB.
+	 * We use bounce buffer for requests that needs extra TRB or OUT ZLP. If
+	 * this TRB points to the bounce buffer address, it's a MPS alignment
+	 * TRB. Don't add it to req->remaining calculation.
 	 */
-
-	if (req->needs_extra_trb && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
+	if (trb->bpl == lower_32_bits(dep->dwc->bounce_addr) &&
+	    trb->bph == upper_32_bits(dep->dwc->bounce_addr)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}
@@ -2732,26 +2800,17 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
 
-	if (req->needs_extra_trb) {
-		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+	req->request.actual = req->request.length - req->remaining;
+
+	if (!dwc3_gadget_ep_request_completed(req))
+		goto out;
 
+	if (req->needs_extra_trb) {
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
-
-		/* Reclaim MPS padding TRB for ZLP */
-		if (!req->direction && req->request.zero && req->request.length &&
-		    !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-		    (IS_ALIGNED(req->request.length, maxp)))
-			ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event, status);
-
 		req->needs_extra_trb = false;
 	}
 
-	req->request.actual = req->request.length - req->remaining;
-
-	if (!dwc3_gadget_ep_request_completed(req))
-		goto out;
-
 	dwc3_gadget_giveback(dep, req, status);
 
 out:
@@ -2896,6 +2955,43 @@ static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 	(void) __dwc3_gadget_start_isoc(dep);
 }
 
+static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	u8 cmd = DEPEVT_PARAMETER_CMD(event->parameters);
+
+	if (cmd != DWC3_DEPCMD_ENDTRANSFER)
+		return;
+
+	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
+	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
+	if (dep->flags & DWC3_EP_PENDING_CLEAR_STALL) {
+		struct dwc3 *dwc = dep->dwc;
+
+		dep->flags &= ~DWC3_EP_PENDING_CLEAR_STALL;
+		if (dwc3_send_clear_stall_ep_cmd(dep)) {
+			struct usb_ep *ep0 = &dwc->eps[0]->endpoint;
+
+			dev_err(dwc->dev, "failed to clear STALL on %s\n", dep->name);
+			if (dwc->delayed_status)
+				__dwc3_gadget_ep0_set_halt(ep0, 1);
+			return;
+		}
+
+		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
+		if (dwc->delayed_status)
+			dwc3_ep0_send_delayed_status(dwc);
+	}
+
+	if ((dep->flags & DWC3_EP_DELAY_START) &&
+	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		__dwc3_gadget_kick_transfer(dep);
+
+	dep->flags &= ~DWC3_EP_DELAY_START;
+}
+
 static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
@@ -2965,7 +3061,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 {
 	struct dwc3_ep		*dep;
 	u8			epnum = event->endpoint_number;
-	u8			cmd;
 
 	dep = dwc->eps[epnum];
 
@@ -2991,18 +3086,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_endpoint_transfer_not_ready(dep, event);
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
-		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
-
-		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
-			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
-			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
-			if ((dep->flags & DWC3_EP_DELAY_START) &&
-			    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
-				__dwc3_gadget_kick_transfer(dep);
-
-			dep->flags &= ~DWC3_EP_DELAY_START;
-		}
+		dwc3_gadget_endpoint_command_complete(dep, event);
 		break;
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		dwc3_gadget_endpoint_transfer_complete(dep, event);
@@ -3019,7 +3103,7 @@ static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
 	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->disconnect(&dwc->gadget);
+		dwc->gadget_driver->disconnect(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3028,7 +3112,7 @@ static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
 	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->suspend(&dwc->gadget);
+		dwc->gadget_driver->suspend(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3037,7 +3121,7 @@ static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
 	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->resume(&dwc->gadget);
+		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3047,9 +3131,9 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return;
 
-	if (dwc->gadget.speed != USB_SPEED_UNKNOWN) {
+	if (dwc->gadget->speed != USB_SPEED_UNKNOWN) {
 		spin_unlock(&dwc->lock);
-		usb_gadget_udc_reset(&dwc->gadget, dwc->gadget_driver);
+		usb_gadget_udc_reset(dwc->gadget, dwc->gadget_driver);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3150,9 +3234,9 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	dwc3_disconnect_gadget(dwc);
 
-	dwc->gadget.speed = USB_SPEED_UNKNOWN;
+	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
-	usb_gadget_set_state(&dwc->gadget, USB_STATE_NOTATTACHED);
+	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc->connected = false;
 }
@@ -3195,6 +3279,13 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	}
 
 	dwc3_reset_gadget(dwc);
+	/*
+	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
+	 * Section 4.1.2 Table 4-2, it states that during a USB reset, the SW
+	 * needs to ensure that it sends "a DEPENDXFER command for any active
+	 * transfers."
+	 */
+	dwc3_stop_active_transfers(dwc);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
@@ -3231,8 +3322,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	switch (speed) {
 	case DWC3_DSTS_SUPERSPEED_PLUS:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-		dwc->gadget.ep0->maxpacket = 512;
-		dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
+		dwc->gadget->ep0->maxpacket = 512;
+		dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
 		break;
 	case DWC3_DSTS_SUPERSPEED:
 		/*
@@ -3252,27 +3343,27 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 			dwc3_gadget_reset_interrupt(dwc);
 
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-		dwc->gadget.ep0->maxpacket = 512;
-		dwc->gadget.speed = USB_SPEED_SUPER;
+		dwc->gadget->ep0->maxpacket = 512;
+		dwc->gadget->speed = USB_SPEED_SUPER;
 		break;
 	case DWC3_DSTS_HIGHSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget.ep0->maxpacket = 64;
-		dwc->gadget.speed = USB_SPEED_HIGH;
+		dwc->gadget->ep0->maxpacket = 64;
+		dwc->gadget->speed = USB_SPEED_HIGH;
 		break;
 	case DWC3_DSTS_FULLSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget.ep0->maxpacket = 64;
-		dwc->gadget.speed = USB_SPEED_FULL;
+		dwc->gadget->ep0->maxpacket = 64;
+		dwc->gadget->speed = USB_SPEED_FULL;
 		break;
 	case DWC3_DSTS_LOWSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
-		dwc->gadget.ep0->maxpacket = 8;
-		dwc->gadget.speed = USB_SPEED_LOW;
+		dwc->gadget->ep0->maxpacket = 8;
+		dwc->gadget->speed = USB_SPEED_LOW;
 		break;
 	}
 
-	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget->ep0->maxpacket;
 
 	/* Enable USB2 LPM Capability */
 
@@ -3340,7 +3431,7 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 
 	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->resume(&dwc->gadget);
+		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3511,7 +3602,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 			 * Ignore suspend event until the gadget enters into
 			 * USB_STATE_CONFIGURED state.
 			 */
-			if (dwc->gadget.state >= USB_STATE_CONFIGURED)
+			if (dwc->gadget->state >= USB_STATE_CONFIGURED)
 				dwc3_gadget_suspend_interrupt(dwc,
 						event->event_info);
 		}
@@ -3686,6 +3777,13 @@ out:
 	return irq;
 }
 
+static void dwc_gadget_release(struct device *dev)
+{
+	struct usb_gadget *gadget = container_of(dev, struct usb_gadget, dev);
+
+	kfree(gadget);
+}
+
 /**
  * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -3696,6 +3794,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 {
 	int ret;
 	int irq;
+	struct device *dev;
 
 	irq = dwc3_gadget_get_irq(dwc);
 	if (irq < 0) {
@@ -3728,12 +3827,21 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	}
 
 	init_completion(&dwc->ep0_in_setup);
+	dwc->gadget = kzalloc(sizeof(struct usb_gadget), GFP_KERNEL);
+	if (!dwc->gadget) {
+		ret = -ENOMEM;
+		goto err3;
+	}
 
-	dwc->gadget.ops			= &dwc3_gadget_ops;
-	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
-	dwc->gadget.sg_supported	= true;
-	dwc->gadget.name		= "dwc3-gadget";
-	dwc->gadget.lpm_capable		= true;
+
+	usb_initialize_gadget(dwc->dev, dwc->gadget, dwc_gadget_release);
+	dev				= &dwc->gadget->dev;
+	dev->platform_data		= dwc;
+	dwc->gadget->ops		= &dwc3_gadget_ops;
+	dwc->gadget->speed		= USB_SPEED_UNKNOWN;
+	dwc->gadget->sg_supported	= true;
+	dwc->gadget->name		= "dwc3-gadget";
+	dwc->gadget->lpm_capable	= true;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -3756,7 +3864,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		dev_info(dwc->dev, "changing max_speed on rev %08x\n",
 				dwc->revision);
 
-	dwc->gadget.max_speed		= dwc->maximum_speed;
+	dwc->gadget->max_speed		= dwc->maximum_speed;
 
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
@@ -3765,21 +3873,22 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_endpoints(dwc, dwc->num_eps);
 	if (ret)
-		goto err3;
+		goto err4;
 
-	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
+	ret = usb_add_gadget(dwc->gadget);
 	if (ret) {
-		dev_err(dwc->dev, "failed to register udc\n");
-		goto err4;
+		dev_err(dwc->dev, "failed to add gadget\n");
+		goto err5;
 	}
 
-	dwc3_gadget_set_speed(&dwc->gadget, dwc->maximum_speed);
+	dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
 
 	return 0;
 
-err4:
+err5:
 	dwc3_gadget_free_endpoints(dwc);
-
+err4:
+	usb_put_gadget(dwc->gadget);
 err3:
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
 			dwc->bounce_addr);
@@ -3799,7 +3908,7 @@ err0:
 
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
-	usb_del_gadget_udc(&dwc->gadget);
+	usb_del_gadget_udc(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
 			  dwc->bounce_addr);
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index bd85eb7fa9ef..0cd281949970 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -17,7 +17,7 @@
 
 struct dwc3;
 #define to_dwc3_ep(ep)		(container_of(ep, struct dwc3_ep, endpoint))
-#define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
+#define gadget_to_dwc(g)	(dev_get_platdata(&g->dev))
 
 /* DEPCFG parameter 1 */
 #define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
@@ -113,6 +113,7 @@ int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		gfp_t gfp_flags);
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
+void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
-- 
2.53.0

