Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790E606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TpHiECro;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OlAthUxI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC1BF811A9;
	Wed, 28 Oct 2026 14:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4CuySH9nKDY; Wed, 28 Oct 2026 14:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF94980F3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198798;
	b=U8wNZgeHvg63WWyUKCRhm/gk3xgrJ2qiGHvz4rrxPFAVmsYAlhevvSPtAXS+96lyo00s
	 VKSBrXCGPyHzIyPzgvZIWmYc2PNkut/quN8L/qZI3pOqg67l0WJg0PnC9+2AX9wz580HE
	 Re1zlJq7D29mleOhncwQ6RhtbEyNfPixn5uLMmJ66ZpegBkPS5dcjNHRNaqo9h0rON4ZJ
	 SWEqrHglZ9uVY1LO65GQwwV+YipMgEZJZW8xYvv8ZgTZ08a2xeEnFZYqmDxLueFZuP2fW
	 +ouYTjriKR+uMlmdUG2VkQbFPSS+DUa5J/vxb2M3/vCtuinkFz12uRE2aEodHjQeVew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B3F5Di6NT1oDesr976U7eCPYB4hBeMRvg7UwZc4bBmI=;
	b=fys6VsgIdq0Bkmhwe2BuDt10t2fcv9iGfGn2tvFqF7tyItEk8L1gecGyzGEA8z4w1/bn
	 yUZa7hWmsqE4hV2jaL007OcFJ1Gevzs+OOwSxsYU1f9HfwcAvvcbQZEv/xsY3gULW4Kos
	 w9/unIqkEmrDbrsNiJp/16ulE0Vozx7FceMygXqYeoX323dFZFjx8UAxd19o2FGhub/zf
	 uRcYAo5PCKLaBs/glTXr6BXZhkKx0edrNmTUzDLZ5pYQMBAo3yl6XlIJr6T5cEvp7/RZ9
	 AVllq/pdiEUBJ7wfzIH2cN6+bldfKDfNxwY8XH9qK8Thd4E3JiLoCMkEaXc54MJnZGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198798;
	bh=B3F5Di6NT1oDesr976U7eCPYB4hBeMRvg7UwZc4bBmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TpHiECro3RMHe6YZa4b2wKh7re0/zYaquEtcvGP5PE05hLKy74mUwzqiR8ovXNV0i
	 B9EuKq7oXVNpBOx56HqPpnitvGEd0c4YQ8OnFpxS2hAIpj/Y9ZaBanOI1fal5NlOQm
	 odC7djeoRlEeJGs76T6RdbsXqMKIBam4izjzMGWbjCp3Jk4b437PUi3zFJuRWi3IF4
	 kqnuGW1dj2UxfplGjaudaa0zW4xeLr5T44kSD4RlMVs+3zcMqENURELJK3iFNr4UW3
	 IRbOv0uSNnhwRjtxhZ0+r/958MdvOvHWe9KjvjJ5crwuz+vaCWd2js0Ad8Zz4tdDsn
	 zWWduiezKSGwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF94980F3E;
	Wed, 28 Oct 2026 14:46:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD264235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA36E605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2zQIKvCA-i1 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE839605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196704;
 b=fVNTvY1moS+gSyrdhRxtQtPGNCVupcRCtqteyoWHEeg3ih/7hF8xEBm9LPLUnmZrqfHN
 GQZ0LM+GuWnsb8QDaIqAHPJXYuAAJHly901n9Jl8tsHy5oXexLvXzJZkXg7+GD6iUMhxY
 WRbLdhnuGU1c9pscC6k0QBpdOSN2NRDfySl5oeD9R9ZVWhUDlm7ynxbE6lDEffrRXeWQ9
 PyNwDy2g3GzyFkJbPqPlJYP606u5oRtDW/sQJDBqKUB6Tc6Dpg9PERWLcSSq6NxgL93X8
 g0J/+lnl8/eLmEfptpKCncppLwq77uUgPR2nuI3ByOUxRi2mQmS8l4MhuZTpEfdklXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196704;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=B3F5Di6NT1oDesr976U7eCPYB4hBeMRvg7UwZc4bBmI=;
 b=S2ZVJ+574uusM+G2TjakR+QWlQmeR5FdAEb12Kv98yTCuKWUbg77hMQuHLSE3JqRBCVY
 jxu9zvP+k+OGqR54e4BvufTz/lgFrMaCJbnNHY778LQ5LRyNLZp9a3jxqfa/9VtbYPvmG
 PXBE0LnUZbIsrhUoLlxZmyexaHPwZnwIMYl+RjeSmf0u/1m+3OjhfCpNe+//FVAQzOzSe
 5fvCeY5Un1I/cqamTrSO3CoJ3dPnKSJIcGnILNEiOrPJloYghIMY24VbjHeLCTyDsXetG
 uAV+8WwPJ+Iu/mCNW/l+HBMF/JmyAaDm3TLVmbxRi2YfHdt94Oty12ln2Pb9uiT0/Rg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OlAthUxI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=OlAthUxI
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE839605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:43 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c347be93d54so11356366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196701; x=1793801501;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B3F5Di6NT1oDesr976U7eCPYB4hBeMRvg7UwZc4bBmI=;
 b=OlAthUxIgw+cE3hPEQK8Y+Y2G1vDvr03tcoauOM2HgrCyTgPUHtVqWnbQ+5S1wdpBw
 lzrPJrWjdwexhJ1I6pvzVRKNGtpSodQMhtwsi/ecPH1suVlfWsH6nQAdnSQ+sM6ypfgN
 lIiEBK6IQe4ZOmKZaYX9i7akvPtNZWkdT/+yazMrlREKYJQ3y1E3X5CJpqIeXl+7Mkix
 wZGtjaAfBa+STkN7l6E5W1DWazIIC3qond51W4c7TS/hLnGG81A/+/SFFPLGkauJuSAa
 OJe3Ztqvl/kfBBB8b6UO7F51vLuX3pNtt/CbXgdspBrO1aw+BVjXL4Xa7KG424C1n+pF
 aYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196701; x=1793801501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B3F5Di6NT1oDesr976U7eCPYB4hBeMRvg7UwZc4bBmI=;
 b=yXq72GxVwvq+CgPBTNqEYy+MmQk3FjR84ajKn6tPKZtxPiQ32wvHHb1xOMzNdQEfuV
 svi3fFs4Uo0po2gumWMK8cjCJFYJho+YU2LWtbCT30u7O1JoLSoC10Qt08NdNm7aeGuO
 dN5FvYEWnZ+2mQQiPFBLTq/BTo5JOe5cNFdeVHc9zCYIxlcAOWMmKtmHSZ+zz+uxUWFc
 k/14hfk7ASJCoLMhZ4fWD/mfOQxdYLJp+RVnXiRj7MNek9ax9gKIjEVLzCOYF6R39BhK
 scRmzv/ENq09SXVzZwc6ebYWZ7MgmBRhv15px8kqQ9Om2E84lsRqRoBmn+9ddvtimuEu
 mcrA==
X-Gm-Message-State: AFq9FYJRJD7jy3q8mhb+J1oYG2nkTOOlVq86vmIY3aMgLKmp8scsZmT9
 bu83Or/L4uWPbiCvcRdG2qOwe1mYAE4xqEvvffs0DRCG50tXhglcmYOwEHkLjeSUuipJU51R05Q
 gyX9u
X-Gm-Gg: AYBFou39VCgS853POwz4XgT15r9eaqTKstLE2INvT7g4v8pBlGXzX9VRaVnaG+zNCis
 tzzkpfo2vWMa+hG3nCNZ+un5CUS5KMZkBYNJcd6yFkyMX8eelV6JUnBUV/1bnf5X9RUyg5LbLL9
 BOpFxmSgLIyk7WFBahXGQCPfHhOvPkB3F8nMjOSeckEKn8dHjnnaPFUqcoSwrade8y7lHrHRiE+
 UXkPUe//LLGu/shm3YCkCkqaRG9nD5mCXJIo6pcC+rzLNeKejZLO7okbF9J45z80bwaBQ/KAhYm
 UYJapUkPT6qg9fJs1RffyDLOqtb5hOXzWllhxPAaet2BdFeebBEc8fNF10wapssK97yVlMuE+iz
 YOXdVj2SqUsjjT6SRbQo7KleEH6B1DZH9eH69DAJ/8eFCmZn8oxb4jpy9aMo7Y/ZPuTtAW0BFvH
 Y0f4hyaZjV1OS5RCDZBcVFL/h9zdLez2cMG925oBduk4tQM86HpeVBZ4JCw9RIX5VmQOFO5EHYd
 17BFTiG6Xnr67mUzJa0e9Yqt3U2fj+kq/0HbumW14FqG1PowGfQrkMr9+g+di8TzmGzPfU5F38W
 BHHtlW99X8vxUAFa61mbANH94mEWEhgj44fNWNXs24Gm5aLhFY2TCSCRptKhnhUN0VIl2U82sek
 AsrhMRbgKNOdDL2WNsRNkskh4eyRq30w=
X-Received: by 2002:a17:906:8f14:b0:c46:ae89:cd3c with SMTP id
 a640c23a62f3a-c49bddd28ddmr278306066b.1.1793196700997; 
 Wed, 28 Oct 2026 07:11:40 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64a02csm611738166b.44.2026.10.28.07.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:40 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 22/63] usb: dwc3: import from kernel v4.18
Date: Wed, 28 Oct 2026 15:08:48 +0100
Message-ID: <20261028140930.3025368-23-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.17 to v4.18.

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

List of commits: git log --oneline v4.17..v4.18
Commits imported:
9566a7c72f4f usb: dwc3: gadget: remove redundant variable maxpacket
615277779f41 usb: dwc3: Only call clk_bulk_get() on devicetree instantiated devices
05645366f389 usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
691025107eb7 usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static
31a2f5a7e136 usb: dwc3: gadget: init req->{direction,epnum} from alloc_request()
d7ca7e1896b2 usb: dwc3: gadget: initialize transfer index from send_gadget_ep_cmd()
4439661d64f5 usb: dwc3: gadget: assign resource_index inside get_transfer_index()
f62afb4929a8 usb: dwc3: gadget: always start isochronous aligned to dep->interval
d513320f1fd0 usb: dwc3: gadget: don't issue End Transfer if we have started reqs
e1d542f712e1 usb: dwc3: debug: decode uFrame from event too
42626919efab usb: dwc3: gadget: move dwc3_calc_trbs_left() in place of prototype
20d1d43fa09a usb: dwc3: gadget: move set_xfer_resource() in place of prototype
b07c2db83f92 usb: dwc3: gadget: remove a few more dwc arguments
a2d23f08038e usb: dwc3: gadget: combine modify & restore into single argument
8f1c99cd24b0 usb: dwc3: gadget: refactor dwc3_gadget_init_endpoints()
f38e35dd84e2 usb: dwc3: gadget: split dwc3_gadget_ep_cleanup_completed_requests()
6d9d22dac114 usb: dwc3: gadget: get rid of the length variable
fee73e6144d8 usb: dwc3: gadget: reduce scope of ret variable
6afbdb57732b usb: dwc3: gadget: one declaration per line
e0c42ce590fe usb: dwc3: gadget: simplify IOC handling
d80fe1b6e34d usb: dwc3: gadget: simplify short packet event
b27972b508d1 usb: dwc3: trace: print out event status too
8b3b7b66c0e6 usb: dwc3: gadget: simplify unaligned and zlp handling
cf35fc336e66 usb: dwc3: gadget: remove unnecessary 'chain' variable
021595963a3c usb: dwc3: gadget: remove PENDING handling from cleanup_completed
d36929538f8b usb: dwc3: gadget: split scatterlist and linear handlers
d5044a04b529 usb: dwc3: gadget: simplify isoc case on cleanup_completed_requests
fe990cea8ed5 usb: dwc3: gadget: simplify queueing of isoc transfers
4d588a145b3e usb: dwc3: gadget: remove duplicated missed isoc handling
6d8a019614f3 usb: dwc3: gadget: check for Missed Isoc from event status
58f0218a271d usb: dwc3: gadget: remove unnecessary 'ioc' variable
12a3a4ada816 usb: dwc3: gadget: make cleanup_completed_requests() return nothing
5f2e7975f0df usb: dwc3: gadget: remove DWC3_EP_BUSY flag
1912cbc60f44 usb: dwc3: gadget: start removing BUSY flag
ee3638b897b9 usb: dwc3: gadget: update dep->frame_number from XferInprogress too
5828cada9908 usb: dwc3: gadget: always use frame number from XferNotReady
8f608e8ab628 usb: dwc3: gadget: remove unnecessary 'dwc' parameter
320338651d33 usb: dwc3: gadget: move handler closer to calling site
ed27442e5093 usb: dwc3: gadget: rename dwc3_gadget_start_isoc()
a24a6ab1493a usb: dwc3: gadget: remove some pointless checks
0bd0f6d201eb usb: dwc3: gadget: remove allocated/queued request tracking
66f5dd5a0379 usb: dwc3: gadget: rename done_trbs and done_reqs
a861282f5037 usb: dwc3: gadget: don't kick transfer all the time
fbea935accf4 usb: dwc3: gadget: rename dwc3_endpoint_transfer_complete()
742a4fff5f29 usb: dwc3: gadget: XferComplete only for EP0
38408464aa76 usb: dwc3: gadget: XferNotReady is Isoc-only
52fcc0bead0f usb: dwc3: gadget: pre-issue Start Transfer for Interrupt EPs too
c96e6725db9d usb: dwc3: gadget: Correct the logic for queuing sgs
a31e63b608ff usb: dwc3: gadget: Correct handling of scattergather lists
fe8abf332b8f usb: dwc3: support clocks and resets for DWC3 core
44feb8e6ea2d usb: dwc3: use local copy of resource to fix-up register offset
bcb128777af5 usb: dwc3: core: Suspend PHYs on runtime suspend in host mode

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 157 ++++++--
 drivers/usb/dwc3/core.h   |  25 +-
 drivers/usb/dwc3/debug.h  |  26 +-
 drivers/usb/dwc3/ep0.c    |   9 +-
 drivers/usb/dwc3/gadget.c | 773 ++++++++++++++++++--------------------
 drivers/usb/dwc3/gadget.h |   5 +-
 6 files changed, 531 insertions(+), 464 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a15648d25e30..103807587dc6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -8,6 +8,7 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
+#include <linux/clk.h>
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -24,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -266,6 +268,12 @@ done:
 	return 0;
 }
 
+static const struct clk_bulk_data dwc3_core_clks[] = {
+	{ .id = "ref" },
+	{ .id = "bus_early" },
+	{ .id = "suspend" },
+};
+
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -667,6 +675,9 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	reset_control_assert(dwc->reset);
 }
 
 static bool dwc3_core_is_valid(struct dwc3 *dwc)
@@ -1245,7 +1256,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
-	struct resource		*res;
+	struct resource		*res, dwc_res;
 	struct dwc3		*dwc;
 
 	int			ret;
@@ -1256,6 +1267,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
+	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
+				 GFP_KERNEL);
+	if (!dwc->clks)
+		return -ENOMEM;
+
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1270,23 +1286,52 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->xhci_resources[0].flags = res->flags;
 	dwc->xhci_resources[0].name = res->name;
 
-	res->start += DWC3_GLOBALS_REGS_START;
-
 	/*
 	 * Request memory region but exclude xHCI regs,
 	 * since it will be requested by the xhci-plat driver.
 	 */
-	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		goto err0;
-	}
+	dwc_res = *res;
+	dwc_res.start += DWC3_GLOBALS_REGS_START;
+
+	regs = devm_ioremap_resource(dev, &dwc_res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	dwc->regs	= regs;
-	dwc->regs_size	= resource_size(res);
+	dwc->regs_size	= resource_size(&dwc_res);
 
 	dwc3_get_properties(dwc);
 
+	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(dwc->reset))
+		return PTR_ERR(dwc->reset);
+
+	if (dev->of_node) {
+		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
+
+		ret = clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		/*
+		 * Clocks are optional, but new DT platforms should support all
+		 * clocks as required by the DT-binding.
+		 */
+		if (ret)
+			dwc->num_clks = 0;
+	}
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		goto put_clks;
+
+	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto assert_reset;
+
+	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto unprepare_clks;
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1350,13 +1395,13 @@ err1:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-err0:
-	/*
-	 * restore res->start back to its original value so that, in case the
-	 * probe is deferred, we don't end up getting error in request the
-	 * memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+unprepare_clks:
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+assert_reset:
+	reset_control_assert(dwc->reset);
+put_clks:
+	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return ret;
 }
@@ -1364,15 +1409,8 @@ err0:
 static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	pm_runtime_get_sync(&pdev->dev);
-	/*
-	 * restore res->start back to its original value so that, in case the
-	 * probe is deferred, we don't end up getting error in request the
-	 * memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
 
 	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
@@ -1386,14 +1424,48 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
+	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
+static int dwc3_core_init_for_resume(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto assert_reset;
+
+	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto unprepare_clks;
+
+	ret = dwc3_core_init(dwc);
+	if (ret)
+		goto disable_clks;
+
+	return 0;
+
+disable_clks:
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+unprepare_clks:
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+assert_reset:
+	reset_control_assert(dwc->reset);
+
+	return ret;
+}
+
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
+	u32 reg;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -1403,9 +1475,25 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		/* do nothing during host runtime_suspend */
-		if (!PMSG_IS_AUTO(msg))
+		if (!PMSG_IS_AUTO(msg)) {
 			dwc3_core_exit(dwc);
+			break;
+		}
+
+		/* Let controller to suspend HSPHY before PHY driver suspends */
+		if (dwc->dis_u2_susphy_quirk ||
+		    dwc->dis_enblslpm_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
+				DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+			/* Give some time for USB2 PHY to suspend */
+			usleep_range(5000, 6000);
+		}
+
+		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
+		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -1433,10 +1521,11 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	int		ret;
+	u32		reg;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
@@ -1446,13 +1535,25 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		/* nothing to do on host runtime_resume */
 		if (!PMSG_IS_AUTO(msg)) {
-			ret = dwc3_core_init(dwc);
+			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
 			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			break;
 		}
+		/* Restore GUSB2PHYCFG bits that were modified in suspend */
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		if (dwc->dis_u2_susphy_quirk)
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+		if (dwc->dis_enblslpm_quirk)
+			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
+		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* nothing to do on runtime_resume */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4f3b43809917..285ce0ef3b91 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -639,8 +639,6 @@ struct dwc3_event_buffer {
  * @resource_index: Resource transfer index
  * @frame_number: set to the frame number we want this transfer to start (ISOC)
  * @interval: the interval on which the ISOC transfer is started
- * @allocated_requests: number of requests allocated
- * @queued_requests: number of requests queued for transfer
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
@@ -664,11 +662,9 @@ struct dwc3_ep {
 #define DWC3_EP_ENABLED		BIT(0)
 #define DWC3_EP_STALL		BIT(1)
 #define DWC3_EP_WEDGE		BIT(2)
-#define DWC3_EP_BUSY		BIT(4)
+#define DWC3_EP_TRANSFER_STARTED BIT(3)
 #define DWC3_EP_PENDING_REQUEST	BIT(5)
-#define DWC3_EP_MISSED_ISOC	BIT(6)
 #define DWC3_EP_END_TRANSFER_PENDING	BIT(7)
-#define DWC3_EP_TRANSFER_STARTED BIT(8)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		BIT(31)
@@ -688,8 +684,6 @@ struct dwc3_ep {
 	u8			number;
 	u8			type;
 	u8			resource_index;
-	u32			allocated_requests;
-	u32			queued_requests;
 	u32			frame_number;
 	u32			interval;
 
@@ -832,7 +826,9 @@ struct dwc3_hwparams {
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
  * @sg: pointer to first incomplete sg
+ * @start_sg: pointer to the sg which should be queued next
  * @num_pending_sgs: counter to pending sgs
+ * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
@@ -848,8 +844,10 @@ struct dwc3_request {
 	struct list_head	list;
 	struct dwc3_ep		*dep;
 	struct scatterlist	*sg;
+	struct scatterlist	*start_sg;
 
 	unsigned		num_pending_sgs;
+	unsigned int		num_queued_sgs;
 	unsigned		remaining;
 	u8			epnum;
 	struct dwc3_trb		*trb;
@@ -891,6 +889,9 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
+ * @clks: array of clocks
+ * @num_clks: number of clocks
+ * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
@@ -1013,6 +1014,11 @@ struct dwc3 {
 	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	struct clk_bulk_data	*clks;
+	int			num_clks;
+
+	struct reset_control	*reset;
+
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
@@ -1197,11 +1203,12 @@ struct dwc3_event_depevt {
 /* Within XferNotReady */
 #define DEPEVT_STATUS_TRANSFER_ACTIVE	BIT(3)
 
-/* Within XferComplete */
+/* Within XferComplete or XferInProgress */
 #define DEPEVT_STATUS_BUSERR	BIT(0)
 #define DEPEVT_STATUS_SHORT	BIT(1)
 #define DEPEVT_STATUS_IOC	BIT(2)
-#define DEPEVT_STATUS_LST	BIT(3)
+#define DEPEVT_STATUS_LST	BIT(3) /* XferComplete */
+#define DEPEVT_STATUS_MISSED_ISOC BIT(3) /* XferInProgress */
 
 /* Stream event only */
 #define DEPEVT_STREAMEVT_FOUND		1
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index bfb90c52d8fc..c66d216dcc30 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -475,21 +475,37 @@ dwc3_ep_event_string(char *str, const struct dwc3_event_depevt *event,
 	if (ret < 0)
 		return "UNKNOWN";
 
+	status = event->status;
+
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
-		strcat(str, "Transfer Complete");
+		len = strlen(str);
+		sprintf(str + len, "Transfer Complete (%c%c%c)",
+				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
+				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
+				status & DEPEVT_STATUS_LST ? 'L' : 'l');
+
 		len = strlen(str);
 
 		if (epnum <= 1)
 			sprintf(str + len, " [%s]", dwc3_ep0_state_string(ep0state));
 		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
-		strcat(str, "Transfer In-Progress");
+		len = strlen(str);
+
+		sprintf(str + len, "Transfer In Progress [%d] (%c%c%c)",
+				event->parameters,
+				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
+				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
+				status & DEPEVT_STATUS_LST ? 'M' : 'm');
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		strcat(str, "Transfer Not Ready");
-		status = event->status & DEPEVT_STATUS_TRANSFER_ACTIVE;
-		strcat(str, status ? " (Active)" : " (Not Active)");
+		len = strlen(str);
+
+		sprintf(str + len, "Transfer Not Ready [%d]%s",
+				event->parameters,
+				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
+				" (Active)" : " (Not Active)");
 
 		/* Control Endpoints */
 		if (epnum <= 1) {
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5a991bca8ed7..8efde178eef4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -66,7 +66,7 @@ static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
 	struct dwc3			*dwc;
 	int				ret;
 
-	if (dep->flags & DWC3_EP_BUSY)
+	if (dep->flags & DWC3_EP_TRANSFER_STARTED)
 		return 0;
 
 	dwc = dep->dwc;
@@ -79,8 +79,6 @@ static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
 	if (ret < 0)
 		return ret;
 
-	dep->flags |= DWC3_EP_BUSY;
-	dep->resource_index = dwc3_gadget_ep_get_transfer_index(dep);
 	dwc->ep0_next_event = DWC3_EP0_COMPLETE;
 
 	return 0;
@@ -913,7 +911,7 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
 {
 	struct dwc3_ep		*dep = dwc->eps[event->endpoint_number];
 
-	dep->flags &= ~DWC3_EP_BUSY;
+	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	dep->resource_index = 0;
 	dwc->setup_packet_pending = false;
 
@@ -975,15 +973,12 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
 		   req->request.length && req->request.zero) {
-		u32	maxpacket;
 
 		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
 				&req->request, dep->number);
 		if (ret)
 			return;
 
-		maxpacket = dep->endpoint.maxpacket;
-
 		/* prepare normal TRB */
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 					 req->request.length,
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0dedf8a799f4..69bf137aab37 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -27,6 +27,9 @@
 #include "gadget.h"
 #include "io.h"
 
+#define DWC3_ALIGN_FRAME(d)	(((d)->frame_number + (d)->interval) \
+					& ~((d)->interval - 1))
+
 /**
  * dwc3_gadget_set_test_mode - enables usb2 test modes
  * @dwc: pointer to our context structure
@@ -375,6 +378,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 		switch (DWC3_DEPCMD_CMD(cmd)) {
 		case DWC3_DEPCMD_STARTTRANSFER:
 			dep->flags |= DWC3_EP_TRANSFER_STARTED;
+			dwc3_gadget_ep_get_transfer_index(dep);
 			break;
 		case DWC3_DEPCMD_ENDTRANSFER:
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
@@ -455,7 +459,17 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 	dep->trb_pool_dma = 0;
 }
 
-static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep);
+static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+
+	memset(&params, 0x00, sizeof(params));
+
+	params.param0 = DWC3_DEPXFERCFG_NUM_XFER_RES(1);
+
+	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETTRANSFRESOURCE,
+			&params);
+}
 
 /**
  * dwc3_gadget_start_config - configure ep resources
@@ -491,9 +505,10 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep);
  * triggered only when called for EP0-out, which always happens first, and which
  * should only happen in one of the above conditions.
  */
-static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
+static int dwc3_gadget_start_config(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3		*dwc;
 	u32			cmd;
 	int			i;
 	int			ret;
@@ -503,6 +518,7 @@ static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 
 	memset(&params, 0x00, sizeof(params));
 	cmd = DWC3_DEPCMD_DEPSTARTCFG;
+	dwc = dep->dwc;
 
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	if (ret)
@@ -514,7 +530,7 @@ static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 		if (!dep)
 			continue;
 
-		ret = dwc3_gadget_set_xfer_resource(dwc, dep);
+		ret = dwc3_gadget_set_xfer_resource(dep);
 		if (ret)
 			return ret;
 	}
@@ -522,16 +538,12 @@ static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 	return 0;
 }
 
-static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
-		bool modify, bool restore)
+static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 {
 	const struct usb_ss_ep_comp_descriptor *comp_desc;
 	const struct usb_endpoint_descriptor *desc;
 	struct dwc3_gadget_ep_cmd_params params;
-
-	if (dev_WARN_ONCE(dwc->dev, modify && restore,
-					"Can't modify and restore\n"))
-		return -EINVAL;
+	struct dwc3 *dwc = dep->dwc;
 
 	comp_desc = dep->endpoint.comp_desc;
 	desc = dep->endpoint.desc;
@@ -547,14 +559,9 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst - 1);
 	}
 
-	if (modify) {
-		params.param0 |= DWC3_DEPCFG_ACTION_MODIFY;
-	} else if (restore) {
-		params.param0 |= DWC3_DEPCFG_ACTION_RESTORE;
+	params.param0 |= action;
+	if (action == DWC3_DEPCFG_ACTION_RESTORE)
 		params.param2 |= dep->saved_state;
-	} else {
-		params.param0 |= DWC3_DEPCFG_ACTION_INIT;
-	}
 
 	if (usb_endpoint_xfer_control(desc))
 		params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN;
@@ -594,29 +601,15 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
-static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep)
-{
-	struct dwc3_gadget_ep_cmd_params params;
-
-	memset(&params, 0x00, sizeof(params));
-
-	params.param0 = DWC3_DEPXFERCFG_NUM_XFER_RES(1);
-
-	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETTRANSFRESOURCE,
-			&params);
-}
-
 /**
  * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
- * @modify: if true, modify existing endpoint configuration
- * @restore: if true, restore endpoint configuration from scratch buffer
+ * @action: one of INIT, MODIFY or RESTORE
  *
  * Caller should take care of locking. Execute all necessary commands to
  * initialize a HW endpoint so it can be used by a gadget driver.
  */
-static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
-		bool modify, bool restore)
+static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
@@ -625,12 +618,12 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 	int			ret;
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		ret = dwc3_gadget_start_config(dwc, dep);
+		ret = dwc3_gadget_start_config(dep);
 		if (ret)
 			return ret;
 	}
 
-	ret = dwc3_gadget_set_ep_config(dwc, dep, modify, restore);
+	ret = dwc3_gadget_set_ep_config(dep, action);
 	if (ret)
 		return ret;
 
@@ -671,7 +664,8 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc)) {
+	if (usb_endpoint_xfer_bulk(desc) ||
+			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
 		dma_addr_t trb_dma;
@@ -689,26 +683,20 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 		if (ret < 0)
 			return ret;
-
-		dep->flags |= DWC3_EP_BUSY;
-
-		dep->resource_index = dwc3_gadget_ep_get_transfer_index(dep);
-		WARN_ON_ONCE(!dep->resource_index);
 	}
 
-
 out:
 	trace_dwc3_gadget_ep_enable(dep);
 
 	return 0;
 }
 
-static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force);
+static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force);
 static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dwc, dep->number, true);
+	dwc3_stop_active_transfer(dep, true);
 
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
@@ -806,7 +794,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep_enable(dep, false, false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -840,7 +828,7 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 }
 
 static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
-	gfp_t gfp_flags)
+		gfp_t gfp_flags)
 {
 	struct dwc3_request		*req;
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
@@ -849,11 +837,10 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	if (!req)
 		return NULL;
 
+	req->direction	= dep->direction;
 	req->epnum	= dep->number;
 	req->dep	= dep;
 
-	dep->allocated_requests++;
-
 	trace_dwc3_alloc_request(req);
 
 	return &req->request;
@@ -863,14 +850,58 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 		struct usb_request *request)
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
-	struct dwc3_ep			*dep = to_dwc3_ep(ep);
 
-	dep->allocated_requests--;
 	trace_dwc3_free_request(req);
 	kfree(req);
 }
 
-static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep);
+/**
+ * dwc3_ep_prev_trb - returns the previous TRB in the ring
+ * @dep: The endpoint with the TRB ring
+ * @index: The index of the current TRB in the ring
+ *
+ * Returns the TRB prior to the one pointed to by the index. If the
+ * index is 0, we will wrap backwards, skip the link TRB, and return
+ * the one just before that.
+ */
+static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
+{
+	u8 tmp = index;
+
+	if (!tmp)
+		tmp = DWC3_TRB_NUM - 1;
+
+	return &dep->trb_pool[tmp - 1];
+}
+
+static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
+{
+	struct dwc3_trb		*tmp;
+	u8			trbs_left;
+
+	/*
+	 * If enqueue & dequeue are equal than it is either full or empty.
+	 *
+	 * One way to know for sure is if the TRB right before us has HWO bit
+	 * set or not. If it has, then we're definitely full and can't fit any
+	 * more transfers in our ring.
+	 */
+	if (dep->trb_enqueue == dep->trb_dequeue) {
+		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
+		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
+			return 0;
+
+		return DWC3_TRB_NUM - 1;
+	}
+
+	trbs_left = dep->trb_dequeue - dep->trb_enqueue;
+	trbs_left &= (DWC3_TRB_NUM - 1);
+
+	if (dep->trb_dequeue < dep->trb_enqueue)
+		trbs_left--;
+
+	return trbs_left;
+}
 
 static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 		dma_addr_t dma, unsigned length, unsigned chain, unsigned node,
@@ -985,11 +1016,19 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, unsigned chain, unsigned node)
 {
 	struct dwc3_trb		*trb;
-	unsigned		length = req->request.length;
+	unsigned int		length;
+	dma_addr_t		dma;
 	unsigned		stream_id = req->request.stream_id;
 	unsigned		short_not_ok = req->request.short_not_ok;
 	unsigned		no_interrupt = req->request.no_interrupt;
-	dma_addr_t		dma = req->request.dma;
+
+	if (req->request.num_sgs > 0) {
+		length = sg_dma_len(req->start_sg);
+		dma = sg_dma_address(req->start_sg);
+	} else {
+		length = req->request.length;
+		dma = req->request.dma;
+	}
 
 	trb = &dep->trb_pool[dep->trb_enqueue];
 
@@ -997,69 +1036,23 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		dwc3_gadget_move_started_request(req);
 		req->trb = trb;
 		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
-		dep->queued_requests++;
 	}
 
 	__dwc3_prepare_one_trb(dep, trb, dma, length, chain, node,
 			stream_id, short_not_ok, no_interrupt);
 }
 
-/**
- * dwc3_ep_prev_trb - returns the previous TRB in the ring
- * @dep: The endpoint with the TRB ring
- * @index: The index of the current TRB in the ring
- *
- * Returns the TRB prior to the one pointed to by the index. If the
- * index is 0, we will wrap backwards, skip the link TRB, and return
- * the one just before that.
- */
-static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
-{
-	u8 tmp = index;
-
-	if (!tmp)
-		tmp = DWC3_TRB_NUM - 1;
-
-	return &dep->trb_pool[tmp - 1];
-}
-
-static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
-{
-	struct dwc3_trb		*tmp;
-	u8			trbs_left;
-
-	/*
-	 * If enqueue & dequeue are equal than it is either full or empty.
-	 *
-	 * One way to know for sure is if the TRB right before us has HWO bit
-	 * set or not. If it has, then we're definitely full and can't fit any
-	 * more transfers in our ring.
-	 */
-	if (dep->trb_enqueue == dep->trb_dequeue) {
-		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
-		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
-			return 0;
-
-		return DWC3_TRB_NUM - 1;
-	}
-
-	trbs_left = dep->trb_dequeue - dep->trb_enqueue;
-	trbs_left &= (DWC3_TRB_NUM - 1);
-
-	if (dep->trb_dequeue < dep->trb_enqueue)
-		trbs_left--;
-
-	return trbs_left;
-}
-
 static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
-	struct scatterlist *sg = req->sg;
+	struct scatterlist *sg = req->start_sg;
 	struct scatterlist *s;
 	int		i;
 
-	for_each_sg(sg, s, req->num_pending_sgs, i) {
+	unsigned int remaining = req->request.num_mapped_sgs
+		- req->num_queued_sgs;
+
+	for_each_sg(sg, s, remaining, i) {
 		unsigned int length = req->request.length;
 		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 		unsigned int rem = length % maxp;
@@ -1088,6 +1081,18 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			dwc3_prepare_one_trb(dep, req, chain, i);
 		}
 
+		/*
+		 * There can be a situation where all sgs in sglist are not
+		 * queued because of insufficient trb number. To handle this
+		 * case, update start_sg to next sg to be queued, so that
+		 * we have free trbs we can continue queuing from where we
+		 * previously stopped
+		 */
+		if (chain)
+			req->start_sg = sg_next(s);
+
+		req->num_queued_sgs++;
+
 		if (!dwc3_calc_trbs_left(dep))
 			break;
 	}
@@ -1178,6 +1183,8 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 			return;
 
 		req->sg			= req->request.sg;
+		req->start_sg		= req->sg;
+		req->num_queued_sgs	= 0;
 		req->num_pending_sgs	= req->request.num_mapped_sgs;
 
 		if (req->num_pending_sgs > 0)
@@ -1201,7 +1208,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 	if (!dwc3_calc_trbs_left(dep))
 		return 0;
 
-	starting = !(dep->flags & DWC3_EP_BUSY);
+	starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
 
 	dwc3_prepare_trbs(dep);
 	req = next_request(&dep->started_list);
@@ -1233,18 +1240,10 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		 */
 		if (req->trb)
 			memset(req->trb, 0, sizeof(struct dwc3_trb));
-		dep->queued_requests--;
 		dwc3_gadget_del_and_unmap_request(dep, req, ret);
 		return ret;
 	}
 
-	dep->flags |= DWC3_EP_BUSY;
-
-	if (starting) {
-		dep->resource_index = dwc3_gadget_ep_get_transfer_index(dep);
-		WARN_ON_ONCE(!dep->resource_index);
-	}
-
 	return 0;
 }
 
@@ -1256,35 +1255,19 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 	return DWC3_DSTS_SOFFN(reg);
 }
 
-static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
-		struct dwc3_ep *dep, u32 cur_uf)
+static void __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 {
 	if (list_empty(&dep->pending_list)) {
-		dev_info(dwc->dev, "%s: ran out of requests\n",
+		dev_info(dep->dwc->dev, "%s: ran out of requests\n",
 				dep->name);
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
 		return;
 	}
 
-	/*
-	 * Schedule the first trb for one interval in the future or at
-	 * least 4 microframes.
-	 */
-	dep->frame_number = cur_uf + max_t(u32, 4, dep->interval);
+	dep->frame_number = DWC3_ALIGN_FRAME(dep);
 	__dwc3_gadget_kick_transfer(dep);
 }
 
-static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
-		struct dwc3_ep *dep, const struct dwc3_event_depevt *event)
-{
-	u32 cur_uf, mask;
-
-	mask = ~(dep->interval - 1);
-	cur_uf = event->parameters & mask;
-
-	__dwc3_gadget_start_isoc(dwc, dep, cur_uf);
-}
-
 static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
@@ -1303,8 +1286,6 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
-	req->direction		= dep->direction;
-	req->epnum		= dep->number;
 
 	trace_dwc3_ep_queue(req);
 
@@ -1319,28 +1300,18 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * errors which will force us issue EndTransfer command.
 	 */
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		if ((dep->flags & DWC3_EP_PENDING_REQUEST)) {
-			if (dep->flags & DWC3_EP_TRANSFER_STARTED) {
-				dwc3_stop_active_transfer(dwc, dep->number, true);
-				dep->flags = DWC3_EP_ENABLED;
-			} else {
-				u32 cur_uf;
+		if (!(dep->flags & DWC3_EP_PENDING_REQUEST) &&
+				!(dep->flags & DWC3_EP_TRANSFER_STARTED))
+			return 0;
 
-				cur_uf = __dwc3_gadget_get_frame(dwc);
-				__dwc3_gadget_start_isoc(dwc, dep, cur_uf);
-				dep->flags &= ~DWC3_EP_PENDING_REQUEST;
+		if ((dep->flags & DWC3_EP_PENDING_REQUEST)) {
+			if (!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
+				__dwc3_gadget_start_isoc(dep);
+				return 0;
 			}
-			return 0;
 		}
-
-		if ((dep->flags & DWC3_EP_BUSY) &&
-		    !(dep->flags & DWC3_EP_MISSED_ISOC))
-			goto out;
-
-		return 0;
 	}
 
-out:
 	return __dwc3_gadget_kick_transfer(dep);
 }
 
@@ -1390,7 +1361,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		}
 		if (r == req) {
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dwc, dep->number, true);
+			dwc3_stop_active_transfer(dep, true);
 
 			/*
 			 * If request was already started, this means we had to
@@ -1463,7 +1434,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 out1:
 	/* giveback the request */
-	dep->queued_requests--;
+
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
 out0:
@@ -1878,14 +1849,14 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
 	dep = dwc->eps[0];
-	ret = __dwc3_gadget_ep_enable(dep, false, false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		goto err0;
 	}
 
 	dep = dwc->eps[1];
-	ret = __dwc3_gadget_ep_enable(dep, false, false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		goto err1;
@@ -2082,113 +2053,142 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 
 /* -------------------------------------------------------------------------- */
 
-static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
+static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
 {
-	struct dwc3_ep			*dep;
-	u8				epnum;
+	struct dwc3 *dwc = dep->dwc;
 
-	INIT_LIST_HEAD(&dwc->gadget.ep_list);
+	usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
+	dep->endpoint.maxburst = 1;
+	dep->endpoint.ops = &dwc3_gadget_ep0_ops;
+	if (!dep->direction)
+		dwc->gadget.ep0 = &dep->endpoint;
 
-	for (epnum = 0; epnum < total; epnum++) {
-		bool			direction = epnum & 1;
-		u8			num = epnum >> 1;
+	dep->endpoint.caps.type_control = true;
 
-		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
-		if (!dep)
-			return -ENOMEM;
+	return 0;
+}
 
-		dep->dwc = dwc;
-		dep->number = epnum;
-		dep->direction = direction;
-		dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
-		dwc->eps[epnum] = dep;
+static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	int mdwidth;
+	int kbytes;
+	int size;
 
-		snprintf(dep->name, sizeof(dep->name), "ep%u%s", num,
-				direction ? "in" : "out");
+	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
+	/* MDWIDTH is represented in bits, we need it in bytes */
+	mdwidth /= 8;
 
-		dep->endpoint.name = dep->name;
+	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1));
+	if (dwc3_is_usb31(dwc))
+		size = DWC31_GTXFIFOSIZ_TXFDEF(size);
+	else
+		size = DWC3_GTXFIFOSIZ_TXFDEF(size);
 
-		if (!(dep->number > 1)) {
-			dep->endpoint.desc = &dwc3_gadget_ep0_desc;
-			dep->endpoint.comp_desc = NULL;
-		}
+	/* FIFO Depth is in MDWDITH bytes. Multiply */
+	size *= mdwidth;
 
-		spin_lock_init(&dep->lock);
-
-		if (num == 0) {
-			usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
-			dep->endpoint.maxburst = 1;
-			dep->endpoint.ops = &dwc3_gadget_ep0_ops;
-			if (!direction)
-				dwc->gadget.ep0 = &dep->endpoint;
-		} else if (direction) {
-			int mdwidth;
-			int kbytes;
-			int size;
-			int ret;
-
-			mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
-			/* MDWIDTH is represented in bits, we need it in bytes */
-			mdwidth /= 8;
-
-			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num));
-			if (dwc3_is_usb31(dwc))
-				size = DWC31_GTXFIFOSIZ_TXFDEF(size);
-			else
-				size = DWC3_GTXFIFOSIZ_TXFDEF(size);
+	kbytes = size / 1024;
+	if (kbytes == 0)
+		kbytes = 1;
 
-			/* FIFO Depth is in MDWDITH bytes. Multiply */
-			size *= mdwidth;
+	/*
+	 * FIFO sizes account an extra MDWIDTH * (kbytes + 1) bytes for
+	 * internal overhead. We don't really know how these are used,
+	 * but documentation say it exists.
+	 */
+	size -= mdwidth * (kbytes + 1);
+	size /= kbytes;
 
-			kbytes = size / 1024;
-			if (kbytes == 0)
-				kbytes = 1;
+	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
-			/*
-			 * FIFO sizes account an extra MDWIDTH * (kbytes + 1) bytes for
-			 * internal overhead. We don't really know how these are used,
-			 * but documentation say it exists.
-			 */
-			size -= mdwidth * (kbytes + 1);
-			size /= kbytes;
+	dep->endpoint.max_streams = 15;
+	dep->endpoint.ops = &dwc3_gadget_ep_ops;
+	list_add_tail(&dep->endpoint.ep_list,
+			&dwc->gadget.ep_list);
+	dep->endpoint.caps.type_iso = true;
+	dep->endpoint.caps.type_bulk = true;
+	dep->endpoint.caps.type_int = true;
 
-			usb_ep_set_maxpacket_limit(&dep->endpoint, size);
+	return dwc3_alloc_trb_pool(dep);
+}
 
-			dep->endpoint.max_streams = 15;
-			dep->endpoint.ops = &dwc3_gadget_ep_ops;
-			list_add_tail(&dep->endpoint.ep_list,
-					&dwc->gadget.ep_list);
+static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
 
-			ret = dwc3_alloc_trb_pool(dep);
-			if (ret)
-				return ret;
-		} else {
-			int		ret;
+	usb_ep_set_maxpacket_limit(&dep->endpoint, 1024);
+	dep->endpoint.max_streams = 15;
+	dep->endpoint.ops = &dwc3_gadget_ep_ops;
+	list_add_tail(&dep->endpoint.ep_list,
+			&dwc->gadget.ep_list);
+	dep->endpoint.caps.type_iso = true;
+	dep->endpoint.caps.type_bulk = true;
+	dep->endpoint.caps.type_int = true;
 
-			usb_ep_set_maxpacket_limit(&dep->endpoint, 1024);
-			dep->endpoint.max_streams = 15;
-			dep->endpoint.ops = &dwc3_gadget_ep_ops;
-			list_add_tail(&dep->endpoint.ep_list,
-					&dwc->gadget.ep_list);
+	return dwc3_alloc_trb_pool(dep);
+}
 
-			ret = dwc3_alloc_trb_pool(dep);
-			if (ret)
-				return ret;
-		}
+static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
+{
+	struct dwc3_ep			*dep;
+	bool				direction = epnum & 1;
+	int				ret;
+	u8				num = epnum >> 1;
 
-		if (num == 0) {
-			dep->endpoint.caps.type_control = true;
-		} else {
-			dep->endpoint.caps.type_iso = true;
-			dep->endpoint.caps.type_bulk = true;
-			dep->endpoint.caps.type_int = true;
-		}
+	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+	if (!dep)
+		return -ENOMEM;
 
-		dep->endpoint.caps.dir_in = direction;
-		dep->endpoint.caps.dir_out = !direction;
+	dep->dwc = dwc;
+	dep->number = epnum;
+	dep->direction = direction;
+	dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
+	dwc->eps[epnum] = dep;
 
-		INIT_LIST_HEAD(&dep->pending_list);
-		INIT_LIST_HEAD(&dep->started_list);
+	snprintf(dep->name, sizeof(dep->name), "ep%u%s", num,
+			direction ? "in" : "out");
+
+	dep->endpoint.name = dep->name;
+
+	if (!(dep->number > 1)) {
+		dep->endpoint.desc = &dwc3_gadget_ep0_desc;
+		dep->endpoint.comp_desc = NULL;
+	}
+
+	spin_lock_init(&dep->lock);
+
+	if (num == 0)
+		ret = dwc3_gadget_init_control_endpoint(dep);
+	else if (direction)
+		ret = dwc3_gadget_init_in_endpoint(dep);
+	else
+		ret = dwc3_gadget_init_out_endpoint(dep);
+
+	if (ret)
+		return ret;
+
+	dep->endpoint.caps.dir_in = direction;
+	dep->endpoint.caps.dir_out = !direction;
+
+	INIT_LIST_HEAD(&dep->pending_list);
+	INIT_LIST_HEAD(&dep->started_list);
+
+	return 0;
+}
+
+static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
+{
+	u8				epnum;
+
+	INIT_LIST_HEAD(&dwc->gadget.ep_list);
+
+	for (epnum = 0; epnum < total; epnum++) {
+		int			ret;
+
+		ret = dwc3_gadget_init_endpoint(dwc, epnum);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -2223,20 +2223,14 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 
 /* -------------------------------------------------------------------------- */
 
-static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
+static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, struct dwc3_trb *trb,
-		const struct dwc3_event_depevt *event, int status,
-		int chain)
+		const struct dwc3_event_depevt *event, int status, int chain)
 {
 	unsigned int		count;
-	unsigned int		s_pkt = 0;
-	unsigned int		trb_status;
 
 	dwc3_ep_inc_deq(dep);
 
-	if (req->trb == trb)
-		dep->queued_requests--;
-
 	trace_dwc3_complete_trb(dep, trb);
 
 	/*
@@ -2268,159 +2262,140 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
 		return 1;
 
-	if (dep->direction) {
-		if (count) {
-			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
-			if (trb_status == DWC3_TRBSTS_MISSED_ISOC) {
-				/*
-				 * If missed isoc occurred and there is
-				 * no request queued then issue END
-				 * TRANSFER, so that core generates
-				 * next xfernotready and we will issue
-				 * a fresh START TRANSFER.
-				 * If there are still queued request
-				 * then wait, do not issue either END
-				 * or UPDATE TRANSFER, just attach next
-				 * request in pending_list during
-				 * giveback.If any future queued request
-				 * is successfully transferred then we
-				 * will issue UPDATE TRANSFER for all
-				 * request in the pending_list.
-				 */
-				dep->flags |= DWC3_EP_MISSED_ISOC;
-			} else {
-				dev_err(dwc->dev, "incomplete IN transfer %s\n",
-						dep->name);
-				status = -ECONNRESET;
-			}
-		} else {
-			dep->flags &= ~DWC3_EP_MISSED_ISOC;
-		}
-	} else {
-		if (count && (event->status & DEPEVT_STATUS_SHORT))
-			s_pkt = 1;
-	}
-
-	if (s_pkt && !chain)
+	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if ((event->status & DEPEVT_STATUS_IOC) &&
-			(trb->ctrl & DWC3_TRB_CTRL_IOC))
+	if (event->status & DEPEVT_STATUS_IOC)
 		return 1;
 
 	return 0;
 }
 
-static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
-		const struct dwc3_event_depevt *event, int status)
+static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
+		struct dwc3_request *req, const struct dwc3_event_depevt *event,
+		int status)
 {
-	struct dwc3_request	*req, *n;
-	struct dwc3_trb		*trb;
-	bool			ioc = false;
-	int			ret = 0;
+	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
+	struct scatterlist *sg = req->sg;
+	struct scatterlist *s;
+	unsigned int pending = req->num_pending_sgs;
+	unsigned int i;
+	int ret = 0;
 
-	list_for_each_entry_safe(req, n, &dep->started_list, list) {
-		unsigned length;
-		int chain;
+	for_each_sg(sg, s, pending, i) {
+		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		length = req->request.length;
-		chain = req->num_pending_sgs > 0;
-		if (chain) {
-			struct scatterlist *sg = req->sg;
-			struct scatterlist *s;
-			unsigned int pending = req->num_pending_sgs;
-			unsigned int i;
-
-			for_each_sg(sg, s, pending, i) {
-				trb = &dep->trb_pool[dep->trb_dequeue];
-
-				if (trb->ctrl & DWC3_TRB_CTRL_HWO)
-					break;
-
-				req->sg = sg_next(s);
-				req->num_pending_sgs--;
-
-				ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
-						event, status, chain);
-				if (ret)
-					break;
-			}
-		} else {
-			trb = &dep->trb_pool[dep->trb_dequeue];
-			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
-					event, status, chain);
-		}
+		if (trb->ctrl & DWC3_TRB_CTRL_HWO)
+			break;
 
-		if (req->unaligned || req->zero) {
-			trb = &dep->trb_pool[dep->trb_dequeue];
-			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
-					event, status, false);
-			req->unaligned = false;
-			req->zero = false;
-		}
+		req->sg = sg_next(s);
+		req->num_pending_sgs--;
 
-		req->request.actual = length - req->remaining;
+		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
+				trb, event, status, true);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
 
-		if ((req->request.actual < length) && req->num_pending_sgs)
-			return __dwc3_gadget_kick_transfer(dep);
+static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
+		struct dwc3_request *req, const struct dwc3_event_depevt *event,
+		int status)
+{
+	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
 
-		dwc3_gadget_giveback(dep, req, status);
+	return dwc3_gadget_ep_reclaim_completed_trb(dep, req, trb,
+			event, status, false);
+}
 
-		if (ret) {
-			if ((event->status & DEPEVT_STATUS_IOC) &&
-			    (trb->ctrl & DWC3_TRB_CTRL_IOC))
-				ioc = true;
-			break;
-		}
+static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
+{
+	return req->request.actual == req->request.length;
+}
+
+static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event,
+		struct dwc3_request *req, int status)
+{
+	int ret;
+
+	if (req->num_pending_sgs)
+		ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event,
+				status);
+	else
+		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
+				status);
+
+	if (req->unaligned || req->zero) {
+		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
+				status);
+		req->unaligned = false;
+		req->zero = false;
 	}
 
-	/*
-	 * Our endpoint might get disabled by another thread during
-	 * dwc3_gadget_giveback(). If that happens, we're just gonna return 1
-	 * early on so DWC3_EP_BUSY flag gets cleared
-	 */
-	if (!dep->endpoint.desc)
-		return 1;
+	req->request.actual = req->request.length - req->remaining;
 
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			list_empty(&dep->started_list)) {
-		if (list_empty(&dep->pending_list)) {
-			/*
-			 * If there is no entry in request list then do
-			 * not issue END TRANSFER now. Just set PENDING
-			 * flag, so that END TRANSFER is issued when an
-			 * entry is added into request list.
-			 */
-			dep->flags = DWC3_EP_PENDING_REQUEST;
-		} else {
-			dwc3_stop_active_transfer(dwc, dep->number, true);
-			dep->flags = DWC3_EP_ENABLED;
-		}
-		return 1;
+	if (!dwc3_gadget_ep_request_completed(req) &&
+			req->num_pending_sgs) {
+		__dwc3_gadget_kick_transfer(dep);
+		goto out;
 	}
 
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) && ioc)
-		return 0;
+	dwc3_gadget_giveback(dep, req, status);
+
+out:
+	return ret;
+}
+
+static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event, int status)
+{
+	struct dwc3_request	*req;
+	struct dwc3_request	*tmp;
+
+	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
+		int ret;
+
+		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
+				req, status);
+		if (ret)
+			break;
+	}
+}
 
-	return 1;
+static void dwc3_gadget_endpoint_frame_from_event(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	dep->frame_number = event->parameters;
 }
 
-static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
-		struct dwc3_ep *dep, const struct dwc3_event_depevt *event)
+static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
 {
+	struct dwc3		*dwc = dep->dwc;
 	unsigned		status = 0;
-	int			clean_busy;
-	u32			is_xfer_complete;
+	bool			stop = false;
 
-	is_xfer_complete = (event->endpoint_event == DWC3_DEPEVT_XFERCOMPLETE);
+	dwc3_gadget_endpoint_frame_from_event(dep, event);
 
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
-	clean_busy = dwc3_cleanup_done_reqs(dwc, dep, event, status);
-	if (clean_busy && (!dep->endpoint.desc || is_xfer_complete ||
-				usb_endpoint_xfer_isoc(dep->endpoint.desc)))
-		dep->flags &= ~DWC3_EP_BUSY;
+	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
+		status = -EXDEV;
+
+		if (list_empty(&dep->started_list))
+			stop = true;
+	}
+
+	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
+
+	if (stop) {
+		dwc3_stop_active_transfer(dep, true);
+		dep->flags = DWC3_EP_ENABLED;
+	}
 
 	/*
 	 * WORKAROUND: This is the 2nd half of U1/U2 -> U0 workaround.
@@ -2446,17 +2421,13 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 
 		dwc->u1u2 = 0;
 	}
+}
 
-	/*
-	 * Our endpoint might get disabled by another thread during
-	 * dwc3_gadget_giveback(). If that happens, we're just gonna return 1
-	 * early on so DWC3_EP_BUSY flag gets cleared
-	 */
-	if (!dep->endpoint.desc)
-		return;
-
-	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		__dwc3_gadget_kick_transfer(dep);
+static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
+		const struct dwc3_event_depevt *event)
+{
+	dwc3_gadget_endpoint_frame_from_event(dep, event);
+	__dwc3_gadget_start_isoc(dep);
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -2483,32 +2454,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
-	case DWC3_DEPEVT_XFERCOMPLETE:
-		dep->resource_index = 0;
-
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dev_err(dwc->dev, "XferComplete for Isochronous endpoint\n");
-			return;
-		}
-
-		dwc3_endpoint_transfer_complete(dwc, dep, event);
-		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
-		dwc3_endpoint_transfer_complete(dwc, dep, event);
+		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
-			dwc3_gadget_start_isoc(dwc, dep, event);
-		else
-			__dwc3_gadget_kick_transfer(dep);
-
-		break;
-	case DWC3_DEPEVT_STREAMEVT:
-		if (!usb_endpoint_xfer_bulk(dep->endpoint.desc)) {
-			dev_err(dwc->dev, "Stream event for non-Bulk %s\n",
-					dep->name);
-			return;
-		}
+		dwc3_gadget_endpoint_transfer_not_ready(dep, event);
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
 		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
@@ -2518,6 +2468,8 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 			wake_up(&dep->wait_end_transfer);
 		}
 		break;
+	case DWC3_DEPEVT_STREAMEVT:
+	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
@@ -2562,15 +2514,13 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
+static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
 {
-	struct dwc3_ep *dep;
+	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
 
-	dep = dwc->eps[epnum];
-
 	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
 	    !dep->resource_index)
 		return;
@@ -2614,7 +2564,6 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
-	dep->flags &= ~DWC3_EP_BUSY;
 
 	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
@@ -2816,14 +2765,14 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	}
 
 	dep = dwc->eps[0];
-	ret = __dwc3_gadget_ep_enable(dep, true, false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_MODIFY);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		return;
 	}
 
 	dep = dwc->eps[1];
-	ret = __dwc3_gadget_ep_enable(dep, true, false);
+	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_MODIFY);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
 		return;
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 578aa856f986..db610c56f1d6 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -98,13 +98,12 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
  * Caller should take care of locking. Returns the transfer resource
  * index for a given endpoint.
  */
-static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
+static inline void dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
 {
 	u32			res_id;
 
 	res_id = dwc3_readl(dep->regs, DWC3_DEPCMD);
-
-	return DWC3_DEPCMD_GET_RSC_IDX(res_id);
+	dep->resource_index = DWC3_DEPCMD_GET_RSC_IDX(res_id);
 }
 
 #endif /* __DRIVERS_USB_DWC3_GADGET_H */
-- 
2.53.0

