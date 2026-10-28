Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB1606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hNLrV+Gq;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HX0Ol6eX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9629810ED;
	Wed, 28 Oct 2026 14:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHfWKR5XbCIV; Wed, 28 Oct 2026 14:46:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1897E81082
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198782;
	b=q2LuGsSZINNktxijK5xwacdhzHp6ikc3DsqSKMhNaraL+m+MGYX+lLpUPp7UiSMRG1mn
	 heon2+1vhz4Rhalaur1fX9Zi+elvjpfwn4oI5QTXkuR+wU0HhwadXlnoEhS0MRcgnonZD
	 J7rqgAa1aSsGkYLPvJFcjRVv79k66w/QDeFQ55H9fADiRprVL4ZePjG+MHjj9En/sqZqK
	 9/rirrGW5VRPFtsLjSzXG1qFeEkTk66BQsA4VGPanGfIwdPyXGbyXqmtV+DaVl7qBDqaS
	 en/PY4ioOthcacNQUkjbGz7DHhLzepRRKvLnAP+vCpbMNkPmwRftXZWZMHELlSt/08g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AufB6ebBW4PdUgDsQhL0qjbHRdTT4hAV4Nr7pLsSzg8=;
	b=AfJDYQE04aVlQKsSJufkx7Baf05+YkGMuFY1WuhbnHVxlS2gv6iQETdDf2q35QKvMr8W
	 BOx9yUM1uyVrZA+5axvjodRXrLnzar1aJVzQgkn3jMdJKhedjqjiXPqIobJf86a69h3T8
	 I5EgPnUdUKn4TSz8kIHpvSCl/PmQ8N+WOxTNE6gGeeGzkVgXIMP/bzMHSqr16LjS00WIO
	 /AozNlpalklAaVP0+Rm+fzUfPI2yARRn73bbuYyNKAyoMCK9ypyGe5QB+uM7eG+ftiQMN
	 GwXNGylLEGVXir7G4pzhYfpxcUAZjBw+WMesqKkAfJ9FWQZgxshl8LWVJ9HC9G/aeaA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HX0Ol6eX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198782;
	bh=AufB6ebBW4PdUgDsQhL0qjbHRdTT4hAV4Nr7pLsSzg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hNLrV+GqsmaAP/TB5hbxbN1Dxn3UIaZM1JUi4e3Md05ocly08bCBuKvnISYTklSBw
	 syUtSfRw4BPlczL24hOvdPE59dF58AL+auHsz5POEMDyC1aVPw4YcZjURsWSHCriD+
	 b7hT+ueYiswLohe/bY81vy8CQOqu21/6G4dRhGCIeqInHQm7LdCl8LK4PJasGEwSE7
	 QlTZJJP6BmVaLEdlzRfV/eNKcK4+9IkmWy1zCG5M801DSvZA7uXUnDbyeQPLQCMpYO
	 vl5ROh23pclaui+uIzeP264RXLgXrvMmz4hRlFrhX2ijF0aNOasfflJCOysWtwY0r5
	 lzrwlGy1mfHUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1897E81082;
	Wed, 28 Oct 2026 14:46:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C72004D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B886C80BA6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p5A8GSUWfh2E for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 806E880BDF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196661;
 b=W3rwSq/F5POuZwVMerUIlc7FV364giSrM7BphNsplsy2lP3D5G+8EXS4E7gKnLfVOgxv
 K7H5PqnTZK4UU5xI4hFDcoHP4/Xe8n3jOociVrbjAt/62ReaSskVxC4PEO4Va9UgWjWKN
 O59saB9MM3pUYHXOqqUtghN//hho/s02UP6+eoskzfeonbcSeOTQRUHbzzDTwmA6sHoqF
 2O2+Z9qWgmB3hLi1RsiWD33U6LXBJzZow6fyidUdnk83ZnsyNup3UtDjYpLa5YPnFasia
 ZTZqpFXWzmlAqEDbfVKoItq1YK3oZot3GgWvaaodilqyBjcEh1bvrtMRG2lROg1CAKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196661;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AufB6ebBW4PdUgDsQhL0qjbHRdTT4hAV4Nr7pLsSzg8=;
 b=VIH3drn8KSegGMqhgSrTJPwPbptjxCXLs24nUPXLL7T7yTiHUXRSrvb12DOrX5zjgJb4
 r9jKcA8KB7ZBZ6wzoHZhqT5P+KuDOY9IMrFH0UTNGmXPi9lt/P8h1GTXVv5+tVUixhu/d
 8HMIs1o3J+xcidcvBOsY3pAMuP21/xKfonn6sOVxL13lPwdrmeGSutQ/YNheyFiFDrpvS
 4OeTjQIpA/4uMZ1YOfGYGDNUZq0xYq4setkaSfk4XQ1LdKvsWZAAAV0c8lbuMln6q0at2
 rO4nwQnKB9qmPxlcWGDheA5FK90C/vgk6b3SAh9JJ46GqTD8XiXgbsmVXwMya7+xeyQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HX0Ol6eX; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=HX0Ol6eX
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 806E880BDF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:59 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10374466b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196658; x=1793801458;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AufB6ebBW4PdUgDsQhL0qjbHRdTT4hAV4Nr7pLsSzg8=;
 b=HX0Ol6eXb+jOvjf2J9fXZGnDWayCSk/+78QwCozz5/f9xjnrmxISxxtZelSA3eOh9j
 +Lz1KEtR5fxErb6Z/m8sBvV+d0pxmCTbOxXbdEqfqywiCynKZuL3wnduTKWUk8KTIpCv
 PXLR+AXspZ2bRtey11VzjLI76KmuaDfOKLcD08Ul6M13GPY7KiHIQwgDbr4vWDqQVzDL
 VHpNasxT33fUtcjQaxyowfB8WmvrBtZYzGibafqhVG0huKLWxMqnrXYx7utphUgg/Luz
 k8dHHfFLSbfsLMdZ3xbMOMzebcZclf6t3656LZ0h8vj4iaHAEqInM2wGUWK206eStgra
 WaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196658; x=1793801458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AufB6ebBW4PdUgDsQhL0qjbHRdTT4hAV4Nr7pLsSzg8=;
 b=VT9En0f94Kx6pl3zHx338PF3D60UoWJKKSLtKCjOcHIJtbqK+Heh8zPMWrj8YaKH37
 FNt30XQsLWhz5CQA8y/4lxvJd0/P6LIGZWMEowpeXfU3YLLKDU81bAY3DMXUgZwvT6rg
 qrgyzagyD5w6Qy7/gqgi+SULE0/pgtW2DPP/esvia9FVK29k66rJMZOTyZ4SWtf+xaYe
 itd0a2Ul8uikA/NWSgWIZzW/WAxVrNjub/lKUG+fFICFb7IGl75BNlbUUlBmpbC2sPLo
 0l2PGoXruVCBk0iSA6xm5Pei7Ydpaq2ywVDE1668iIXvduqI+3i5UWMxNi+s105nQF5H
 iYUQ==
X-Gm-Message-State: AFq9FYJVh/ie2wyu5N7O+b/0q/s23lMQf+Ugld7hkA8PaT9UzYUheL6y
 /v/85phcLTXiSHBugcuAbylPozRQzMFwwKjkiRKYbM4Vzc34yL2PCsFdJl2efSTDMATytSWukIm
 DgaxM
X-Gm-Gg: AYBFou3NPNSTSGa+eQ7qbA/IBdXptmQqNKzye5LYUHHB3Ey/LQcKllpvQxvHkarzTjy
 ay3J3Tdfcx7qvgMDlPWozMaVjmSx5hTlVCV7awUrhEwJ8ykkEgg5uAo0FQHN4NGyGNuIs5dEK/j
 9SDIlVPVMteCcY8+CSDCLNk/VibjZhYmFPs9pOMLCK7kEdbexEF5ocij64OFxNOKK9YQ/wXyHaK
 IEeKwkI5+wnDaEKhHWJ8/OOnhaG6xONu2c5RGcqi+ttIUOs5BIIe9LLqDmlcDAgsUZH3ONaTGuV
 r6ceR3shd0fOWEbaNUGjSIfABixnSaj0gUc426vLSi0o6vaDLpd1w8M4K0Ou3vtyJf9yIpgV5h/
 0BcR3VrXfHPYoKk0IvZ0ni5xDSOjDCcPgOCxvyBJGLrfhaq95iAI4p1i07KkBjcMX5yFHag+9MA
 +FNO3B7+0pKXkJ8l4kUrtvmPbXNQxLuRSX/Jpsjj+t3w1TcN2z12WkWbtR20HnoxKSptxWl6zp+
 rjfCw2UohbSuW82HRWPAqvEVPYFKP8eUPntl5Ez3TVL4p33/VRDCWRQMzDzHrFs/GefdsD4NBzf
 AO5gGh8+PYC1+7TVHY8mJBfcmEmVTzAIXAcAKDRodaMLszu4vRNFSy46hL24D3gmwZMpZCXwYVN
 HSgmn5MfpHZTvy2lfFTkR7yo1HLdPIx0=
X-Received: by 2002:a17:906:18e9:b0:c41:3963:6f1f with SMTP id
 a640c23a62f3a-c49bdeae450mr225605966b.4.1793196657072; 
 Wed, 28 Oct 2026 07:10:57 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:10:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 14/63] usb: dwc3: import from kernel v4.10
Date: Wed, 28 Oct 2026 15:08:40 +0100
Message-ID: <20261028140930.3025368-15-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.9 to v4.10.

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

List of commits: git log --oneline v4.9..v4.10
Commits imported:
9418ee15f718 usb: dwc3: gadget: Fix full speed mode
d7fd41c6dbcc usb: dwc3: skip interrupt when ep disabled
e71d363d9c61 usb: dwc3: core: avoid Overflow events
d62145929992 usb: dwc3: gadget: always unmap EP0 requests
19ec31230eb3 usb: dwc3: ep0: explicitly call dwc3_ep0_prepare_one_trb()
7931ec86c1b7 usb: dwc3: ep0: add dwc3_ep0_prepare_one_trb()
9165dabb2500 treewide: Fix printk() message errors
d64ff406e51e usb: dwc3: use bus->sysdev for DMA configuration
1c404b51a05d usb: dwc3: ep0: avoid empty-body warning
28632b44d129 usb: dwc3: Workaround for irq mask issue
cf40b86b6ef6 usb: dwc3: Implement interrupt moderation
65aca3205046 usb: dwc3: gadget: clear events in top-half handler
ebbb2d59398f usb: dwc3: gadget: use evt->cache for processing events
caefe6c7be47 usb: dwc3: gadget: use evt->length as we should
d9fa4c63f766 usb: dwc3: core: add a event buffer cache
a22f884b2665 usb: dwc3: core: remove dwc3_soft_reset()
7ac51a12ea11 usb: dwc3: Add a function to check properties
a987a906e95c usb: dwc3: Add a check for the DWC_usb3 core
5fb6fdaf38f7 usb: dwc3: gadget: Fix dead code writing GCTL.RAMCLKSEL
39ebb05ca83d usb: dwc3: gadget: Remove descriptor arguments to ep_enable
f2694a93e0df usb: dwc3: warn on once when no trbs
87aba10639b0 usb: dwc3: isoc clean DWC3_EP_PENDING_REQUEST flag
e3aee48692ac usb: dwc3: fix post-increment
ce3fc8b32994 usb: dwc3: clean TRB if STARTTRANSFER fail
8ab89da4c281 usb: dwc3: decrement queued_requests
5eb30cedced6 usb: dwc3: trace: purge dwc3_trace()
2870e5013e19 usb: dwc3: trace: add a tracepoint for ep enable/disable
ff377ae47de5 usb: dwc3: gadget: always kick if num_pending_sgs > 0
7282c4ef0b66 usb: dwc3: gadget: stop touching HWO TRBs
d86c5a676e5b usb: dwc3: gadget: always try to prepare on started_list first
e62c5bc57367 usb: dwc3: gadget: tracking per-TRB remaining bytes
6cb2e4e3de10 usb: dwc3: gadget: cope with XferNotReady before usb_ep_queue()
76a638f8ac0d usb: dwc3: gadget: wait for End Transfer to complete
785c91f8ae4d usb: dwc3: cleanup with list_first_entry_or_null()
bb0147364850 usb: dwc3: gadget: don't clear RUN/STOP when it's invalid to do so
cf68923055cb usb: dwc3: gadget: purge dwc3_stop_active_transfers()
c5ac6116db35 usb: dwc3: core: add dwc3_get_properties()
3b2733227f40 usb: dwc3: core: remove unnecessary alignment
941f918ecfa7 usb: dwc3: core: introduce dwc3_core_setup_global_control()
0759956f8ae7 usb: dwc3: core: introduce dwc3_core_is_valid()
0bb39ca1ad87 usb: dwc3: Add support for device L1 exit
f9d2f9228cde usb: dwc3: remove unused struct member dwc3->mem
0a695d4c75ff usb: dwc3: gadget: never ever kill the machine
c9508c8c50f9 usb: dwc3: gadget: only interrupt on short if short_not_ok is set
58f29034b4c4 usb: dwc3: gadget: CSP is only valid for OUT endpoints
b9bd138e06b9 usb: dwc3: gadget: remove unused 'first_trb_index'
39e07ffb1c3d usb: dwc3: ep0: simplify dwc3_ep0_handle_feature()
6db3812e09db usb: dwc3: gadget: extract dwc3_gadget_get_irq()
4dd5a69e495b usb: dwc3: trace: add a proper tracepoint for reg accessors
57b14da56227 usb: dwc3: don't compile dwc3_trace() unless CONFIG_FTRACE=y
a97ea994605e usb: dwc3: gadget: offset Start Transfer latency for bulk EPs
43c96be1c46e usb: dwc3: trace: print out ep0state also from XferComplete
cdd72ac20b4a usb: dwc3: debug: move dwc3_ep0_state_string() to debug.h
8566cd1adf29 usb: dwc3: gadget: remove redundant trace prints
45a2af2f2b5a usb: dwc3: debug: decode control endpoint phase too
799e9dc82968 usb: dwc3: gadget: conditionally disable Link State change events
15b8d9332b92 usb: dwc3: gadget: giveback request if we can't kick it
8897a761c371 usb: dwc3: gadget: make use of No Response Update Transfer
5999914f227b usb: dwc3: gadget: properly check ep cmd
6b9018d4c1e5 usb: dwc3: gadget: set PCM1 field of isochronous-first TRBs

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 358 ++++++++++++-----------
 drivers/usb/dwc3/core.h   |  63 +++-
 drivers/usb/dwc3/debug.c  |  32 --
 drivers/usb/dwc3/debug.h  |  41 ++-
 drivers/usb/dwc3/ep0.c    | 391 +++++++++++++------------
 drivers/usb/dwc3/gadget.c | 594 ++++++++++++++++++++++----------------
 drivers/usb/dwc3/gadget.h |   5 +-
 drivers/usb/dwc3/io.h     |   6 +-
 8 files changed, 830 insertions(+), 660 deletions(-)
 delete mode 100644 drivers/usb/dwc3/debug.c

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index fea446900cad..369bab16a824 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -169,33 +169,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return -ETIMEDOUT;
 }
 
-/**
- * dwc3_soft_reset - Issue soft reset
- * @dwc: Pointer to our controller context structure
- */
-static int dwc3_soft_reset(struct dwc3 *dwc)
-{
-	unsigned long timeout;
-	u32 reg;
-
-	timeout = jiffies + msecs_to_jiffies(500);
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			break;
-
-		if (time_after(jiffies, timeout)) {
-			dev_err(dwc->dev, "Reset Timed Out\n");
-			return -ETIMEDOUT;
-		}
-
-		cpu_relax();
-	} while (true);
-
-	return 0;
-}
-
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -229,7 +202,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
+	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
 }
 
 /**
@@ -251,7 +224,11 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 
 	evt->dwc	= dwc;
 	evt->length	= length;
-	evt->buf	= dma_alloc_coherent(dwc->dev, length,
+	evt->cache	= devm_kzalloc(dwc->dev, length, GFP_KERNEL);
+	if (!evt->cache)
+		return ERR_PTR(-ENOMEM);
+
+	evt->buf	= dma_alloc_coherent(dwc->sysdev, length,
 			&evt->dma, GFP_KERNEL);
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
@@ -305,13 +282,7 @@ static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 	struct dwc3_event_buffer	*evt;
 
 	evt = dwc->ev_buf;
-	dwc3_trace(trace_dwc3_core,
-			"Event buf %p dma %08llx length %d\n",
-			evt->buf, (unsigned long long) evt->dma,
-			evt->length);
-
 	evt->lpos = 0;
-
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
 			lower_32_bits(evt->dma));
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
@@ -370,11 +341,11 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
 	if (!WARN_ON(dwc->scratchbuf))
 		return 0;
 
-	scratch_addr = dma_map_single(dwc->dev, dwc->scratchbuf,
+	scratch_addr = dma_map_single(dwc->sysdev, dwc->scratchbuf,
 			dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
 			DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dwc->dev, scratch_addr)) {
-		dev_err(dwc->dev, "failed to map scratch buffer\n");
+	if (dma_mapping_error(dwc->sysdev, scratch_addr)) {
+		dev_err(dwc->sysdev, "failed to map scratch buffer\n");
 		ret = -EFAULT;
 		goto err0;
 	}
@@ -398,7 +369,7 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
 	return 0;
 
 err1:
-	dma_unmap_single(dwc->dev, dwc->scratch_addr, dwc->nr_scratch *
+	dma_unmap_single(dwc->sysdev, dwc->scratch_addr, dwc->nr_scratch *
 			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
 
 err0:
@@ -417,7 +388,7 @@ static void dwc3_free_scratch_buffers(struct dwc3 *dwc)
 	if (!WARN_ON(dwc->scratchbuf))
 		return;
 
-	dma_unmap_single(dwc->dev, dwc->scratch_addr, dwc->nr_scratch *
+	dma_unmap_single(dwc->sysdev, dwc->scratch_addr, dwc->nr_scratch *
 			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
 	kfree(dwc->scratchbuf);
 }
@@ -428,9 +399,6 @@ static void dwc3_core_num_eps(struct dwc3 *dwc)
 
 	dwc->num_in_eps = DWC3_NUM_IN_EPS(parms);
 	dwc->num_out_eps = DWC3_NUM_EPS(parms) - dwc->num_in_eps;
-
-	dwc3_trace(trace_dwc3_core, "found %d IN and %d OUT endpoints",
-			dwc->num_in_eps, dwc->num_out_eps);
 }
 
 static void dwc3_cache_hwparams(struct dwc3 *dwc)
@@ -524,13 +492,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		}
 		/* FALLTHROUGH */
 	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
-		/* Making sure the interface and PHY are operational */
-		ret = dwc3_soft_reset(dwc);
-		if (ret)
-			return ret;
-
-		udelay(1);
-
 		ret = dwc3_ulpi_init(dwc);
 		if (ret)
 			return ret;
@@ -594,19 +555,12 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	phy_power_off(dwc->usb3_generic_phy);
 }
 
-/**
- * dwc3_core_init - Low-level initialization of DWC3 Core
- * @dwc: Pointer to our controller context structure
- *
- * Returns 0 on success otherwise negative errno.
- */
-static int dwc3_core_init(struct dwc3 *dwc)
+static bool dwc3_core_is_valid(struct dwc3 *dwc)
 {
-	u32			hwparams4 = dwc->hwparams.hwparams4;
-	u32			reg;
-	int			ret;
+	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
+
 	/* This should read as U3 followed by revision number */
 	if ((reg & DWC3_GSNPSID_MASK) == 0x55330000) {
 		/* Detected DWC_usb3 IP */
@@ -616,36 +570,16 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
 		dwc->revision |= DWC3_REVISION_IS_DWC31;
 	} else {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err0;
+		return false;
 	}
 
-	/*
-	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
-	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
-
-	/* Handle USB2.0-only core configuration */
-	if (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
-			DWC3_GHWPARAMS3_SSPHY_IFC_DIS) {
-		if (dwc->maximum_speed == USB_SPEED_SUPER)
-			dwc->maximum_speed = USB_SPEED_HIGH;
-	}
-
-	/* issue device SoftReset too */
-	ret = dwc3_soft_reset(dwc);
-	if (ret)
-		goto err0;
-
-	ret = dwc3_core_soft_reset(dwc);
-	if (ret)
-		goto err0;
+	return true;
+}
 
-	ret = dwc3_phy_setup(dwc);
-	if (ret)
-		goto err0;
+static void dwc3_core_setup_global_control(struct dwc3 *dwc)
+{
+	u32 hwparams4 = dwc->hwparams.hwparams4;
+	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
@@ -683,13 +617,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
 		break;
 	default:
-		dwc3_trace(trace_dwc3_core, "No power optimization available\n");
+		/* nothing */
+		break;
 	}
 
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
-		dwc3_trace(trace_dwc3_core,
-				"running on FPGA platform\n");
+		dev_info(dwc->dev, "Running with FPGA optmizations\n");
 		dwc->is_fpga = true;
 	}
 
@@ -714,7 +648,47 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		reg |= DWC3_GCTL_U2RSTECN;
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
+/**
+ * dwc3_core_init - Low-level initialization of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success otherwise negative errno.
+ */
+static int dwc3_core_init(struct dwc3 *dwc)
+{
+	u32			reg;
+	int			ret;
+
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		ret = -ENODEV;
+		goto err0;
+	}
+
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+
+	/* Handle USB2.0-only core configuration */
+	if (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
+			DWC3_GHWPARAMS3_SSPHY_IFC_DIS) {
+		if (dwc->maximum_speed == USB_SPEED_SUPER)
+			dwc->maximum_speed = USB_SPEED_HIGH;
+	}
+
+	ret = dwc3_core_soft_reset(dwc);
+	if (ret)
+		goto err0;
 
+	ret = dwc3_phy_setup(dwc);
+	if (ret)
+		goto err0;
+
+	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
 	ret = dwc3_setup_scratch_buffers(dwc);
@@ -766,6 +740,16 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * Enable hardware control of sending remote wakeup in HS when
+	 * the device is in the L1 state.
+	 */
+	if (dwc->revision >= DWC3_REVISION_290A) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+		reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
 	return 0;
 
 err4:
@@ -919,57 +903,13 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	}
 }
 
-#define DWC3_ALIGN_MASK		(16 - 1)
-
-static int dwc3_probe(struct platform_device *pdev)
+static void dwc3_get_properties(struct dwc3 *dwc)
 {
-	struct device		*dev = &pdev->dev;
-	struct resource		*res;
-	struct dwc3		*dwc;
+	struct device		*dev = dwc->dev;
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
 
-	int			ret;
-
-	void __iomem		*regs;
-	void			*mem;
-
-	mem = devm_kzalloc(dev, sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
-	if (!mem)
-		return -ENOMEM;
-
-	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
-	dwc->mem = mem;
-	dwc->dev = dev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "missing memory resource\n");
-		return -ENODEV;
-	}
-
-	dwc->xhci_resources[0].start = res->start;
-	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
-					DWC3_XHCI_REGS_END;
-	dwc->xhci_resources[0].flags = res->flags;
-	dwc->xhci_resources[0].name = res->name;
-
-	res->start += DWC3_GLOBALS_REGS_START;
-
-	/*
-	 * Request memory region but exclude xHCI regs,
-	 * since it will be requested by the xhci-plat driver.
-	 */
-	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		goto err0;
-	}
-
-	dwc->regs	= regs;
-	dwc->regs_size	= resource_size(res);
-
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xff;
 
@@ -986,6 +926,13 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->dr_mode = usb_get_dr_mode(dev);
 	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
 
+	dwc->sysdev_is_parent = device_property_read_bool(dev,
+				"linux,sysdev_is_parent");
+	if (dwc->sysdev_is_parent)
+		dwc->sysdev = dwc->dev->parent;
+	else
+		dwc->sysdev = dwc->dev;
+
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
 	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
@@ -1041,6 +988,112 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->hird_threshold = hird_threshold
 		| (dwc->is_utmi_l1_suspend << 4);
 
+	dwc->imod_interval = 0;
+}
+
+/* check whether the core supports IMOD */
+bool dwc3_has_imod(struct dwc3 *dwc)
+{
+	return ((dwc3_is_usb3(dwc) &&
+		 dwc->revision >= DWC3_REVISION_300A) ||
+		(dwc3_is_usb31(dwc) &&
+		 dwc->revision >= DWC3_USB31_REVISION_120A));
+}
+
+static void dwc3_check_params(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+
+	/* Check for proper value of imod_interval */
+	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
+		dev_warn(dwc->dev, "Interrupt moderation not supported\n");
+		dwc->imod_interval = 0;
+	}
+
+	/*
+	 * Workaround for STAR 9000961433 which affects only version
+	 * 3.00a of the DWC_usb3 core. This prevents the controller
+	 * interrupt from being masked while handling events. IMOD
+	 * allows us to work around this issue. Enable it for the
+	 * affected version.
+	 */
+	if (!dwc->imod_interval &&
+	    (dwc->revision == DWC3_REVISION_300A))
+		dwc->imod_interval = 1;
+
+	/* Check the maximum_speed parameter */
+	switch (dwc->maximum_speed) {
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
+		break;
+	default:
+		dev_err(dev, "invalid maximum_speed parameter %d\n",
+			dwc->maximum_speed);
+		/* fall through */
+	case USB_SPEED_UNKNOWN:
+		/* default to superspeed */
+		dwc->maximum_speed = USB_SPEED_SUPER;
+
+		/*
+		 * default to superspeed plus if we are capable.
+		 */
+		if (dwc3_is_usb31(dwc) &&
+		    (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
+		     DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
+			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
+
+		break;
+	}
+}
+
+static int dwc3_probe(struct platform_device *pdev)
+{
+	struct device		*dev = &pdev->dev;
+	struct resource		*res;
+	struct dwc3		*dwc;
+
+	int			ret;
+
+	void __iomem		*regs;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	dwc->xhci_resources[0].start = res->start;
+	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
+					DWC3_XHCI_REGS_END;
+	dwc->xhci_resources[0].flags = res->flags;
+	dwc->xhci_resources[0].name = res->name;
+
+	res->start += DWC3_GLOBALS_REGS_START;
+
+	/*
+	 * Request memory region but exclude xHCI regs,
+	 * since it will be requested by the xhci-plat driver.
+	 */
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err0;
+	}
+
+	dwc->regs	= regs;
+	dwc->regs_size	= resource_size(res);
+
+	dwc3_get_properties(dwc);
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1050,12 +1103,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	spin_lock_init(&dwc->lock);
 
-	if (!dev->dma_mask) {
-		dev->dma_mask = dev->parent->dma_mask;
-		dev->dma_parms = dev->parent->dma_parms;
-		dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
-	}
-
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
@@ -1087,32 +1134,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	/* Check the maximum_speed parameter */
-	switch (dwc->maximum_speed) {
-	case USB_SPEED_LOW:
-	case USB_SPEED_FULL:
-	case USB_SPEED_HIGH:
-	case USB_SPEED_SUPER:
-	case USB_SPEED_SUPER_PLUS:
-		break;
-	default:
-		dev_err(dev, "invalid maximum_speed parameter %d\n",
-			dwc->maximum_speed);
-		/* fall through */
-	case USB_SPEED_UNKNOWN:
-		/* default to superspeed */
-		dwc->maximum_speed = USB_SPEED_SUPER;
-
-		/*
-		 * default to superspeed plus if we are capable.
-		 */
-		if (dwc3_is_usb31(dwc) &&
-		    (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
-		     DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
-			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-
-		break;
-	}
+	dwc3_check_params(dwc);
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6b60e42626a2..14b760209680 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/debugfs.h>
+#include <linux/wait.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -37,15 +38,14 @@
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
+#define DWC3_PULL_UP_TIMEOUT	500	/* ms */
 #define DWC3_ZLP_BUF_SIZE	1024	/* size of a superspeed bulk */
 #define DWC3_EP0_BOUNCE_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
 
 #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
-#define DWC3_EVENT_SIZE		4	/* bytes */
-#define DWC3_EVENT_MAX_NUM	64	/* 2 events/endpoint */
-#define DWC3_EVENT_BUFFERS_SIZE	(DWC3_EVENT_SIZE * DWC3_EVENT_MAX_NUM)
+#define DWC3_EVENT_BUFFERS_SIZE	4096
 #define DWC3_EVENT_TYPE_MASK	0xfe
 
 #define DWC3_EVENT_TYPE_DEV	0
@@ -65,6 +65,7 @@
 #define DWC3_DEVICE_EVENT_OVERFLOW		11
 
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
+#define DWC3_GEVNTCOUNT_EHB	(1 << 31)
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
 
@@ -147,6 +148,8 @@
 #define DWC3_DEPCMDPAR0		0x08
 #define DWC3_DEPCMD		0x0c
 
+#define DWC3_DEV_IMOD(n)	(0xca00 + (n * 0x4))
+
 /* OTG Registers */
 #define DWC3_OCFG		0xcc00
 #define DWC3_OCTL		0xcc04
@@ -198,6 +201,9 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
 #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
 
+/* Global User Control 1 Register */
+#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	(1 << 24)
+
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
@@ -303,9 +309,8 @@
 #define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
-#define DWC3_DCFG_FULLSPEED2	(1 << 0)
+#define DWC3_DCFG_FULLSPEED	(1 << 0)
 #define DWC3_DCFG_LOWSPEED	(2 << 0)
-#define DWC3_DCFG_FULLSPEED1	(3 << 0)
 
 #define DWC3_DCFG_NUMP_SHIFT	17
 #define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
@@ -397,9 +402,8 @@
 #define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
-#define DWC3_DSTS_FULLSPEED2		(1 << 0)
+#define DWC3_DSTS_FULLSPEED		(1 << 0)
 #define DWC3_DSTS_LOWSPEED		(2 << 0)
-#define DWC3_DSTS_FULLSPEED1		(3 << 0)
 
 /* Device Generic Command Register */
 #define DWC3_DGCMD_SET_LMP		0x01
@@ -450,6 +454,8 @@
 #define DWC3_DEPCMD_SETTRANSFRESOURCE	(0x02 << 0)
 #define DWC3_DEPCMD_SETEPCONFIG		(0x01 << 0)
 
+#define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
+
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
 #define DWC3_DALEPENA_EP(n)		(1 << n)
 
@@ -458,6 +464,11 @@
 #define DWC3_DEPCMD_TYPE_BULK		2
 #define DWC3_DEPCMD_TYPE_INTR		3
 
+#define DWC3_DEV_IMOD_COUNT_SHIFT	16
+#define DWC3_DEV_IMOD_COUNT_MASK	(0xffff << 16)
+#define DWC3_DEV_IMOD_INTERVAL_SHIFT	0
+#define DWC3_DEV_IMOD_INTERVAL_MASK	(0xffff << 0)
+
 /* Structures */
 
 struct dwc3_trb;
@@ -465,6 +476,7 @@ struct dwc3_trb;
 /**
  * struct dwc3_event_buffer - Software event buffer representation
  * @buf: _THE_ buffer
+ * @cache: The buffer cache used in the threaded interrupt
  * @length: size of this buffer
  * @lpos: event offset
  * @count: cache of last read event count register
@@ -474,6 +486,7 @@ struct dwc3_trb;
  */
 struct dwc3_event_buffer {
 	void			*buf;
+	void			*cache;
 	unsigned		length;
 	unsigned int		lpos;
 	unsigned int		count;
@@ -499,6 +512,7 @@ struct dwc3_event_buffer {
  * @endpoint: usb endpoint
  * @pending_list: list of pending requests for this endpoint
  * @started_list: list of started requests on this endpoint
+ * @wait_end_transfer: wait_queue_head_t for waiting on End Transfer complete
  * @lock: spinlock for endpoint request queue traversal
  * @regs: pointer to first endpoint register
  * @trb_pool: array of transaction buffers
@@ -524,12 +538,13 @@ struct dwc3_ep {
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
+	wait_queue_head_t	wait_end_transfer;
+
 	spinlock_t		lock;
 	void __iomem		*regs;
 
 	struct dwc3_trb		*trb_pool;
 	dma_addr_t		trb_pool_dma;
-	const struct usb_ss_ep_comp_descriptor *comp_desc;
 	struct dwc3		*dwc;
 
 	u32			saved_state;
@@ -540,6 +555,8 @@ struct dwc3_ep {
 #define DWC3_EP_BUSY		(1 << 4)
 #define DWC3_EP_PENDING_REQUEST	(1 << 5)
 #define DWC3_EP_MISSED_ISOC	(1 << 6)
+#define DWC3_EP_END_TRANSFER_PENDING	(1 << 7)
+#define DWC3_EP_TRANSFER_STARTED (1 << 8)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		(1 << 31)
@@ -703,7 +720,7 @@ struct dwc3_hwparams {
  * @dep: struct dwc3_ep owning this request
  * @sg: pointer to first incomplete sg
  * @num_pending_sgs: counter to pending sgs
- * @first_trb_index: index to first trb used by this request
+ * @remaining: amount of data remaining
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
@@ -718,7 +735,7 @@ struct dwc3_request {
 	struct scatterlist	*sg;
 
 	unsigned		num_pending_sgs;
-	u8			first_trb_index;
+	unsigned		remaining;
 	u8			epnum;
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
@@ -748,6 +765,7 @@ struct dwc3_scratchpad_array {
  * @ep0_usb_req: dummy req used while handling STD USB requests
  * @ep0_bounce_addr: dma address of ep0_bounce
  * @scratch_addr: dma address of scratchbuf
+ * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
  * @dev: pointer to our struct device
  * @xhci: pointer to our xHCI child
@@ -784,7 +802,6 @@ struct dwc3_scratchpad_array {
  * @ep0state: state of endpoint zero
  * @link_state: link state
  * @speed: device speed (super, high, full, low)
- * @mem: points to start of memory which is used for this struct.
  * @hwparams: copy of hwparams registers
  * @root: debugfs root folder pointer
  * @regset: debugfs pointer to regdump file
@@ -798,6 +815,7 @@ struct dwc3_scratchpad_array {
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
  * @has_hibernation: true when dwc3 was configured with Hibernation
+ * @sysdev_is_parent: true when dwc3 device has a parent driver
  * @has_lpm_erratum: true when core was configured with LPM Erratum. Note that
  *			there's now way for software to detect this in runtime.
  * @is_utmi_l1_suspend: the core asserts output signal
@@ -833,6 +851,8 @@ struct dwc3_scratchpad_array {
  * 	1	- -3.5dB de-emphasis
  * 	2	- No de-emphasis
  * 	3	- Reserved
+ * @imod_interval: set the interrupt moderation interval in 250ns
+ *                 increments or 0 to disable.
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -846,11 +866,13 @@ struct dwc3 {
 	dma_addr_t		ep0_bounce_addr;
 	dma_addr_t		scratch_addr;
 	struct dwc3_request	ep0_usb_req;
+	struct completion	ep0_in_setup;
 
 	/* device lock */
 	spinlock_t		lock;
 
 	struct device		*dev;
+	struct device		*sysdev;
 
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
@@ -909,6 +931,7 @@ struct dwc3 {
 #define DWC3_REVISION_260A	0x5533260a
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
+#define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
 
@@ -918,6 +941,7 @@ struct dwc3 {
  */
 #define DWC3_REVISION_IS_DWC31		0x80000000
 #define DWC3_USB31_REVISION_110A	(0x3131302a | DWC3_REVISION_IS_DWC31)
+#define DWC3_USB31_REVISION_120A	(0x3132302a | DWC3_REVISION_IS_DWC31)
 
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
@@ -934,8 +958,6 @@ struct dwc3 {
 	u8			num_out_eps;
 	u8			num_in_eps;
 
-	void			*mem;
-
 	struct dwc3_hwparams	hwparams;
 	struct dentry		*root;
 	struct debugfs_regset32	*regset;
@@ -952,6 +974,7 @@ struct dwc3 {
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
 	unsigned		has_hibernation:1;
+	unsigned		sysdev_is_parent:1;
 	unsigned		has_lpm_erratum:1;
 	unsigned		is_utmi_l1_suspend:1;
 	unsigned		is_fpga:1;
@@ -978,6 +1001,8 @@ struct dwc3 {
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
+
+	u16			imod_interval;
 };
 
 /* -------------------------------------------------------------------------- */
@@ -1039,12 +1064,16 @@ struct dwc3_event_depevt {
 /* Control-only Status */
 #define DEPEVT_STATUS_CONTROL_DATA	1
 #define DEPEVT_STATUS_CONTROL_STATUS	2
+#define DEPEVT_STATUS_CONTROL_PHASE(n)	((n) & 3)
 
 /* In response to Start Transfer */
 #define DEPEVT_TRANSFER_NO_RESOURCE	1
 #define DEPEVT_TRANSFER_BUS_EXPIRY	2
 
 	u32	parameters:16;
+
+/* For Command Complete Events */
+#define DEPEVT_PARAMETER_CMD(n)	(((n) & (0xf << 8)) >> 8)
 } __packed;
 
 /**
@@ -1133,12 +1162,20 @@ struct dwc3_gadget_ep_cmd_params {
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
+/* check whether we are on the DWC_usb3 core */
+static inline bool dwc3_is_usb3(struct dwc3 *dwc)
+{
+	return !(dwc->revision & DWC3_REVISION_IS_DWC31);
+}
+
 /* check whether we are on the DWC_usb31 core */
 static inline bool dwc3_is_usb31(struct dwc3 *dwc)
 {
 	return !!(dwc->revision & DWC3_REVISION_IS_DWC31);
 }
 
+bool dwc3_has_imod(struct dwc3 *dwc);
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/debug.c b/drivers/usb/dwc3/debug.c
deleted file mode 100644
index 0be6885bc370..000000000000
--- a/drivers/usb/dwc3/debug.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/**
- * debug.c - DesignWare USB3 DRD Controller Debug/Trace Support
- *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
- *
- * Author: Felipe Balbi <balbi@ti.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include "debug.h"
-
-void dwc3_trace(void (*trace)(struct va_format *), const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	trace(&vaf);
-
-	va_end(args);
-}
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 33ab2a203c1b..eeed4ffd8131 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -124,6 +124,22 @@ dwc3_gadget_link_string(enum dwc3_link_state link_state)
 	}
 }
 
+static inline const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
+{
+	switch (state) {
+	case EP0_UNCONNECTED:
+		return "Unconnected";
+	case EP0_SETUP_PHASE:
+		return "Setup Phase";
+	case EP0_DATA_PHASE:
+		return "Data Phase";
+	case EP0_STATUS_PHASE:
+		return "Status Phase";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 /**
  * dwc3_gadget_event_string - returns event name
  * @event: the event code
@@ -184,10 +200,11 @@ dwc3_gadget_event_string(const struct dwc3_event_devt *event)
  * @event: then event code
  */
 static inline const char *
-dwc3_ep_event_string(const struct dwc3_event_depevt *event)
+dwc3_ep_event_string(const struct dwc3_event_depevt *event, u32 ep0state)
 {
 	u8 epnum = event->endpoint_number;
 	static char str[256];
+	size_t len;
 	int status;
 	int ret;
 
@@ -199,6 +216,10 @@ dwc3_ep_event_string(const struct dwc3_event_depevt *event)
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		strcat(str, "Transfer Complete");
+		len = strlen(str);
+
+		if (epnum <= 1)
+			sprintf(str + len, " [%s]", dwc3_ep0_state_string(ep0state));
 		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		strcat(str, "Transfer In-Progress");
@@ -207,6 +228,19 @@ dwc3_ep_event_string(const struct dwc3_event_depevt *event)
 		strcat(str, "Transfer Not Ready");
 		status = event->status & DEPEVT_STATUS_TRANSFER_ACTIVE;
 		strcat(str, status ? " (Active)" : " (Not Active)");
+
+		/* Control Endpoints */
+		if (epnum <= 1) {
+			int phase = DEPEVT_STATUS_CONTROL_PHASE(event->status);
+
+			switch (phase) {
+			case DEPEVT_STATUS_CONTROL_DATA:
+				strcat(str, " [Data Phase]");
+				break;
+			case DEPEVT_STATUS_CONTROL_STATUS:
+				strcat(str, " [Status Phase]");
+			}
+		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		strcat(str, "FIFO");
@@ -270,14 +304,14 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 	}
 }
 
-static inline const char *dwc3_decode_event(u32 event)
+static inline const char *dwc3_decode_event(u32 event, u32 ep0state)
 {
 	const union dwc3_event evt = (union dwc3_event) event;
 
 	if (evt.type.is_devspec)
 		return dwc3_gadget_event_string(&evt.devt);
 	else
-		return dwc3_ep_event_string(&evt.depevt);
+		return dwc3_ep_event_string(&evt.depevt, ep0state);
 }
 
 static inline const char *dwc3_ep_cmd_status_string(int status)
@@ -310,7 +344,6 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 	}
 }
 
-void dwc3_trace(void (*trace)(struct va_format *), const char *fmt, ...);
 
 #ifdef CONFIG_DEBUG_FS
 extern void dwc3_debugfs_init(struct dwc3 *);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index fe79d771dee4..9bb1f8526f3e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -39,36 +39,13 @@ static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
 
-static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
+static void dwc3_ep0_prepare_one_trb(struct dwc3 *dwc, u8 epnum,
+		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
 {
-	switch (state) {
-	case EP0_UNCONNECTED:
-		return "Unconnected";
-	case EP0_SETUP_PHASE:
-		return "Setup Phase";
-	case EP0_DATA_PHASE:
-		return "Data Phase";
-	case EP0_STATUS_PHASE:
-		return "Status Phase";
-	default:
-		return "UNKNOWN";
-	}
-}
-
-static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
-		u32 len, u32 type, bool chain)
-{
-	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_trb			*trb;
 	struct dwc3_ep			*dep;
 
-	int				ret;
-
 	dep = dwc->eps[epnum];
-	if (dep->flags & DWC3_EP_BUSY) {
-		dwc3_trace(trace_dwc3_ep0, "%s still busy", dep->name);
-		return 0;
-	}
 
 	trb = &dwc->ep0_trb[dep->trb_enqueue];
 
@@ -89,21 +66,26 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 		trb->ctrl |= (DWC3_TRB_CTRL_IOC
 				| DWC3_TRB_CTRL_LST);
 
-	if (chain)
+	trace_dwc3_prepare_trb(dep, trb);
+}
+
+static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep			*dep;
+	int				ret;
+
+	dep = dwc->eps[epnum];
+	if (dep->flags & DWC3_EP_BUSY)
 		return 0;
 
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
 
-	trace_dwc3_prepare_trb(dep, trb);
-
 	ret = dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_STARTTRANSFER, &params);
-	if (ret < 0) {
-		dwc3_trace(trace_dwc3_ep0, "%s STARTTRANSFER failed",
-				dep->name);
+	if (ret < 0)
 		return ret;
-	}
 
 	dep->flags |= DWC3_EP_BUSY;
 	dep->resource_index = dwc3_gadget_ep_get_transfer_index(dep);
@@ -163,9 +145,6 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 
 		if (dwc->ep0state == EP0_STATUS_PHASE)
 			__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
-		else
-			dwc3_trace(trace_dwc3_ep0,
-					"too early for delayed status");
 
 		return 0;
 	}
@@ -229,9 +208,8 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (!dep->endpoint.desc) {
-		dwc3_trace(trace_dwc3_ep0,
-				"trying to queue request %p to disabled %s",
-				request, dep->name);
+		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
+				dep->name);
 		ret = -ESHUTDOWN;
 		goto out;
 	}
@@ -242,11 +220,6 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		goto out;
 	}
 
-	dwc3_trace(trace_dwc3_ep0,
-			"queueing request %p to %s length %d state '%s'",
-			request, dep->name, request->length,
-			dwc3_ep0_state_string(dwc->ep0state));
-
 	ret = __dwc3_gadget_ep0_queue(dep, req);
 
 out:
@@ -308,8 +281,11 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
 	int				ret;
 
-	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
+	complete(&dwc->ep0_in_setup);
+
+	dwc3_ep0_prepare_one_trb(dwc, 0, dwc->ctrl_req_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
+	ret = dwc3_ep0_start_trans(dwc, 0);
 	WARN_ON(ret < 0);
 }
 
@@ -395,126 +371,198 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
 }
 
-static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
+static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum usb_device_state state,
+		int set)
+{
+	u32 reg;
+
+	if (state != USB_STATE_CONFIGURED)
+		return -EINVAL;
+	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
+		return -EINVAL;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	if (set)
+		reg |= DWC3_DCTL_INITU1ENA;
+	else
+		reg &= ~DWC3_DCTL_INITU1ENA;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum usb_device_state state,
+		int set)
+{
+	u32 reg;
+
+
+	if (state != USB_STATE_CONFIGURED)
+		return -EINVAL;
+	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
+		return -EINVAL;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	if (set)
+		reg |= DWC3_DCTL_INITU2ENA;
+	else
+		reg &= ~DWC3_DCTL_INITU2ENA;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_test(struct dwc3 *dwc, enum usb_device_state state,
+		u32 wIndex, int set)
+{
+	if ((wIndex & 0xff) != 0)
+		return -EINVAL;
+	if (!set)
+		return -EINVAL;
+
+	switch (wIndex >> 8) {
+	case TEST_J:
+	case TEST_K:
+	case TEST_SE0_NAK:
+	case TEST_PACKET:
+	case TEST_FORCE_EN:
+		dwc->test_mode_nr = wIndex >> 8;
+		dwc->test_mode = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 		struct usb_ctrlrequest *ctrl, int set)
 {
-	struct dwc3_ep		*dep;
-	u32			recip;
+	enum usb_device_state	state;
 	u32			wValue;
 	u32			wIndex;
-	u32			reg;
-	int			ret;
-	enum usb_device_state	state;
+	int			ret = 0;
 
 	wValue = le16_to_cpu(ctrl->wValue);
 	wIndex = le16_to_cpu(ctrl->wIndex);
-	recip = ctrl->bRequestType & USB_RECIP_MASK;
 	state = dwc->gadget.state;
 
-	switch (recip) {
-	case USB_RECIP_DEVICE:
+	switch (wValue) {
+	case USB_DEVICE_REMOTE_WAKEUP:
+		break;
+	/*
+	 * 9.4.1 says only only for SS, in AddressState only for
+	 * default control pipe
+	 */
+	case USB_DEVICE_U1_ENABLE:
+		ret = dwc3_ep0_handle_u1(dwc, state, set);
+		break;
+	case USB_DEVICE_U2_ENABLE:
+		ret = dwc3_ep0_handle_u2(dwc, state, set);
+		break;
+	case USB_DEVICE_LTM_ENABLE:
+		ret = -EINVAL;
+		break;
+	case USB_DEVICE_TEST_MODE:
+		ret = dwc3_ep0_handle_test(dwc, state, wIndex, set);
+		break;
+	default:
+		ret = -EINVAL;
+	}
 
-		switch (wValue) {
-		case USB_DEVICE_REMOTE_WAKEUP:
-			break;
+	return ret;
+}
+
+static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	enum usb_device_state	state;
+	u32			wValue;
+	u32			wIndex;
+	int			ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	state = dwc->gadget.state;
+
+	switch (wValue) {
+	case USB_INTRF_FUNC_SUSPEND:
 		/*
-		 * 9.4.1 says only only for SS, in AddressState only for
-		 * default control pipe
+		 * REVISIT: Ideally we would enable some low power mode here,
+		 * however it's unclear what we should be doing here.
+		 *
+		 * For now, we're not doing anything, just making sure we return
+		 * 0 so USB Command Verifier tests pass without any errors.
 		 */
-		case USB_DEVICE_U1_ENABLE:
-			if (state != USB_STATE_CONFIGURED)
-				return -EINVAL;
-			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
-			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
-				return -EINVAL;
+		break;
+	default:
+		ret = -EINVAL;
+	}
 
-			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			if (set)
-				reg |= DWC3_DCTL_INITU1ENA;
-			else
-				reg &= ~DWC3_DCTL_INITU1ENA;
-			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-			break;
+	return ret;
+}
 
-		case USB_DEVICE_U2_ENABLE:
-			if (state != USB_STATE_CONFIGURED)
-				return -EINVAL;
-			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
-			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
-				return -EINVAL;
+static int dwc3_ep0_handle_endpoint(struct dwc3 *dwc,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	struct dwc3_ep		*dep;
+	enum usb_device_state	state;
+	u32			wValue;
+	u32			wIndex;
+	int			ret;
 
-			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			if (set)
-				reg |= DWC3_DCTL_INITU2ENA;
-			else
-				reg &= ~DWC3_DCTL_INITU2ENA;
-			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-			break;
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	state = dwc->gadget.state;
 
-		case USB_DEVICE_LTM_ENABLE:
+	switch (wValue) {
+	case USB_ENDPOINT_HALT:
+		dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
+		if (!dep)
 			return -EINVAL;
 
-		case USB_DEVICE_TEST_MODE:
-			if ((wIndex & 0xff) != 0)
-				return -EINVAL;
-			if (!set)
-				return -EINVAL;
-
-			switch (wIndex >> 8) {
-			case TEST_J:
-			case TEST_K:
-			case TEST_SE0_NAK:
-			case TEST_PACKET:
-			case TEST_FORCE_EN:
-				dwc->test_mode_nr = wIndex >> 8;
-				dwc->test_mode = true;
-				break;
-			default:
-				return -EINVAL;
-			}
+		if (set == 0 && (dep->flags & DWC3_EP_WEDGE))
 			break;
-		default:
+
+		ret = __dwc3_gadget_ep_set_halt(dep, set, true);
+		if (ret)
 			return -EINVAL;
-		}
 		break;
+	default:
+		return -EINVAL;
+	}
 
+	return 0;
+}
+
+static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	u32			recip;
+	int			ret;
+	enum usb_device_state	state;
+
+	recip = ctrl->bRequestType & USB_RECIP_MASK;
+	state = dwc->gadget.state;
+
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		ret = dwc3_ep0_handle_device(dwc, ctrl, set);
+		break;
 	case USB_RECIP_INTERFACE:
-		switch (wValue) {
-		case USB_INTRF_FUNC_SUSPEND:
-			if (wIndex & USB_INTRF_FUNC_SUSPEND_LP)
-				/* XXX enable Low power suspend */
-				;
-			if (wIndex & USB_INTRF_FUNC_SUSPEND_RW)
-				/* XXX enable remote wakeup */
-				;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret = dwc3_ep0_handle_intf(dwc, ctrl, set);
 		break;
-
 	case USB_RECIP_ENDPOINT:
-		switch (wValue) {
-		case USB_ENDPOINT_HALT:
-			dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
-			if (!dep)
-				return -EINVAL;
-			if (set == 0 && (dep->flags & DWC3_EP_WEDGE))
-				break;
-			ret = __dwc3_gadget_ep_set_halt(dep, set, true);
-			if (ret)
-				return -EINVAL;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret = dwc3_ep0_handle_endpoint(dwc, ctrl, set);
 		break;
-
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
@@ -525,13 +573,12 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 	addr = le16_to_cpu(ctrl->wValue);
 	if (addr > 127) {
-		dwc3_trace(trace_dwc3_ep0, "invalid device address %d", addr);
+		dev_err(dwc->dev, "invalid device address %d\n", addr);
 		return -EINVAL;
 	}
 
 	if (state == USB_STATE_CONFIGURED) {
-		dwc3_trace(trace_dwc3_ep0,
-				"trying to set address when configured");
+		dev_err(dwc->dev, "can't SetAddress() from Configured State\n");
 		return -EINVAL;
 	}
 
@@ -716,35 +763,27 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 	switch (ctrl->bRequest) {
 	case USB_REQ_GET_STATUS:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_GET_STATUS");
 		ret = dwc3_ep0_handle_status(dwc, ctrl);
 		break;
 	case USB_REQ_CLEAR_FEATURE:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_CLEAR_FEATURE");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 0);
 		break;
 	case USB_REQ_SET_FEATURE:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_FEATURE");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 1);
 		break;
 	case USB_REQ_SET_ADDRESS:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ADDRESS");
 		ret = dwc3_ep0_set_address(dwc, ctrl);
 		break;
 	case USB_REQ_SET_CONFIGURATION:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_CONFIGURATION");
 		ret = dwc3_ep0_set_config(dwc, ctrl);
 		break;
 	case USB_REQ_SET_SEL:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_SEL");
 		ret = dwc3_ep0_set_sel(dwc, ctrl);
 		break;
 	case USB_REQ_SET_ISOCH_DELAY:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ISOCH_DELAY");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
 	default:
-		dwc3_trace(trace_dwc3_ep0, "Forwarding to gadget driver");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		break;
 	}
@@ -820,9 +859,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING) {
 		dwc->setup_packet_pending = true;
-
-		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
-
 		if (r)
 			dwc3_gadget_giveback(ep0, r, -ECONNRESET);
 
@@ -880,9 +916,9 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 			dwc->ep0_next_event = DWC3_EP0_COMPLETE;
 
-			ret = dwc3_ep0_start_trans(dwc, epnum,
-					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA, false);
+			dwc3_ep0_prepare_one_trb(dwc, epnum, dwc->ctrl_req_addr,
+					0, DWC3_TRBCTL_CONTROL_DATA, false);
+			ret = dwc3_ep0_start_trans(dwc, epnum);
 			WARN_ON(ret < 0);
 		}
 	}
@@ -912,7 +948,7 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 
 		ret = dwc3_gadget_set_test_mode(dwc, dwc->test_mode_nr);
 		if (ret < 0) {
-			dwc3_trace(trace_dwc3_ep0, "Invalid Test #%d",
+			dev_err(dwc->dev, "invalid test #%d\n",
 					dwc->test_mode_nr);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
@@ -920,10 +956,8 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 	}
 
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
-	if (status == DWC3_TRBSTS_SETUP_PENDING) {
+	if (status == DWC3_TRBSTS_SETUP_PENDING)
 		dwc->setup_packet_pending = true;
-		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
-	}
 
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
@@ -940,17 +974,14 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
 
 	switch (dwc->ep0state) {
 	case EP0_SETUP_PHASE:
-		dwc3_trace(trace_dwc3_ep0, "Setup Phase");
 		dwc3_ep0_inspect_setup(dwc, event);
 		break;
 
 	case EP0_DATA_PHASE:
-		dwc3_trace(trace_dwc3_ep0, "Data Phase");
 		dwc3_ep0_complete_data(dwc, event);
 		break;
 
 	case EP0_STATUS_PHASE:
-		dwc3_trace(trace_dwc3_ep0, "Status Phase");
 		dwc3_ep0_complete_status(dwc, event);
 		break;
 	default:
@@ -966,27 +997,26 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	req->direction = !!dep->number;
 
 	if (req->request.length == 0) {
-		ret = dwc3_ep0_start_trans(dwc, dep->number,
+		dwc3_ep0_prepare_one_trb(dwc, dep->number,
 				dwc->ctrl_req_addr, 0,
 				DWC3_TRBCTL_CONTROL_DATA, false);
+		ret = dwc3_ep0_start_trans(dwc, dep->number);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
 		u32	transfer_size = 0;
 		u32	maxpacket;
 
-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
-				dep->number);
-		if (ret) {
-			dwc3_trace(trace_dwc3_ep0, "failed to map request");
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
+				&req->request, dep->number);
+		if (ret)
 			return;
-		}
 
 		maxpacket = dep->endpoint.maxpacket;
 
 		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
 			transfer_size = ALIGN(req->request.length - maxpacket,
 					      maxpacket);
-			ret = dwc3_ep0_start_trans(dwc, dep->number,
+			dwc3_ep0_prepare_one_trb(dwc, dep->number,
 						   req->request.dma,
 						   transfer_size,
 						   DWC3_TRBCTL_CONTROL_DATA,
@@ -998,20 +1028,20 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 
 		dwc->ep0_bounced = true;
 
-		ret = dwc3_ep0_start_trans(dwc, dep->number,
+		dwc3_ep0_prepare_one_trb(dwc, dep->number,
 				dwc->ep0_bounce_addr, transfer_size,
 				DWC3_TRBCTL_CONTROL_DATA, false);
+		ret = dwc3_ep0_start_trans(dwc, dep->number);
 	} else {
-		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
-				dep->number);
-		if (ret) {
-			dwc3_trace(trace_dwc3_ep0, "failed to map request");
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
+				&req->request, dep->number);
+		if (ret)
 			return;
-		}
 
-		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
+		dwc3_ep0_prepare_one_trb(dwc, dep->number, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
+		ret = dwc3_ep0_start_trans(dwc, dep->number);
 	}
 
 	WARN_ON(ret < 0);
@@ -1025,8 +1055,9 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 	type = dwc->three_stage_setup ? DWC3_TRBCTL_CONTROL_STATUS3
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
-	return dwc3_ep0_start_trans(dwc, dep->number,
+	dwc3_ep0_prepare_one_trb(dwc, dep->number,
 			dwc->ctrl_req_addr, 0, type, false);
+	return dwc3_ep0_start_trans(dwc, dep->number);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
@@ -1065,8 +1096,6 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 {
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
-		dwc3_trace(trace_dwc3_ep0, "Control Data");
-
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
@@ -1079,8 +1108,7 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_expect_in != event->endpoint_number) {
 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
 
-			dwc3_trace(trace_dwc3_ep0,
-					"Wrong direction for Data phase");
+			dev_err(dwc->dev, "unexpected direction for Data Phase\n");
 			dwc3_ep0_end_control_data(dwc, dep);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
@@ -1092,13 +1120,10 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_next_event != DWC3_EP0_NRDY_STATUS)
 			return;
 
-		dwc3_trace(trace_dwc3_ep0, "Control Status");
-
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
 			WARN_ON_ONCE(event->endpoint_number != 1);
-			dwc3_trace(trace_dwc3_ep0, "Delayed Status");
 			return;
 		}
 
@@ -1109,10 +1134,6 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	dwc3_trace(trace_dwc3_ep0, "%s: state '%s'",
-			dwc3_ep_event_string(event),
-			dwc3_ep0_state_string(dwc->ep0state));
-
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		dwc3_ep0_xfer_complete(dwc, event);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1dfa56a5f1c5..204c754cc647 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -139,9 +139,6 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 		udelay(5);
 	}
 
-	dwc3_trace(trace_dwc3_gadget,
-			"link state change request timed out");
-
 	return -ETIMEDOUT;
 }
 
@@ -178,15 +175,16 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	req->started = false;
 	list_del(&req->list);
 	req->trb = NULL;
+	req->remaining = 0;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
-	if (dwc->ep0_bounced && dep->number == 0)
+	if (dwc->ep0_bounced && dep->number <= 1)
 		dwc->ep0_bounced = false;
-	else
-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
-				req->direction);
+
+	usb_gadget_unmap_request_by_dev(dwc->sysdev,
+			&req->request, req->direction);
 
 	trace_dwc3_gadget_giveback(req);
 
@@ -216,7 +214,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 				ret = -EINVAL;
 			break;
 		}
-	} while (timeout--);
+	} while (--timeout);
 
 	if (!timeout) {
 		ret = -ETIMEDOUT;
@@ -233,6 +231,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
 int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
 {
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
 	u32			timeout = 500;
 	u32			reg;
@@ -258,7 +257,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 		}
 	}
 
-	if (cmd == DWC3_DEPCMD_STARTTRANSFER) {
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
 		int		needs_wakeup;
 
 		needs_wakeup = (dwc->link_state == DWC3_LINK_STATE_U1 ||
@@ -276,7 +275,28 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 	dwc3_writel(dep->regs, DWC3_DEPCMDPAR1, params->param1);
 	dwc3_writel(dep->regs, DWC3_DEPCMDPAR2, params->param2);
 
-	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd | DWC3_DEPCMD_CMDACT);
+	/*
+	 * Synopsys Databook 2.60a states in section 6.3.2.5.6 of that if we're
+	 * not relying on XferNotReady, we can make use of a special "No
+	 * Response Update Transfer" command where we should clear both CmdAct
+	 * and CmdIOC bits.
+	 *
+	 * With this, we don't need to wait for command completion and can
+	 * straight away issue further commands to the endpoint.
+	 *
+	 * NOTICE: We're making an assumption that control endpoints will never
+	 * make use of Update Transfer command. This is a safe assumption
+	 * because we can never have more than one request at a time with
+	 * Control Endpoints. If anybody changes that assumption, this chunk
+	 * needs to be updated accordingly.
+	 */
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_UPDATETRANSFER &&
+			!usb_endpoint_xfer_isoc(desc))
+		cmd &= ~(DWC3_DEPCMD_CMDIOC | DWC3_DEPCMD_CMDACT);
+	else
+		cmd |= DWC3_DEPCMD_CMDACT;
+
+	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
 	do {
 		reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
@@ -318,6 +338,20 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 
 	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
 
+	if (ret == 0) {
+		switch (DWC3_DEPCMD_CMD(cmd)) {
+		case DWC3_DEPCMD_STARTTRANSFER:
+			dep->flags |= DWC3_EP_TRANSFER_STARTED;
+			break;
+		case DWC3_DEPCMD_ENDTRANSFER:
+			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+			break;
+		default:
+			/* nothing */
+			break;
+		}
+	}
+
 	if (unlikely(susphy)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
@@ -365,7 +399,7 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 	if (dep->trb_pool)
 		return 0;
 
-	dep->trb_pool = dma_alloc_coherent(dwc->dev,
+	dep->trb_pool = dma_alloc_coherent(dwc->sysdev,
 			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
 			&dep->trb_pool_dma, GFP_KERNEL);
 	if (!dep->trb_pool) {
@@ -381,7 +415,7 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 {
 	struct dwc3		*dwc = dep->dwc;
 
-	dma_free_coherent(dwc->dev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+	dma_free_coherent(dwc->sysdev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
 			dep->trb_pool, dep->trb_pool_dma);
 
 	dep->trb_pool = NULL;
@@ -454,16 +488,19 @@ static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 }
 
 static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
-		const struct usb_endpoint_descriptor *desc,
-		const struct usb_ss_ep_comp_descriptor *comp_desc,
 		bool modify, bool restore)
 {
+	const struct usb_ss_ep_comp_descriptor *comp_desc;
+	const struct usb_endpoint_descriptor *desc;
 	struct dwc3_gadget_ep_cmd_params params;
 
 	if (dev_WARN_ONCE(dwc->dev, modify && restore,
 					"Can't modify and restore\n"))
 		return -EINVAL;
 
+	comp_desc = dep->endpoint.comp_desc;
+	desc = dep->endpoint.desc;
+
 	memset(&params, 0x00, sizeof(params));
 
 	params.param0 = DWC3_DEPCFG_EP_TYPE(usb_endpoint_type(desc))
@@ -542,24 +579,21 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep)
  * Caller should take care of locking
  */
 static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
-		const struct usb_endpoint_descriptor *desc,
-		const struct usb_ss_ep_comp_descriptor *comp_desc,
 		bool modify, bool restore)
 {
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
+
 	u32			reg;
 	int			ret;
 
-	dwc3_trace(trace_dwc3_gadget, "Enabling %s", dep->name);
-
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		ret = dwc3_gadget_start_config(dwc, dep);
 		if (ret)
 			return ret;
 	}
 
-	ret = dwc3_gadget_set_ep_config(dwc, dep, desc, comp_desc, modify,
-			restore);
+	ret = dwc3_gadget_set_ep_config(dwc, dep, modify, restore);
 	if (ret)
 		return ret;
 
@@ -567,17 +601,18 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		struct dwc3_trb	*trb_st_hw;
 		struct dwc3_trb	*trb_link;
 
-		dep->endpoint.desc = desc;
-		dep->comp_desc = comp_desc;
 		dep->type = usb_endpoint_type(desc);
 		dep->flags |= DWC3_EP_ENABLED;
+		dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 
 		reg = dwc3_readl(dwc->regs, DWC3_DALEPENA);
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+		init_waitqueue_head(&dep->wait_end_transfer);
+
 		if (usb_endpoint_xfer_control(desc))
-			return 0;
+			goto out;
 
 		/* Initialize the TRB ring */
 		dep->trb_dequeue = 0;
@@ -595,6 +630,39 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+	/*
+	 * Issue StartTransfer here with no-op TRB so we can always rely on No
+	 * Response Update Transfer command.
+	 */
+	if (usb_endpoint_xfer_bulk(desc)) {
+		struct dwc3_gadget_ep_cmd_params params;
+		struct dwc3_trb	*trb;
+		dma_addr_t trb_dma;
+		u32 cmd;
+
+		memset(&params, 0, sizeof(params));
+		trb = &dep->trb_pool[0];
+		trb_dma = dwc3_trb_dma_offset(dep, trb);
+
+		params.param0 = upper_32_bits(trb_dma);
+		params.param1 = lower_32_bits(trb_dma);
+
+		cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+		if (ret < 0)
+			return ret;
+
+		dep->flags |= DWC3_EP_BUSY;
+
+		dep->resource_index = dwc3_gadget_ep_get_transfer_index(dep);
+		WARN_ON_ONCE(!dep->resource_index);
+	}
+
+
+out:
+	trace_dwc3_gadget_ep_enable(dep);
+
 	return 0;
 }
 
@@ -632,7 +700,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
 
-	dwc3_trace(trace_dwc3_gadget, "Disabling %s", dep->name);
+	trace_dwc3_gadget_ep_disable(dep);
 
 	dwc3_remove_requests(dwc, dep);
 
@@ -645,10 +713,14 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
 	dep->stream_capable = false;
-	dep->endpoint.desc = NULL;
-	dep->comp_desc = NULL;
 	dep->type = 0;
-	dep->flags = 0;
+	dep->flags &= DWC3_EP_END_TRANSFER_PENDING;
+
+	/* Clear out the ep descriptors for non-ep0 */
+	if (dep->number > 1) {
+		dep->endpoint.comp_desc = NULL;
+		dep->endpoint.desc = NULL;
+	}
 
 	return 0;
 }
@@ -695,7 +767,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep_enable(dep, desc, ep->comp_desc, false, false);
+	ret = __dwc3_gadget_ep_enable(dep, false, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -771,10 +843,9 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		unsigned length, unsigned chain, unsigned node)
 {
 	struct dwc3_trb		*trb;
-
-	dwc3_trace(trace_dwc3_gadget, "%s: req %p dma %08llx length %d%s",
-			dep->name, req, (unsigned long long) dma,
-			length, chain ? " chain" : "");
+	struct dwc3		*dwc = dep->dwc;
+	struct usb_gadget	*gadget = &dwc->gadget;
+	enum usb_device_speed	speed = gadget->speed;
 
 	trb = &dep->trb_pool[dep->trb_enqueue];
 
@@ -782,7 +853,6 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		dwc3_gadget_move_started_request(req);
 		req->trb = trb;
 		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
-		req->first_trb_index = dep->trb_enqueue;
 		dep->queued_requests++;
 	}
 
@@ -798,10 +868,16 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		break;
 
 	case USB_ENDPOINT_XFER_ISOC:
-		if (!node)
+		if (!node) {
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS_FIRST;
-		else
+
+			if (speed == USB_SPEED_HIGH) {
+				struct usb_ep *ep = &dep->endpoint;
+				trb->size |= DWC3_TRB_SIZE_PCM1(ep->mult - 1);
+			}
+		} else {
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS;
+		}
 
 		/* always enable Interrupt on Missed ISOC */
 		trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
@@ -816,15 +892,21 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		 * This is only possible with faulty memory because we
 		 * checked it already :)
 		 */
-		BUG();
+		dev_WARN(dwc->dev, "Unknown endpoint type %d\n",
+				usb_endpoint_type(dep->endpoint.desc));
 	}
 
 	/* always enable Continue on Short Packet */
-	trb->ctrl |= DWC3_TRB_CTRL_CSP;
+	if (usb_endpoint_dir_out(dep->endpoint.desc)) {
+		trb->ctrl |= DWC3_TRB_CTRL_CSP;
+
+		if (req->request.short_not_ok)
+			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
+	}
 
 	if ((!req->request.no_interrupt && !chain) ||
 			(dwc3_calc_trbs_left(dep) == 0))
-		trb->ctrl |= DWC3_TRB_CTRL_IOC | DWC3_TRB_CTRL_ISP_IMI;
+		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
@@ -859,6 +941,7 @@ static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 {
 	struct dwc3_trb		*tmp;
+	struct dwc3		*dwc = dep->dwc;
 	u8			trbs_left;
 
 	/*
@@ -870,7 +953,8 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
 		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
-		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
+		if (dev_WARN_ONCE(dwc->dev, tmp->ctrl & DWC3_TRB_CTRL_HWO,
+				  "%s No TRBS left\n", dep->name))
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -941,6 +1025,24 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 	if (!dwc3_calc_trbs_left(dep))
 		return;
 
+	/*
+	 * We can get in a situation where there's a request in the started list
+	 * but there weren't enough TRBs to fully kick it in the first time
+	 * around, so it has been waiting for more TRBs to be freed up.
+	 *
+	 * In that case, we should check if we have a request with pending_sgs
+	 * in the started list and prepare TRBs for that request first,
+	 * otherwise we will prepare TRBs completely out of order and that will
+	 * break things.
+	 */
+	list_for_each_entry(req, &dep->started_list, list) {
+		if (req->num_pending_sgs > 0)
+			dwc3_prepare_one_trb_sg(dep, req);
+
+		if (!dwc3_calc_trbs_left(dep))
+			return;
+	}
+
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
 		if (req->num_pending_sgs > 0)
 			dwc3_prepare_one_trb_sg(dep, req);
@@ -956,7 +1058,6 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_request		*req;
-	struct dwc3			*dwc = dep->dwc;
 	int				starting;
 	int				ret;
 	u32				cmd;
@@ -989,9 +1090,10 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 		 * here and stop, unmap, free and del each of the linked
 		 * requests instead of what we do now.
 		 */
-		usb_gadget_unmap_request(&dwc->gadget, &req->request,
-				req->direction);
-		list_del(&req->list);
+		if (req->trb)
+			memset(req->trb, 0, sizeof(struct dwc3_trb));
+		dep->queued_requests--;
+		dwc3_gadget_giveback(dep, req, ret);
 		return ret;
 	}
 
@@ -1005,14 +1107,21 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 	return 0;
 }
 
+static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
+{
+	u32			reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	return DWC3_DSTS_SOFFN(reg);
+}
+
 static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 		struct dwc3_ep *dep, u32 cur_uf)
 {
 	u32 uf;
 
 	if (list_empty(&dep->pending_list)) {
-		dwc3_trace(trace_dwc3_gadget,
-				"ISOC ep %s run out for requests",
+		dev_info(dwc->dev, "%s: ran out of requests\n",
 				dep->name);
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
 		return;
@@ -1041,16 +1150,15 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	int			ret;
 
 	if (!dep->endpoint.desc) {
-		dwc3_trace(trace_dwc3_gadget,
-				"trying to queue request %p to disabled %s",
-				&req->request, dep->endpoint.name);
+		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
+				dep->name);
 		return -ESHUTDOWN;
 	}
 
 	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
 				&req->request, req->dep->name)) {
-		dwc3_trace(trace_dwc3_gadget, "request %p belongs to '%s'",
-				&req->request, req->dep->name);
+		dev_err(dwc->dev, "%s: request %p belongs to '%s'\n",
+				dep->name, &req->request, req->dep->name);
 		return -EINVAL;
 	}
 
@@ -1063,8 +1171,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 	trace_dwc3_ep_queue(req);
 
-	ret = usb_gadget_map_request(&dwc->gadget, &req->request,
-			dep->direction);
+	ret = usb_gadget_map_request_by_dev(dwc->sysdev, &req->request,
+					    dep->direction);
 	if (ret)
 		return ret;
 
@@ -1082,10 +1190,17 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * errors which will force us issue EndTransfer command.
 	 */
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		if ((dep->flags & DWC3_EP_PENDING_REQUEST) &&
-				list_empty(&dep->started_list)) {
-			dwc3_stop_active_transfer(dwc, dep->number, true);
-			dep->flags = DWC3_EP_ENABLED;
+		if ((dep->flags & DWC3_EP_PENDING_REQUEST)) {
+			if (dep->flags & DWC3_EP_TRANSFER_STARTED) {
+				dwc3_stop_active_transfer(dwc, dep->number, true);
+				dep->flags = DWC3_EP_ENABLED;
+			} else {
+				u32 cur_uf;
+
+				cur_uf = __dwc3_gadget_get_frame(dwc);
+				__dwc3_gadget_start_isoc(dwc, dep, cur_uf);
+				dep->flags &= ~DWC3_EP_PENDING_REQUEST;
+			}
 		}
 		return 0;
 	}
@@ -1094,10 +1209,6 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		return 0;
 
 	ret = __dwc3_gadget_kick_transfer(dep, 0);
-	if (ret && ret != -EBUSY)
-		dwc3_trace(trace_dwc3_gadget,
-				"%s: failed to kick transfers",
-				dep->name);
 	if (ret == -EBUSY)
 		ret = 0;
 
@@ -1116,7 +1227,6 @@ static int __dwc3_gadget_ep_queue_zlp(struct dwc3 *dwc, struct dwc3_ep *dep)
 	struct usb_request		*request;
 	struct usb_ep			*ep = &dep->endpoint;
 
-	dwc3_trace(trace_dwc3_gadget, "queueing ZLP");
 	request = dwc3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
 	if (!request)
 		return -ENOMEM;
@@ -1235,9 +1345,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 
 		if (!protocol && ((dep->direction && transfer_in_flight) ||
 				(!dep->direction && started))) {
-			dwc3_trace(trace_dwc3_gadget,
-					"%s: pending request, cannot halt",
-					dep->name);
 			return -EAGAIN;
 		}
 
@@ -1331,10 +1438,8 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
 static int dwc3_gadget_get_frame(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	u32			reg;
 
-	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
-	return DWC3_DSTS_SOFFN(reg);
+	return __dwc3_gadget_get_frame(dwc);
 }
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
@@ -1357,10 +1462,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	if ((speed == DWC3_DSTS_SUPERSPEED) ||
-	    (speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
-		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed");
+	    (speed == DWC3_DSTS_SUPERSPEED_PLUS))
 		return 0;
-	}
 
 	link_state = DWC3_DSTS_USBLNKST(reg);
 
@@ -1369,9 +1472,6 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
 		break;
 	default:
-		dwc3_trace(trace_dwc3_gadget,
-				"can't wakeup from '%s'",
-				dwc3_gadget_link_string(link_state));
 		return -EINVAL;
 	}
 
@@ -1476,11 +1576,6 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	if (!timeout)
 		return -ETIMEDOUT;
 
-	dwc3_trace(trace_dwc3_gadget, "gadget %s data soft-%s",
-			dwc->gadget_driver
-			? dwc->gadget_driver->function : "no-function",
-			is_on ? "connect" : "disconnect");
-
 	return 0;
 }
 
@@ -1492,6 +1587,21 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	is_on = !!is_on;
 
+	/*
+	 * Per databook, when we want to stop the gadget, if a control transfer
+	 * is still in process, complete it and get the core into setup phase.
+	 */
+	if (!is_on && dwc->ep0state != EP0_SETUP_PHASE) {
+		reinit_completion(&dwc->ep0_in_setup);
+
+		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
+				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
+		if (ret == 0) {
+			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
+			return -ETIMEDOUT;
+		}
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1509,11 +1619,13 @@ static void dwc3_gadget_enable_irq(struct dwc3 *dwc)
 			DWC3_DEVTEN_CMDCMPLTEN |
 			DWC3_DEVTEN_ERRTICERREN |
 			DWC3_DEVTEN_WKUPEVTEN |
-			DWC3_DEVTEN_ULSTCNGEN |
 			DWC3_DEVTEN_CONNECTDONEEN |
 			DWC3_DEVTEN_USBRSTEN |
 			DWC3_DEVTEN_DISCONNEVTEN);
 
+	if (dwc->revision < DWC3_REVISION_250A)
+		reg |= DWC3_DEVTEN_ULSTCNGEN;
+
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
 }
 
@@ -1573,6 +1685,17 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	int			ret = 0;
 	u32			reg;
 
+	/*
+	 * Use IMOD if enabled via dwc->imod_interval. Otherwise, if
+	 * the core supports IMOD, disable it.
+	 */
+	if (dwc->imod_interval) {
+		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
+	} else if (dwc3_has_imod(dwc)) {
+		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), 0);
+	}
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 	reg &= ~(DWC3_DCFG_SPEED_MASK);
 
@@ -1597,7 +1720,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 			reg |= DWC3_DCFG_LOWSPEED;
 			break;
 		case USB_SPEED_FULL:
-			reg |= DWC3_DCFG_FULLSPEED1;
+			reg |= DWC3_DCFG_FULLSPEED;
 			break;
 		case USB_SPEED_HIGH:
 			reg |= DWC3_DCFG_HIGHSPEED;
@@ -1633,16 +1756,14 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
 	dep = dwc->eps[0];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
-			false);
+	ret = __dwc3_gadget_ep_enable(dep, false, false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		goto err0;
 	}
 
 	dep = dwc->eps[1];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
-			false);
+	ret = __dwc3_gadget_ep_enable(dep, false, false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		goto err1;
@@ -1708,9 +1829,6 @@ err0:
 
 static void __dwc3_gadget_stop(struct dwc3 *dwc)
 {
-	if (pm_runtime_suspended(dwc->dev))
-		return;
-
 	dwc3_gadget_disable_irq(dwc);
 	__dwc3_gadget_ep_disable(dwc->eps[0]);
 	__dwc3_gadget_ep_disable(dwc->eps[1]);
@@ -1720,9 +1838,30 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
+	int			epnum;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+
+	if (pm_runtime_suspended(dwc->dev))
+		goto out;
+
 	__dwc3_gadget_stop(dwc);
+
+	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
+		struct dwc3_ep  *dep = dwc->eps[epnum];
+
+		if (!dep)
+			continue;
+
+		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+			continue;
+
+		wait_event_lock_irq(dep->wait_end_transfer,
+				    !(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
+				    dwc->lock);
+	}
+
+out:
 	dwc->gadget_driver	= NULL;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -1765,9 +1904,13 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 				(epnum & 1) ? "in" : "out");
 
 		dep->endpoint.name = dep->name;
-		spin_lock_init(&dep->lock);
 
-		dwc3_trace(trace_dwc3_gadget, "initializing %s", dep->name);
+		if (!(dep->number > 1)) {
+			dep->endpoint.desc = &dwc3_gadget_ep0_desc;
+			dep->endpoint.comp_desc = NULL;
+		}
+
+		spin_lock_init(&dep->lock);
 
 		if (epnum == 0 || epnum == 1) {
 			usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
@@ -1815,15 +1958,13 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_out_eps, 0);
 	if (ret < 0) {
-		dwc3_trace(trace_dwc3_gadget,
-				"failed to allocate OUT endpoints");
+		dev_err(dwc->dev, "failed to initialize OUT endpoints\n");
 		return ret;
 	}
 
 	ret = dwc3_gadget_init_hw_endpoints(dwc, dwc->num_in_eps, 1);
 	if (ret < 0) {
-		dwc3_trace(trace_dwc3_gadget,
-				"failed to allocate IN endpoints");
+		dev_err(dwc->dev, "failed to initialize IN endpoints\n");
 		return ret;
 	}
 
@@ -1892,15 +2033,12 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		return 1;
 
 	count = trb->size & DWC3_TRB_SIZE_MASK;
-	req->request.actual += count;
+	req->remaining += count;
 
 	if (dep->direction) {
 		if (count) {
 			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 			if (trb_status == DWC3_TRBSTS_MISSED_ISOC) {
-				dwc3_trace(trace_dwc3_gadget,
-						"%s: incomplete IN transfer",
-						dep->name);
 				/*
 				 * If missed isoc occurred and there is
 				 * no request queued then issue END
@@ -1946,11 +2084,10 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	struct dwc3_request	*req, *n;
 	struct dwc3_trb		*trb;
 	bool			ioc = false;
-	int			ret;
+	int			ret = 0;
 
 	list_for_each_entry_safe(req, n, &dep->started_list, list) {
 		unsigned length;
-		unsigned actual;
 		int chain;
 
 		length = req->request.length;
@@ -1964,6 +2101,9 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 			for_each_sg(sg, s, pending, i) {
 				trb = &dep->trb_pool[dep->trb_dequeue];
 
+				if (trb->ctrl & DWC3_TRB_CTRL_HWO)
+					break;
+
 				req->sg = sg_next(s);
 				req->num_pending_sgs--;
 
@@ -1978,17 +2118,9 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 					event, status, chain);
 		}
 
-		/*
-		 * We assume here we will always receive the entire data block
-		 * which we should receive. Meaning, if we program RX to
-		 * receive 4K but we receive only 2K, we assume that's all we
-		 * should receive and we simply bounce the request back to the
-		 * gadget driver for further processing.
-		 */
-		actual = length - req->request.actual;
-		req->request.actual = actual;
+		req->request.actual = length - req->remaining;
 
-		if (ret && chain && (actual < length) && req->num_pending_sgs)
+		if ((req->request.actual < length) && req->num_pending_sgs)
 			return __dwc3_gadget_kick_transfer(dep, 0);
 
 		dwc3_gadget_giveback(dep, req, status);
@@ -2096,11 +2228,18 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 {
 	struct dwc3_ep		*dep;
 	u8			epnum = event->endpoint_number;
+	u8			cmd;
 
 	dep = dwc->eps[epnum];
 
-	if (!(dep->flags & DWC3_EP_ENABLED))
-		return;
+	if (!(dep->flags & DWC3_EP_ENABLED)) {
+		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+			return;
+
+		/* Handle only EPCMDCMPLT when EP disabled */
+		if (event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT)
+			return;
+	}
 
 	if (epnum == 0 || epnum == 1) {
 		dwc3_ep0_interrupt(dwc, event);
@@ -2112,9 +2251,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		dep->resource_index = 0;
 
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dwc3_trace(trace_dwc3_gadget,
-					"%s is an Isochronous endpoint",
-					dep->name);
+			dev_err(dwc->dev, "XferComplete for Isochronous endpoint\n");
 			return;
 		}
 
@@ -2127,22 +2264,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 			dwc3_gadget_start_isoc(dwc, dep, event);
 		} else {
-			int active;
 			int ret;
 
-			active = event->status & DEPEVT_STATUS_TRANSFER_ACTIVE;
-
-			dwc3_trace(trace_dwc3_gadget, "%s: reason %s",
-					dep->name, active ? "Transfer Active"
-					: "Transfer Not Active");
-
 			ret = __dwc3_gadget_kick_transfer(dep, 0);
 			if (!ret || ret == -EBUSY)
 				return;
-
-			dwc3_trace(trace_dwc3_gadget,
-					"%s: failed to kick transfers",
-					dep->name);
 		}
 
 		break;
@@ -2152,26 +2278,16 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 					dep->name);
 			return;
 		}
+		break;
+	case DWC3_DEPEVT_EPCMDCMPLT:
+		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
 
-		switch (event->status) {
-		case DEPEVT_STREAMEVT_FOUND:
-			dwc3_trace(trace_dwc3_gadget,
-					"Stream %d found and started",
-					event->parameters);
-
-			break;
-		case DEPEVT_STREAMEVT_NOTFOUND:
-			/* FALLTHROUGH */
-		default:
-			dwc3_trace(trace_dwc3_gadget,
-					"unable to find suitable stream");
+		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
+			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
+			wake_up(&dep->wait_end_transfer);
 		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		dwc3_trace(trace_dwc3_gadget, "%s FIFO Overrun", dep->name);
-		break;
-	case DWC3_DEPEVT_EPCMDCMPLT:
-		dwc3_trace(trace_dwc3_gadget, "Endpoint Command Complete");
 		break;
 	}
 }
@@ -2224,7 +2340,8 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 
 	dep = dwc->eps[epnum];
 
-	if (!dep->resource_index)
+	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
+	    !dep->resource_index)
 		return;
 
 	/*
@@ -2268,25 +2385,9 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	dep->resource_index = 0;
 	dep->flags &= ~DWC3_EP_BUSY;
 
-	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
+	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A) {
+		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 		udelay(100);
-}
-
-static void dwc3_stop_active_transfers(struct dwc3 *dwc)
-{
-	u32 epnum;
-
-	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
-		struct dwc3_ep *dep;
-
-		dep = dwc->eps[epnum];
-		if (!dep)
-			continue;
-
-		if (!(dep->flags & DWC3_EP_ENABLED))
-			continue;
-
-		dwc3_remove_requests(dwc, dep);
 	}
 }
 
@@ -2375,8 +2476,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	dwc->test_mode = false;
-
-	dwc3_stop_active_transfers(dwc);
 	dwc3_clear_stall_all_ep(dwc);
 
 	/* Reset device address to zero */
@@ -2385,32 +2484,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static void dwc3_update_ram_clk_sel(struct dwc3 *dwc, u32 speed)
-{
-	u32 reg;
-	u32 usb30_clock = DWC3_GCTL_CLK_BUS;
-
-	/*
-	 * We change the clock only at SS but I dunno why I would want to do
-	 * this. Maybe it becomes part of the power saving plan.
-	 */
-
-	if ((speed != DWC3_DSTS_SUPERSPEED) &&
-	    (speed != DWC3_DSTS_SUPERSPEED_PLUS))
-		return;
-
-	/*
-	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
-	 * each time on Connect Done.
-	 */
-	if (!usb30_clock)
-		return;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_RAMCLKSEL(usb30_clock);
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-}
-
 static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
@@ -2422,7 +2495,14 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	dwc->speed = speed;
 
-	dwc3_update_ram_clk_sel(dwc, speed);
+	/*
+	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
+	 * each time on Connect Done.
+	 *
+	 * Currently we always use the reset value. If any platform
+	 * wants to set this to a different value, we need to add a
+	 * setting and update GCTL.RAMCLKSEL here.
+	 */
 
 	switch (speed) {
 	case DWC3_DSTS_SUPERSPEED_PLUS:
@@ -2456,8 +2536,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		dwc->gadget.ep0->maxpacket = 64;
 		dwc->gadget.speed = USB_SPEED_HIGH;
 		break;
-	case DWC3_DSTS_FULLSPEED2:
-	case DWC3_DSTS_FULLSPEED1:
+	case DWC3_DSTS_FULLSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
 		dwc->gadget.ep0->maxpacket = 64;
 		dwc->gadget.speed = USB_SPEED_FULL;
@@ -2491,7 +2570,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		 */
 		WARN_ONCE(dwc->revision < DWC3_REVISION_240A
 				&& dwc->has_lpm_erratum,
-				"LPM Erratum not available on dwc3 revisisions < 2.40a\n");
+				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
 			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
@@ -2504,16 +2583,14 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	}
 
 	dep = dwc->eps[0];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, true,
-			false);
+	ret = __dwc3_gadget_ep_enable(dep, true, false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		return;
 	}
 
 	dep = dwc->eps[1];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, true,
-			false);
+	ret = __dwc3_gadget_ep_enable(dep, true, false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		return;
@@ -2570,8 +2647,6 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 			(pwropt != DWC3_GHWPARAMS1_EN_PWROPT_HIB)) {
 		if ((dwc->link_state == DWC3_LINK_STATE_U3) &&
 				(next == DWC3_LINK_STATE_RESUME)) {
-			dwc3_trace(trace_dwc3_gadget,
-					"ignoring transition U3 -> Resume");
 			return;
 		}
 	}
@@ -2705,11 +2780,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEVICE_EVENT_EOPF:
 		/* It changed to be suspend event for version 2.30a and above */
-		if (dwc->revision < DWC3_REVISION_230A) {
-			dwc3_trace(trace_dwc3_gadget, "End of Periodic Frame");
-		} else {
-			dwc3_trace(trace_dwc3_gadget, "U3/L1-L2 Suspend Event");
-
+		if (dwc->revision >= DWC3_REVISION_230A) {
 			/*
 			 * Ignore suspend event until the gadget enters into
 			 * USB_STATE_CONFIGURED state.
@@ -2720,16 +2791,9 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
-		dwc3_trace(trace_dwc3_gadget, "Start of Periodic Frame");
-		break;
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
-		dwc3_trace(trace_dwc3_gadget, "Erratic Error");
-		break;
 	case DWC3_DEVICE_EVENT_CMD_CMPL:
-		dwc3_trace(trace_dwc3_gadget, "Command Complete");
-		break;
 	case DWC3_DEVICE_EVENT_OVERFLOW:
-		dwc3_trace(trace_dwc3_gadget, "Overflow");
 		break;
 	default:
 		dev_WARN(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
@@ -2739,7 +2803,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 static void dwc3_process_event_entry(struct dwc3 *dwc,
 		const union dwc3_event *event)
 {
-	trace_dwc3_event(event->raw);
+	trace_dwc3_event(event->raw, dwc);
 
 	/* Endpoint IRQ, handle it and return early */
 	if (event->type.is_devspec == 0) {
@@ -2772,7 +2836,7 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	while (left > 0) {
 		union dwc3_event event;
 
-		event.raw = *(u32 *) (evt->buf + evt->lpos);
+		event.raw = *(u32 *) (evt->cache + evt->lpos);
 
 		dwc3_process_event_entry(dwc, &event);
 
@@ -2785,10 +2849,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 		 * boundary so I worry about that once we try to handle
 		 * that.
 		 */
-		evt->lpos = (evt->lpos + 4) % DWC3_EVENT_BUFFERS_SIZE;
+		evt->lpos = (evt->lpos + 4) % evt->length;
 		left -= 4;
-
-		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 4);
 	}
 
 	evt->count = 0;
@@ -2800,6 +2862,11 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	reg &= ~DWC3_GEVNTSIZ_INTMASK;
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
 
+	if (dwc->imod_interval) {
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
+		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
+	}
+
 	return ret;
 }
 
@@ -2820,6 +2887,7 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
 	struct dwc3 *dwc = evt->dwc;
+	u32 amount;
 	u32 count;
 	u32 reg;
 
@@ -2843,6 +2911,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	reg |= DWC3_GEVNTSIZ_INTMASK;
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
 
+	amount = min(count, evt->length - evt->lpos);
+	memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
+
+	if (amount < count)
+		memcpy(evt->cache, evt->buf, count - amount);
+
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -2853,6 +2929,39 @@ static irqreturn_t dwc3_interrupt(int irq, void *_evt)
 	return dwc3_check_event_buf(evt);
 }
 
+static int dwc3_gadget_get_irq(struct dwc3 *dwc)
+{
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+	int irq;
+
+	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
+	if (irq > 0)
+		goto out;
+
+	if (irq == -EPROBE_DEFER)
+		goto out;
+
+	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	if (irq > 0)
+		goto out;
+
+	if (irq == -EPROBE_DEFER)
+		goto out;
+
+	irq = platform_get_irq(dwc3_pdev, 0);
+	if (irq > 0)
+		goto out;
+
+	if (irq != -EPROBE_DEFER)
+		dev_err(dwc->dev, "missing peripheral IRQ\n");
+
+	if (!irq)
+		irq = -EINVAL;
+
+out:
+	return irq;
+}
+
 /**
  * dwc3_gadget_init - Initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -2861,35 +2970,18 @@ static irqreturn_t dwc3_interrupt(int irq, void *_evt)
  */
 int dwc3_gadget_init(struct dwc3 *dwc)
 {
-	int ret, irq;
-	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+	int ret;
+	int irq;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
-	if (irq == -EPROBE_DEFER)
-		return irq;
-
-	if (irq <= 0) {
-		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
-		if (irq == -EPROBE_DEFER)
-			return irq;
-
-		if (irq <= 0) {
-			irq = platform_get_irq(dwc3_pdev, 0);
-			if (irq <= 0) {
-				if (irq != -EPROBE_DEFER) {
-					dev_err(dwc->dev,
-						"missing peripheral IRQ\n");
-				}
-				if (!irq)
-					irq = -EINVAL;
-				return irq;
-			}
-		}
+	irq = dwc3_gadget_get_irq(dwc);
+	if (irq < 0) {
+		ret = irq;
+		goto err0;
 	}
 
 	dwc->irq_gadget = irq;
 
-	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+	dwc->ctrl_req = dma_alloc_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
 			&dwc->ctrl_req_addr, GFP_KERNEL);
 	if (!dwc->ctrl_req) {
 		dev_err(dwc->dev, "failed to allocate ctrl request\n");
@@ -2897,8 +2989,9 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
-			&dwc->ep0_trb_addr, GFP_KERNEL);
+	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
+					  sizeof(*dwc->ep0_trb) * 2,
+					  &dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
@@ -2911,7 +3004,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err2;
 	}
 
-	dwc->ep0_bounce = dma_alloc_coherent(dwc->dev,
+	dwc->ep0_bounce = dma_alloc_coherent(dwc->sysdev,
 			DWC3_EP0_BOUNCE_SIZE, &dwc->ep0_bounce_addr,
 			GFP_KERNEL);
 	if (!dwc->ep0_bounce) {
@@ -2926,6 +3019,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	init_completion(&dwc->ep0_in_setup);
+
 	dwc->gadget.ops			= &dwc3_gadget_ops;
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
 	dwc->gadget.sg_supported	= true;
@@ -2949,8 +3044,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	 * composite.c that we are USB 2.0 + LPM ECN.
 	 */
 	if (dwc->revision < DWC3_REVISION_220A)
-		dwc3_trace(trace_dwc3_gadget,
-				"Changing max_speed on rev %08x",
+		dev_info(dwc->dev, "changing max_speed on rev %08x\n",
 				dwc->revision);
 
 	dwc->gadget.max_speed		= dwc->maximum_speed;
@@ -2983,18 +3077,18 @@ err5:
 
 err4:
 	dwc3_gadget_free_endpoints(dwc);
-	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
+	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 err3:
 	kfree(dwc->setup_buf);
 
 err2:
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err1:
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
 			dwc->ctrl_req, dwc->ctrl_req_addr);
 
 err0:
@@ -3009,16 +3103,16 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dwc3_gadget_free_endpoints(dwc);
 
-	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
+	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 	kfree(dwc->setup_buf);
 	kfree(dwc->zlp_buf);
 
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ctrl_req),
 			dwc->ctrl_req, dwc->ctrl_req_addr);
 }
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index e4a1d974a5ae..3129bcf74d7d 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -62,10 +62,7 @@ struct dwc3;
 
 static inline struct dwc3_request *next_request(struct list_head *list)
 {
-	if (list_empty(list))
-		return NULL;
-
-	return list_first_entry(list, struct dwc3_request, list);
+	return list_first_entry_or_null(list, struct dwc3_request, list);
 }
 
 static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index a06f9a8fecc7..c69b06696824 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -40,8 +40,7 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 * documentation, so we revert it back to the proper addresses, the
 	 * same way they are described on SNPS documentation
 	 */
-	dwc3_trace(trace_dwc3_readl, "addr %p value %08x",
-			base - DWC3_GLOBALS_REGS_START + offset, value);
+	trace_dwc3_readl(base - DWC3_GLOBALS_REGS_START, offset, value);
 
 	return value;
 }
@@ -60,8 +59,7 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 	 * documentation, so we revert it back to the proper addresses, the
 	 * same way they are described on SNPS documentation
 	 */
-	dwc3_trace(trace_dwc3_writel, "addr %p value %08x",
-			base - DWC3_GLOBALS_REGS_START + offset, value);
+	trace_dwc3_writel(base - DWC3_GLOBALS_REGS_START, offset, value);
 }
 
 #endif /* __DRIVERS_USB_DWC3_IO_H */
-- 
2.53.0

