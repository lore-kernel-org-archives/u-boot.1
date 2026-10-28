Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE8D606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HMMfYnWC;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NUT30M94
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB41640568;
	Wed, 28 Oct 2026 14:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84ioxW64QmHB; Wed, 28 Oct 2026 14:46:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8672406C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198779;
	b=Ua9EYbYt3xMvT7+d6POfoDh7VkHrZ3dH3aeQefu+ymof0YWZUSmJvfMXV2Duo5xz9R/2
	 vc+kbnq4SYp2cPBIhNI9EEkNBzN/zTlxuL6XDedq2hRNBCjBs0aR+AJXGPelcOz6nzih+
	 ChMVnUpdfsknEQHtMl/JcH3ge+ugI5wbzmecwhzbMAdkQCfzOdiU1O3DHVplmMY9UzDpa
	 5ZqfuYdiD4WrcNJlljgyJmP10wF78GSegKy0XaIkL+NM016y08Dlu4I8AuehJiXf0sLL2
	 z5EeSf3qxcktHGdDSwiC6//wbC6+nLYIrek2YgUQLEI2NgtceXcbu6uiVvVl8il7cgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198779;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k8Ip/PYHwHeKu+JrOpffYPDYfUcJczWYhl2ssvnU18Q=;
	b=nD4xZ3+pmfoVAQKxkAn0qYCE2XbIP07dtKoPvkK+IQ5SdsFrctiMN+W6tlRwc1AQNz1/
	 Rft0ceUHHAu1m35t+r8H7xtT9WCqyF8SWRC9ItUosVlO1bBdSEC3HRmnPmNiDao4Iu0+V
	 cok4drI22sgWuwC2sbYxV8+oddqN2oN20OxXwGC0nqHDEeTDmXIPTaTWiixGD1Cx+TDhd
	 irOrCzYqIE93TiOS8UcxPAftCiEpyHBvOOr1yUTWuKmAKPqNyoyYv5QEu6K6d/Oe5AfJo
	 3+YR+PpKB9awc1g2efxriRnTQupRK8rzWsppcggIksfjj750AL2LWP8xCEsiQk2cGiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198779;
	bh=k8Ip/PYHwHeKu+JrOpffYPDYfUcJczWYhl2ssvnU18Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HMMfYnWCTJ0SGtxl4dBL1tVchHxnQveuXp5F3AinbAJ5Nt424qQjDPrReUj8ZTuDz
	 IWV7wE4xR2WtrqoyypiIGmRElUffaL8gA1vBVIfS0SRwahXxqNF+jXqM8C+FxJSrAk
	 cKoghUU6lWsqOrEgaKB/F4vCDTEY3psOT9cQQLgNVJ4mQgeAD/63isuDkojcP6QT1N
	 W1N3m/Zb1xH97/u0r4Y6Gg/+YHHuUp5g7QaqX3hYJ3xFf8P0L3tR/HhS0rDUKWIgIZ
	 fL0NnibA7kA/HE2tAjntZaeaLkZjFBDTNlFeDGTB80qwl/uJxLKlKUJ+rf3Aot1xjm
	 YKoTDekvQ1z1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8672406C5;
	Wed, 28 Oct 2026 14:46:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AC8A529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7593D80BDB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5pkWAAxuiPX for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:10:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E582580BA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196657;
 b=jPBe2gS+M47CAy+GKOMmYm79lHjPP9U5iJt/XRhyrJfK3J2TBEL2ENWHK82q+rQbg/KY
 txkeB3e041hNkuWt0S971EotbNex9gYWIgnMF1jKfJc/Z7JCdhZpceFoVWOS97u651jPT
 8RMJ9T2C17PoY4AcfTCRoQDOHPWqTeplwd9jV4uWkxi2lfaROuE+9+Xb/bOsh0PZf7AoY
 cJNBBUn1gh6VzpsM6C2VAcgthx5IrbEV1cq6LxFraWtVfyo8bdd5rEr1gGVHvQW/nGhta
 xFF2oqeuv9OcrjzWGDuZxDmkdigdGHwiy1L6E+X8aIUjVJRGQTIOZynDCJAs6zOeDyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196657;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=k8Ip/PYHwHeKu+JrOpffYPDYfUcJczWYhl2ssvnU18Q=;
 b=EIU+OQZd36W1MsQrr8yLwoL3G1jgfOq2dLj/J248asrGapeM7WvTIKZUxa+XmUCp09cF
 wp8ivcKAEtvFvUTlXhe3E9R8dsvlef/O7Y1CxyzoMtUDjwNOQgwf1nIxwf9MHgDpMsKQf
 1QzanNr3VRqABTDUamRxQMDVy6VQ8/mvpG7ZcLc0MrYVI2bIU/Gc3+TuP7agttWEija5e
 oWBZ0GvH9whc19sa27oJCXiGfusVK0V+bzy0P1IhDbahXKDU7ovY2p5W0WG0l7pEirCL7
 2gwstLivASFvXyvxMeMVHpQSYfQc2nzO/dGIAxjclrImYE3AukhN3kpckio9Eee4yeA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NUT30M94; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=NUT30M94
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E582580BA6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:56 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c347be93d54so11341566b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196655; x=1793801455;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k8Ip/PYHwHeKu+JrOpffYPDYfUcJczWYhl2ssvnU18Q=;
 b=NUT30M947SNZRNaA4cCnJFwB7m0FAp96G04pxbmETxGcr/XTGjZxtg/vfsTuSfHrYj
 3HKnJMcq0U6RhSFvfvXBMomeKcvL5VAcqmFRppA4Zs3RbGizJilBaDHH/8QtCuXfw/oZ
 F1HojYYFe6bLci0oVcBQEmO1VbkEPWd/NXIG0TrU3rqEveRm/JcNUrx1zibS/NCYPNjW
 1DMWo/tljrPnq2f4ORweal4RNH+D1jAVeMZ4mTAehRKXQIOOvc9qnilzsIitOKsigyDo
 L62Srx9yUthiSe+QbRQ/mrKViu48sWqQYxH/qwLz6KVRhGGuUdPcYMlXfm4WefCKDWmc
 /OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196655; x=1793801455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k8Ip/PYHwHeKu+JrOpffYPDYfUcJczWYhl2ssvnU18Q=;
 b=oC9RFHmj+IIcl7Gdw0EN8jakh81QetuZTPykyNlimsNqLLEdbK0Lf0EJyCsG9OUaEE
 s8IvqbLWQHjd/T1W2gbRt6/u4Sqdm2h98E6ImLU+E/kvz+LakfAFt5zH3/nbWa4UHPWp
 /cYkFnGR6PN5p1OnHw+o9m/qWD388L7f6ITYef1/oofwLXCwLTMZzA8P8oQhVKIXoLlR
 Pz6QNU/opoWxP1BQQVxBY4UTL+06j8802z3vZuMl7IWS0I0jf0Le2jzj8LHLvbj+37wZ
 RfdKy/VBNus6apaSK/TJsskcr156yTDYQeFRoSe8byoMyy0Z759s5/VHS0jqnRwYam6D
 NOuw==
X-Gm-Message-State: AFq9FYJmmaLSC/v/mG9xy/Hn4Aqrv3a5OePuIo7lSyj5KkurfnbdWDx4
 AYAAecgExxxyHHjivtDnLEnCclT3fkbSCxF/W100KdBMcbLO6IBIZxLy2gtm4cSRwSHK3xIFeaN
 jOjcd
X-Gm-Gg: AYBFou3YQefihgKthjfvFYdmSI1DtInP2GjSrWtnHltLyctXsYR6XFoukjdixJ4V71M
 kERR5SLje6XK/4QC1jwnMCGvndJrpmG+sjZhF5G0guHdkDsQDSeRJtf95LCRigh0NZC0r2TkEmg
 AoRPMfChVoDFYNRl2l/U3fJNc6ONG7VMUs55BzZj651InJuAYn3liCI3uV7AJwJMCSgaGfFEs0T
 900Bawc0VvPuV9Uq+RlkSx5ev0TlRCJSs2io8bzAuhQ7uASIUlpayxbqOVG4mRITas7zVVWM9fJ
 WsJ0yjTI4XjoH3nhJN3mzfLc79YVf80ZOvSDuclAt8rx3LCt9AEmDaBSyX3K9rympyb5D6R+Edq
 OSz/U+qwsPEgFkKlEXImpSgrh1Umm3vEsJTUaRHtp/Az5aNd5NKeZvD9z3McM++2fJcD/U7/Tsk
 3pmry40HBjFBi3/ENbsRIxGKx5Du89Yw4wbBJLBwd8i91tbQRfVbnLUbHTQjeYP2TVIxaB/jq25
 H0NyUtLkwsSJUdQK+Ezw/0YDsN5Vn2tIlBAJ9pEFER0dtH63vgWRfammqwC1cxR7RNCPS4Vqwk7
 LKyIlgy4WlI8OLBfspp9KpDoUygRfFeWjYRrrQFsY8wfwT7KP6ltXsQR/Bz/retB8bVWJ9joSar
 qIgnIptgJtJ8=
X-Received: by 2002:a17:907:da10:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c49bda96afamr288069466b.0.1793196654234; 
 Wed, 28 Oct 2026 07:10:54 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:10:53 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 12/63] usb: dwc3: import from kernel v4.8
Date: Wed, 28 Oct 2026 15:08:38 +0100
Message-ID: <20261028140930.3025368-13-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.7 to v4.8.

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

List of commits: git log --oneline v4.7..v4.8
Commits imported:
9d7aba7786b6 Revert "usb: dwc3: gadget: always decrement by 1"
6f8245b4e37c usb: dwc3: gadget: always decrement by 1
696fe69d7e63 usb: dwc3: debug: fix ep name on trace output
d6011f6fc21b usb: dwc3: gadget: don't rely on jiffies while holding spinlock
b74c2d875baa usb: dwc3: core: allow device to runtime_suspend several times
a0ad85ae866f usb: dwc3: gadget: stop processing on HWO set
79d17482a409 usb: dwc3: don't set last bit for ISOC endpoints
7c705dfe2ebe usb: dwc3: gadget: always cleanup all TRBs
e5b36ae2f851 usb: dwc3: gadget: fix for short pkts during chained xfers
c7de57347183 usb: dwc3: gadget: increment request->actual once
72704f876f50 dwc3: gadget: Implement the suspend entry event handler
9522def40065 usb: dwc3: core: cleanup IRQ resources
da1410be21bf usb: dwc3: gadget: Add the suspend state checking when stopping gadget
0e146028eebf usb: dwc3: gadget: issue ENDTRANSFER conditional on resource_index
328082376aea usb: dwc3: fix runtime PM in error path
b6d4e16e8313 usb: dwc3: gadget: simplify run_stop() break condition
f2df679b6c55 usb: dwc3: gadget: avoid while(1) in run_stop()
d807bdd02845 usb: dwc3: gadget: remove udelay() from run_stop()
5f82279a0c76 usb: dwc3: core: fixup dr_mode fallback selection
21e64bf20df5 usb: dwc3: gadget: rename 'ignore' argument to 'modify'
d6dc2e76a860 usb: dwc3: gadget: decrement trbs_left for each sg entry
ba62c09d5cc2 usb: dwc3: gadget: start Bulk endpoints more frequently
13fa2e69b1dd usb: dwc3: gadget: disable XFER_NOT_READY
55a0237f8f47 usb: dwc3: gadget: use allocated/queued reqs for LST bit
69450c4dc164 usb: dwc3: gadget: halt and stop based HWO bit
68d34c8a744d usb: dwc3: gadget: keep track of allocated and queued reqs
b6b1c6db4c7f usb: dwc3: gadget: update transfer needs transfer resource
d18e65470a4d usb: dwc3: remove handling of platform data
60cfb37ac9bc usb: dwc3: remove trailing newline from dwc3_trace
475c8beb35e1 usb: dwc3: add DWC3_GUCTL1 reg for debug
e77c561432bc usb: dwc3: Fix DWC3_USB31_REVISION_110A definition
2da9ad761e70 usb: dwc3: Use the correct speed macros for DSTS/DCFG
3de2685f0c39 usb: dwc3: gadget: Fix truncated cast issue
361572b5f7a9 usb: dwc3: gadget: Handle TRB index 0 when full or empty
7d0a038b130c usb: dwc3: gadget: Account for link TRB in TRBs left
32db3d9437b6 usb: dwc3: gadget: Account for max size in TRB space
89bc856e5a74 usb: dwc3: gadget: Don't prepare TRBs if no space
0d25744ad107 usb: dwc3: gadget: Initialize the TRB ring
dca0119c3ab6 usb: dwc3: gadget: Simplify skipping of link TRBs
d07fa665c79d usb: dwc3: gadget: Fix usage of bitwise operator
501058edebf9 usb: dwc3: ep0: Use the correct type for SET_SEL data
958b9fa7f8cf usb: dwc3: ep0: Fix endianness of wIndex passed to dwc3_wIndex_to_dep
71f7e7027028 usb: dwc3: gadget: improve gcmd trace
88811f7b722c usb: dwc3: gadget: remove udelay() from generic cmd
0fe886cdb07a usb: dwc3: gadget: single return point on generic commands
0933df159c5c usb: dwc3: trace: print ep cmd status with a single trace
f6bb225bb3ca usb: dwc3: gadget: loop while (timeout)
ba1598410eff usb: dwc3: gadget: fix trace output when command fails
f75cacc468ed usb: dwc3: trace: fully decode IRQ events
7ab373aadbd0 usb: dwc3: gadget: no more tracking endpoint type with its name
74674cbf858f usb: dwc3: gadget: add a per-endpoint request queue lock
fc8bb91bc83e usb: dwc3: implement runtime PM
4cb4221764ef usb: dwc3: gadget: fix for possible endpoint disable race
9cad39fe4e4a usb: dwc3: fix for the isoc transfer EP_BUSY flag
ab2a92e7a608 usb: dwc3: gadget: only resume USB2 PHY in <=HIGHSPEED
3f308d17d7ab usb: dwc3: gadget: hold gadget IRQ in dwc->irq_gadget
51f5d49ad6f0 usb: dwc3: core: simplify suspend/resume operations
c499ff71ff2a usb: dwc3: core: re-factor init and exit paths
bcdb3272e889 usb: dwc3: core: move fladj to dwc3 structure
2eb8801650b3 usb: dwc3: gadget: add a pointer to endpoint registers
2cd4718d0bbe usb: dwc3: gadget: pass dep as argument to endpoint command
4e99472bc10b usb: dwc3: gadget: initialize NUMP based on RxFIFO Size
5ee85d890f8d usb: dwc3: gadget: split __dwc3_gadget_kick_transfer()
6b74289937f6 usb: dwc3: gadget: return 0 if we try to Wakeup in superspeed
b43bba96b903 usb: dwc3: gadget: remove udelay(1) when sending ep cmds
6aff48329595 usb: dwc3: gadget: rely on sg_is_last() and list_is_last()
4fae2e3e1515 usb: dwc3: gadget: simplify __dwc3_gadget_kick_transfer()
c4233573f6ee usb: dwc3: gadget: prepare TRBs on update transfers too
7f370ed0cfe9 usb: dwc3: core: get rid of DWC3_PM_OPS macro
9f8a67b65a49 usb: dwc3: gadget: fix gadget suspend/resume
d7be295243bb usb: dwc3: gadget: re-factor ->udc_start and ->udc_stop

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c          | 389 +++++++------
 drivers/usb/dwc3/core.h          |  59 +-
 drivers/usb/dwc3/debug.h         | 140 ++++-
 drivers/usb/dwc3/ep0.c           |  26 +-
 drivers/usb/dwc3/gadget.c        | 924 ++++++++++++++++++-------------
 drivers/usb/dwc3/gadget.h        |   4 +-
 drivers/usb/dwc3/io.h            |   7 +-
 drivers/usb/dwc3/platform_data.h |  53 --
 8 files changed, 926 insertions(+), 676 deletions(-)
 delete mode 100644 drivers/usb/dwc3/platform_data.h

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a590cd225bb7..35d092456bec 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -41,14 +41,13 @@
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 
-#include "platform_data.h"
 #include "core.h"
 #include "gadget.h"
 #include "io.h"
 
 #include "debug.h"
 
-/* -------------------------------------------------------------------------- */
+#define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 {
@@ -149,9 +148,8 @@ static int dwc3_soft_reset(struct dwc3 *dwc)
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
- * @fladj: Value of GFLADJ_30MHZ to adjust frame length
  */
-static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
+static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 {
 	u32 reg;
 	u32 dft;
@@ -159,15 +157,15 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
 	if (dwc->revision < DWC3_REVISION_250A)
 		return;
 
-	if (fladj == 0)
+	if (dwc->fladj == 0)
 		return;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
 	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
-	if (!dev_WARN_ONCE(dwc->dev, dft == fladj,
+	if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
 	    "request value same as default, ignoring\n")) {
 		reg &= ~DWC3_GFLADJ_30MHZ_MASK;
-		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | fladj;
+		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | dwc->fladj;
 		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 	}
 }
@@ -507,6 +505,21 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	return 0;
 }
 
+static void dwc3_core_exit(struct dwc3 *dwc)
+{
+	dwc3_event_buffers_cleanup(dwc);
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
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -556,6 +569,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err0;
 
+	ret = dwc3_phy_setup(dwc);
+	if (ret)
+		goto err0;
+
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
 
@@ -622,22 +639,45 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (dwc->revision < DWC3_REVISION_190A)
 		reg |= DWC3_GCTL_U2RSTECN;
 
-	dwc3_core_num_eps(dwc);
-
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
-	ret = dwc3_alloc_scratch_buffers(dwc);
-	if (ret)
-		goto err1;
+	dwc3_core_num_eps(dwc);
 
 	ret = dwc3_setup_scratch_buffers(dwc);
 	if (ret)
+		goto err1;
+
+	/* Adjust Frame Length */
+	dwc3_frame_length_adjustment(dwc);
+
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
 		goto err2;
 
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err3;
+
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto err4;
+	}
+
 	return 0;
 
+err4:
+	phy_power_off(dwc->usb2_generic_phy);
+
+err3:
+	phy_power_off(dwc->usb3_generic_phy);
+
 err2:
-	dwc3_free_scratch_buffers(dwc);
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	dwc3_core_exit(dwc);
 
 err1:
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -649,15 +689,6 @@ err0:
 	return ret;
 }
 
-static void dwc3_core_exit(struct dwc3 *dwc)
-{
-	dwc3_free_scratch_buffers(dwc);
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
-}
-
 static int dwc3_core_get_phy(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
@@ -735,7 +766,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize gadget\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize gadget\n");
 			return ret;
 		}
 		break;
@@ -743,7 +775,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize host\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
 		break;
@@ -751,13 +784,15 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize host\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
-			dev_err(dev, "failed to initialize gadget\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize gadget\n");
 			return ret;
 		}
 		break;
@@ -793,13 +828,11 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
-	struct dwc3_platform_data *pdata = dev_get_platdata(dev);
 	struct resource		*res;
 	struct dwc3		*dwc;
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
-	u32			fladj = 0;
 
 	int			ret;
 
@@ -814,16 +847,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->mem = mem;
 	dwc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "missing IRQ\n");
-		return -ENODEV;
-	}
-	dwc->xhci_resources[1].start = res->start;
-	dwc->xhci_resources[1].end = res->end;
-	dwc->xhci_resources[1].flags = res->flags;
-	dwc->xhci_resources[1].name = res->name;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "missing memory resource\n");
@@ -909,40 +932,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	device_property_read_string(dev, "snps,hsphy_interface",
 				    &dwc->hsphy_interface);
 	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
-				 &fladj);
-
-	if (pdata) {
-		dwc->maximum_speed = pdata->maximum_speed;
-		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
-		if (pdata->lpm_nyet_threshold)
-			lpm_nyet_threshold = pdata->lpm_nyet_threshold;
-		dwc->is_utmi_l1_suspend = pdata->is_utmi_l1_suspend;
-		if (pdata->hird_threshold)
-			hird_threshold = pdata->hird_threshold;
-
-		dwc->usb3_lpm_capable = pdata->usb3_lpm_capable;
-		dwc->dr_mode = pdata->dr_mode;
-
-		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
-		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
-		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
-		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
-		dwc->del_p1p2p3_quirk = pdata->del_p1p2p3_quirk;
-		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
-		dwc->lfps_filter_quirk = pdata->lfps_filter_quirk;
-		dwc->rx_detect_poll_quirk = pdata->rx_detect_poll_quirk;
-		dwc->dis_u3_susphy_quirk = pdata->dis_u3_susphy_quirk;
-		dwc->dis_u2_susphy_quirk = pdata->dis_u2_susphy_quirk;
-		dwc->dis_enblslpm_quirk = pdata->dis_enblslpm_quirk;
-		dwc->dis_rxdet_inp3_quirk = pdata->dis_rxdet_inp3_quirk;
-
-		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
-		if (pdata->tx_de_emphasis)
-			tx_de_emphasis = pdata->tx_de_emphasis;
-
-		dwc->hsphy_interface = pdata->hsphy_interface;
-		fladj = pdata->fladj_value;
-	}
+				 &dwc->fladj);
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
@@ -953,10 +943,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	ret = dwc3_phy_setup(dwc);
-	if (ret)
-		goto err0;
-
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
 		goto err0;
@@ -969,29 +955,43 @@ static int dwc3_probe(struct platform_device *pdev)
 		dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
 	}
 
+	pm_runtime_set_active(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
 	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto err1;
+
 	pm_runtime_forbid(dev);
 
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
 		ret = -ENOMEM;
-		goto err1;
+		goto err2;
 	}
 
-	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
+	if (IS_ENABLED(CONFIG_USB_DWC3_HOST) &&
+			(dwc->dr_mode == USB_DR_MODE_OTG ||
+					dwc->dr_mode == USB_DR_MODE_UNKNOWN))
 		dwc->dr_mode = USB_DR_MODE_HOST;
-	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET) &&
+			(dwc->dr_mode == USB_DR_MODE_OTG ||
+					dwc->dr_mode == USB_DR_MODE_UNKNOWN))
 		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
 
 	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
 		dwc->dr_mode = USB_DR_MODE_OTG;
 
+	ret = dwc3_alloc_scratch_buffers(dwc);
+	if (ret)
+		goto err3;
+
 	ret = dwc3_core_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize core\n");
-		goto err1;
+		goto err4;
 	}
 
 	/* Check the maximum_speed parameter */
@@ -1021,31 +1021,12 @@ static int dwc3_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Adjust Frame Length */
-	dwc3_frame_length_adjustment(dwc, fladj);
-
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err2;
-
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err3;
-
-	ret = dwc3_event_buffers_setup(dwc);
-	if (ret) {
-		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err4;
-	}
-
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
 		goto err5;
 
 	dwc3_debugfs_init(dwc);
-	pm_runtime_allow(dev);
+	pm_runtime_put(dev);
 
 	return 0;
 
@@ -1053,19 +1034,18 @@ err5:
 	dwc3_event_buffers_cleanup(dwc);
 
 err4:
-	phy_power_off(dwc->usb3_generic_phy);
+	dwc3_free_scratch_buffers(dwc);
 
 err3:
-	phy_power_off(dwc->usb2_generic_phy);
+	dwc3_free_event_buffers(dwc);
+	dwc3_ulpi_exit(dwc);
 
 err2:
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	dwc3_core_exit(dwc);
+	pm_runtime_allow(&pdev->dev);
 
 err1:
-	dwc3_free_event_buffers(dwc);
-	dwc3_ulpi_exit(dwc);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 err0:
 	/*
@@ -1083,6 +1063,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
+	pm_runtime_get_sync(&pdev->dev);
 	/*
 	 * restore res->start back to its original value so that, in case the
 	 * probe is deferred, we don't end up getting error in request the
@@ -1092,133 +1073,193 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
-	dwc3_event_buffers_cleanup(dwc);
-	dwc3_free_event_buffers(dwc);
-
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
 
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	dwc3_free_event_buffers(dwc);
+	dwc3_free_scratch_buffers(dwc);
+
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dwc3_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int dwc3_suspend_common(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
 	unsigned long	flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
-
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 	case USB_DR_MODE_OTG:
+		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
-		/* FALLTHROUGH */
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		break;
 	case USB_DR_MODE_HOST:
 	default:
-		dwc3_event_buffers_cleanup(dwc);
+		/* do nothing */
 		break;
 	}
 
-	dwc->gctl = dwc3_readl(dwc->regs, DWC3_GCTL);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	dwc3_core_exit(dwc);
 
-	usb_phy_shutdown(dwc->usb3_phy);
-	usb_phy_shutdown(dwc->usb2_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+	return 0;
+}
 
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	WARN_ON(phy_power_off(dwc->usb2_generic_phy) < 0);
-	WARN_ON(phy_power_off(dwc->usb3_generic_phy) < 0);
+static int dwc3_resume_common(struct dwc3 *dwc)
+{
+	unsigned long	flags;
+	int		ret;
 
-	pinctrl_pm_select_sleep_state(dev);
+	ret = dwc3_core_init(dwc);
+	if (ret)
+		return ret;
+
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+	case USB_DR_MODE_OTG:
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc3_gadget_resume(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		/* FALLTHROUGH */
+	case USB_DR_MODE_HOST:
+	default:
+		/* do nothing */
+		break;
+	}
 
 	return 0;
 }
 
-static int dwc3_resume(struct device *dev)
+static int dwc3_runtime_checks(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
-	unsigned long	flags;
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+	case USB_DR_MODE_OTG:
+		if (dwc->connected)
+			return -EBUSY;
+		break;
+	case USB_DR_MODE_HOST:
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return 0;
+}
+
+static int dwc3_runtime_suspend(struct device *dev)
+{
+	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
 
-	pinctrl_pm_select_default_state(dev);
+	if (dwc3_runtime_checks(dwc))
+		return -EBUSY;
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
+	ret = dwc3_suspend_common(dwc);
+	if (ret)
 		return ret;
 
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_usb2phy_power;
+	device_init_wakeup(dev, true);
 
-	usb_phy_init(dwc->usb3_phy);
-	usb_phy_init(dwc->usb2_phy);
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err_usb3phy_power;
+	return 0;
+}
 
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err_usb2phy_init;
+static int dwc3_runtime_resume(struct device *dev)
+{
+	struct dwc3     *dwc = dev_get_drvdata(dev);
+	int		ret;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	device_init_wakeup(dev, false);
 
-	dwc3_event_buffers_setup(dwc);
-	dwc3_writel(dwc->regs, DWC3_GCTL, dwc->gctl);
+	ret = dwc3_resume_common(dwc);
+	if (ret)
+		return ret;
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 	case USB_DR_MODE_OTG:
-		dwc3_gadget_resume(dwc);
-		/* FALLTHROUGH */
+		dwc3_gadget_process_pending_events(dwc);
+		break;
 	case USB_DR_MODE_HOST:
 	default:
 		/* do nothing */
 		break;
 	}
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put(dev);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+	return 0;
+}
+
+static int dwc3_runtime_idle(struct device *dev)
+{
+	struct dwc3     *dwc = dev_get_drvdata(dev);
+
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+	case USB_DR_MODE_OTG:
+		if (dwc3_runtime_checks(dwc))
+			return -EBUSY;
+		break;
+	case USB_DR_MODE_HOST:
+	default:
+		/* do nothing */
+		break;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_autosuspend(dev);
 
 	return 0;
+}
+#endif /* CONFIG_PM */
 
-err_usb2phy_init:
-	phy_exit(dwc->usb2_generic_phy);
+#ifdef CONFIG_PM_SLEEP
+static int dwc3_suspend(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int		ret;
 
-err_usb3phy_power:
-	phy_power_off(dwc->usb3_generic_phy);
+	ret = dwc3_suspend_common(dwc);
+	if (ret)
+		return ret;
 
-err_usb2phy_power:
-	phy_power_off(dwc->usb2_generic_phy);
+	pinctrl_pm_select_sleep_state(dev);
 
-	return ret;
+	return 0;
 }
 
+static int dwc3_resume(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int		ret;
+
+	pinctrl_pm_select_default_state(dev);
+
+	ret = dwc3_resume_common(dwc);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
+			dwc3_runtime_idle)
 };
 
-#define DWC3_PM_OPS	&(dwc3_dev_pm_ops)
-#else
-#define DWC3_PM_OPS	NULL
-#endif
-
 #ifdef CONFIG_OF
 static const struct of_device_id of_dwc3_match[] = {
 	{
@@ -1250,7 +1291,7 @@ static struct platform_driver dwc3_driver = {
 		.name	= "dwc3",
 		.of_match_table	= of_match_ptr(of_dwc3_match),
 		.acpi_match_table = ACPI_PTR(dwc3_acpi_match),
-		.pm	= DWC3_PM_OPS,
+		.pm	= &dwc3_dev_pm_ops,
 	},
 };
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 654050684f4f..45d6de5107c7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -86,6 +86,7 @@
 #define DWC3_GCTL		0xc110
 #define DWC3_GEVTEN		0xc114
 #define DWC3_GSTS		0xc118
+#define DWC3_GUCTL1		0xc11c
 #define DWC3_GSNPSID		0xc120
 #define DWC3_GGPIO		0xc124
 #define DWC3_GUID		0xc128
@@ -138,10 +139,12 @@
 #define DWC3_DGCMDPAR		0xc710
 #define DWC3_DGCMD		0xc714
 #define DWC3_DALEPENA		0xc720
-#define DWC3_DEPCMDPAR2(n)	(0xc800 + (n * 0x10))
-#define DWC3_DEPCMDPAR1(n)	(0xc804 + (n * 0x10))
-#define DWC3_DEPCMDPAR0(n)	(0xc808 + (n * 0x10))
-#define DWC3_DEPCMD(n)		(0xc80c + (n * 0x10))
+
+#define DWC3_DEP_BASE(n)	(0xc800 + (n * 0x10))
+#define DWC3_DEPCMDPAR2		0x00
+#define DWC3_DEPCMDPAR1		0x04
+#define DWC3_DEPCMDPAR0		0x08
+#define DWC3_DEPCMD		0x0c
 
 /* OTG Registers */
 #define DWC3_OCFG		0xcc00
@@ -231,6 +234,14 @@
 #define DWC3_GEVNTSIZ_INTMASK		(1 << 31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
 
+/* Global HWPARAMS0 Register */
+#define DWC3_GHWPARAMS0_USB3_MODE(n)	((n) & 0x3)
+#define DWC3_GHWPARAMS0_MBUS_TYPE(n)	(((n) >> 3) & 0x7)
+#define DWC3_GHWPARAMS0_SBUS_TYPE(n)	(((n) >> 6) & 0x3)
+#define DWC3_GHWPARAMS0_MDWIDTH(n)	(((n) >> 8) & 0xff)
+#define DWC3_GHWPARAMS0_SDWIDTH(n)	(((n) >> 16) & 0xff)
+#define DWC3_GHWPARAMS0_AWIDTH(n)	(((n) >> 24) & 0xff)
+
 /* Global HWPARAMS1 Register */
 #define DWC3_GHWPARAMS1_EN_PWROPT(n)	(((n) & (3 << 24)) >> 24)
 #define DWC3_GHWPARAMS1_EN_PWROPT_NO	0
@@ -260,6 +271,10 @@
 /* Global HWPARAMS6 Register */
 #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
 
+/* Global HWPARAMS7 Register */
+#define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
+#define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
+
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
@@ -468,6 +483,8 @@ struct dwc3_event_buffer {
  * @endpoint: usb endpoint
  * @pending_list: list of pending requests for this endpoint
  * @started_list: list of started requests on this endpoint
+ * @lock: spinlock for endpoint request queue traversal
+ * @regs: pointer to first endpoint register
  * @trb_pool: array of transaction buffers
  * @trb_pool_dma: dma address of @trb_pool
  * @trb_enqueue: enqueue 'pointer' into TRB array
@@ -480,6 +497,8 @@ struct dwc3_event_buffer {
  * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
  * @resource_index: Resource transfer index
  * @interval: the interval on which the ISOC transfer is started
+ * @allocated_requests: number of requests allocated
+ * @queued_requests: number of requests queued for transfer
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
@@ -489,6 +508,9 @@ struct dwc3_ep {
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
+	spinlock_t		lock;
+	void __iomem		*regs;
+
 	struct dwc3_trb		*trb_pool;
 	dma_addr_t		trb_pool_dma;
 	const struct usb_ss_ep_comp_descriptor *comp_desc;
@@ -521,6 +543,8 @@ struct dwc3_ep {
 	u8			number;
 	u8			type;
 	u8			resource_index;
+	u32			allocated_requests;
+	u32			queued_requests;
 	u32			interval;
 
 	char			name[20];
@@ -712,6 +736,8 @@ struct dwc3_scratchpad_array {
  * @gadget_driver: pointer to the gadget driver
  * @regs: base address for our registers
  * @regs_size: address space size
+ * @fladj: frame length adjustment
+ * @irq_gadget: peripheral controller's IRQ number
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
@@ -744,6 +770,7 @@ struct dwc3_scratchpad_array {
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
  * @hsphy_interface: "utmi" or "ulpi"
+ * @connected: true when we're connected to a host, false otherwise
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
@@ -754,6 +781,7 @@ struct dwc3_scratchpad_array {
  * 	0	- utmi_sleep_n
  * 	1	- utmi_l1_suspend_n
  * @is_fpga: true when we are using the FPGA board
+ * @pending_events: true when we have pending IRQs to be handled
  * @pullups_connected: true when Run/Stop bit is set
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @start_config_issued: true when StartConfig command has been issued
@@ -818,10 +846,8 @@ struct dwc3 {
 
 	enum usb_dr_mode	dr_mode;
 
-	/* used for suspend/resume */
-	u32			dcfg;
-	u32			gctl;
-
+	u32			fladj;
+	u32			irq_gadget;
 	u32			nr_scratch;
 	u32			u1u2;
 	u32			maximum_speed;
@@ -860,7 +886,7 @@ struct dwc3 {
  * just so dwc31 revisions are always larger than dwc3.
  */
 #define DWC3_REVISION_IS_DWC31		0x80000000
-#define DWC3_USB31_REVISION_110A	(0x3131302a | DWC3_REVISION_IS_USB31)
+#define DWC3_USB31_REVISION_110A	(0x3131302a | DWC3_REVISION_IS_DWC31)
 
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
@@ -890,6 +916,7 @@ struct dwc3 {
 
 	const char		*hsphy_interface;
 
+	unsigned		connected:1;
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
@@ -897,6 +924,7 @@ struct dwc3 {
 	unsigned		has_lpm_erratum:1;
 	unsigned		is_utmi_l1_suspend:1;
 	unsigned		is_fpga:1;
+	unsigned		pending_events:1;
 	unsigned		pullups_connected:1;
 	unsigned		setup_packet_pending:1;
 	unsigned		three_stage_setup:1;
@@ -1094,8 +1122,8 @@ void dwc3_gadget_exit(struct dwc3 *dwc);
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode);
 int dwc3_gadget_get_link_state(struct dwc3 *dwc);
 int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state);
-int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
-		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params);
+int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
+		struct dwc3_gadget_ep_cmd_params *params);
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
@@ -1110,8 +1138,8 @@ static inline int dwc3_gadget_set_link_state(struct dwc3 *dwc,
 		enum dwc3_link_state state)
 { return 0; }
 
-static inline int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
-		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
+static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
+		struct dwc3_gadget_ep_cmd_params *params)
 { return 0; }
 static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 		int cmd, u32 param)
@@ -1122,6 +1150,7 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
 int dwc3_gadget_resume(struct dwc3 *dwc);
+void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
@@ -1132,6 +1161,10 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 {
 	return 0;
 }
+
+static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
+{
+}
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
 #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 71e318025964..33ab2a203c1b 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -128,56 +128,112 @@ dwc3_gadget_link_string(enum dwc3_link_state link_state)
  * dwc3_gadget_event_string - returns event name
  * @event: the event code
  */
-static inline const char *dwc3_gadget_event_string(u8 event)
+static inline const char *
+dwc3_gadget_event_string(const struct dwc3_event_devt *event)
 {
-	switch (event) {
+	static char str[256];
+	enum dwc3_link_state state = event->event_info & DWC3_LINK_STATE_MASK;
+
+	switch (event->type) {
 	case DWC3_DEVICE_EVENT_DISCONNECT:
-		return "Disconnect";
+		sprintf(str, "Disconnect: [%s]",
+				dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_RESET:
-		return "Reset";
+		sprintf(str, "Reset [%s]", dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_CONNECT_DONE:
-		return "Connection Done";
+		sprintf(str, "Connection Done [%s]",
+				dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
-		return "Link Status Change";
+		sprintf(str, "Link Change [%s]",
+				dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_WAKEUP:
-		return "WakeUp";
+		sprintf(str, "WakeUp [%s]", dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_EOPF:
-		return "End-Of-Frame";
+		sprintf(str, "End-Of-Frame [%s]",
+				dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_SOF:
-		return "Start-Of-Frame";
+		sprintf(str, "Start-Of-Frame [%s]",
+				dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
-		return "Erratic Error";
+		sprintf(str, "Erratic Error [%s]",
+				dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_CMD_CMPL:
-		return "Command Complete";
+		sprintf(str, "Command Complete [%s]",
+				dwc3_gadget_link_string(state));
+		break;
 	case DWC3_DEVICE_EVENT_OVERFLOW:
-		return "Overflow";
+		sprintf(str, "Overflow [%s]", dwc3_gadget_link_string(state));
+		break;
+	default:
+		sprintf(str, "UNKNOWN");
 	}
 
-	return "UNKNOWN";
+	return str;
 }
 
 /**
  * dwc3_ep_event_string - returns event name
  * @event: then event code
  */
-static inline const char *dwc3_ep_event_string(u8 event)
+static inline const char *
+dwc3_ep_event_string(const struct dwc3_event_depevt *event)
 {
-	switch (event) {
+	u8 epnum = event->endpoint_number;
+	static char str[256];
+	int status;
+	int ret;
+
+	ret = sprintf(str, "ep%d%s: ", epnum >> 1,
+			(epnum & 1) ? "in" : "out");
+	if (ret < 0)
+		return "UNKNOWN";
+
+	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
-		return "Transfer Complete";
+		strcat(str, "Transfer Complete");
+		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
-		return "Transfer In-Progress";
+		strcat(str, "Transfer In-Progress");
+		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		return "Transfer Not Ready";
+		strcat(str, "Transfer Not Ready");
+		status = event->status & DEPEVT_STATUS_TRANSFER_ACTIVE;
+		strcat(str, status ? " (Active)" : " (Not Active)");
+		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		return "FIFO";
+		strcat(str, "FIFO");
+		break;
 	case DWC3_DEPEVT_STREAMEVT:
-		return "Stream";
+		status = event->status;
+
+		switch (status) {
+		case DEPEVT_STREAMEVT_FOUND:
+			sprintf(str + ret, " Stream %d Found",
+					event->parameters);
+			break;
+		case DEPEVT_STREAMEVT_NOTFOUND:
+		default:
+			strcat(str, " Stream Not Found");
+			break;
+		}
+
+		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
-		return "Endpoint Command Complete";
+		strcat(str, "Endpoint Command Complete");
+		break;
+	default:
+		sprintf(str, "UNKNOWN");
 	}
 
-	return "UNKNOWN";
+	return str;
 }
 
 /**
@@ -214,6 +270,46 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 	}
 }
 
+static inline const char *dwc3_decode_event(u32 event)
+{
+	const union dwc3_event evt = (union dwc3_event) event;
+
+	if (evt.type.is_devspec)
+		return dwc3_gadget_event_string(&evt.devt);
+	else
+		return dwc3_ep_event_string(&evt.depevt);
+}
+
+static inline const char *dwc3_ep_cmd_status_string(int status)
+{
+	switch (status) {
+	case -ETIMEDOUT:
+		return "Timed Out";
+	case 0:
+		return "Successful";
+	case DEPEVT_TRANSFER_NO_RESOURCE:
+		return "No Resource";
+	case DEPEVT_TRANSFER_BUS_EXPIRY:
+		return "Bus Expiry";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
+{
+	switch (status) {
+	case -ETIMEDOUT:
+		return "Timed Out";
+	case 0:
+		return "Successful";
+	case 1:
+		return "Error";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 void dwc3_trace(void (*trace)(struct va_format *), const char *fmt, ...);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 51b52a79dfec..fe79d771dee4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -98,8 +98,7 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 
 	trace_dwc3_prepare_trb(dep, trb);
 
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_STARTTRANSFER, &params);
+	ret = dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_STARTTRANSFER, &params);
 	if (ret < 0) {
 		dwc3_trace(trace_dwc3_ep0, "%s STARTTRANSFER failed",
 				dep->name);
@@ -107,9 +106,7 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	}
 
 	dep->flags |= DWC3_EP_BUSY;
-	dep->resource_index = dwc3_gadget_ep_get_transfer_index(dwc,
-			dep->number);
-
+	dep->resource_index = dwc3_gadget_ep_get_transfer_index(dep);
 	dwc->ep0_next_event = DWC3_EP0_COMPLETE;
 
 	return 0;
@@ -499,7 +496,7 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 	case USB_RECIP_ENDPOINT:
 		switch (wValue) {
 		case USB_ENDPOINT_HALT:
-			dep = dwc3_wIndex_to_dep(dwc, wIndex);
+			dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
 			if (!dep)
 				return -EINVAL;
 			if (set == 0 && (dep->flags & DWC3_EP_WEDGE))
@@ -622,8 +619,8 @@ static void dwc3_ep0_set_sel_cmpl(struct usb_ep *ep, struct usb_request *req)
 	struct timing {
 		u8	u1sel;
 		u8	u1pel;
-		u16	u2sel;
-		u16	u2pel;
+		__le16	u2sel;
+		__le16	u2pel;
 	} __packed timing;
 
 	int		ret;
@@ -980,7 +977,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
 		if (ret) {
-			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
+			dwc3_trace(trace_dwc3_ep0, "failed to map request");
 			return;
 		}
 
@@ -1008,7 +1005,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
 		if (ret) {
-			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
+			dwc3_trace(trace_dwc3_ep0, "failed to map request");
 			return;
 		}
 
@@ -1058,7 +1055,7 @@ static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 	cmd |= DWC3_DEPCMD_CMDIOC;
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 }
@@ -1112,11 +1109,8 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	u8			epnum = event->endpoint_number;
-
-	dwc3_trace(trace_dwc3_ep0, "%s while ep%d%s in state '%s'",
-			dwc3_ep_event_string(event->endpoint_event),
-			epnum >> 1, (epnum & 1) ? "in" : "out",
+	dwc3_trace(trace_dwc3_ep0, "%s: state '%s'",
+			dwc3_ep_event_string(event),
 			dwc3_ep0_state_string(dwc->ep0state));
 
 	switch (event->endpoint_event) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 07248ff1be5c..122e64df2f4d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -145,21 +145,29 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	return -ETIMEDOUT;
 }
 
-static void dwc3_ep_inc_enq(struct dwc3_ep *dep)
+/**
+ * dwc3_ep_inc_trb() - Increment a TRB index.
+ * @index - Pointer to the TRB index to increment.
+ *
+ * The index should never point to the link TRB. After incrementing,
+ * if it is point to the link TRB, wrap around to the beginning. The
+ * link TRB is always at the last TRB entry.
+ */
+static void dwc3_ep_inc_trb(u8 *index)
 {
-	dep->trb_enqueue++;
-	dep->trb_enqueue %= DWC3_TRB_NUM;
+	(*index)++;
+	if (*index == (DWC3_TRB_NUM - 1))
+		*index = 0;
 }
 
-static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
+static void dwc3_ep_inc_enq(struct dwc3_ep *dep)
 {
-	dep->trb_dequeue++;
-	dep->trb_dequeue %= DWC3_TRB_NUM;
+	dwc3_ep_inc_trb(&dep->trb_enqueue);
 }
 
-static int dwc3_ep_is_last_trb(unsigned int index)
+static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
 {
-	return index == DWC3_TRB_NUM - 1;
+	dwc3_ep_inc_trb(&dep->trb_dequeue);
 }
 
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
@@ -172,13 +180,6 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		i = 0;
 		do {
 			dwc3_ep_inc_deq(dep);
-			/*
-			 * Skip LINK TRB. We can't use req->trb and check for
-			 * DWC3_TRBCTL_LINK_TRB because it points the TRB we
-			 * just completed (not the LINK TRB).
-			 */
-			if (dwc3_ep_is_last_trb(dep->trb_dequeue))
-				dwc3_ep_inc_deq(dep);
 		} while(++i < req->request.num_mapped_sgs);
 		req->started = false;
 	}
@@ -199,57 +200,54 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
+
+	if (dep->number > 1)
+		pm_runtime_put(dwc->dev);
 }
 
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 {
 	u32		timeout = 500;
+	int		status = 0;
+	int		ret = 0;
 	u32		reg;
 
-	trace_dwc3_gadget_generic_cmd(cmd, param);
-
 	dwc3_writel(dwc->regs, DWC3_DGCMDPAR, param);
 	dwc3_writel(dwc->regs, DWC3_DGCMD, cmd | DWC3_DGCMD_CMDACT);
 
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DGCMD);
 		if (!(reg & DWC3_DGCMD_CMDACT)) {
-			dwc3_trace(trace_dwc3_gadget,
-					"Command Complete --> %d",
-					DWC3_DGCMD_STATUS(reg));
-			if (DWC3_DGCMD_STATUS(reg))
-				return -EINVAL;
-			return 0;
+			status = DWC3_DGCMD_STATUS(reg);
+			if (status)
+				ret = -EINVAL;
+			break;
 		}
+	} while (timeout--);
 
-		/*
-		 * We can't sleep here, because it's also called from
-		 * interrupt context.
-		 */
-		timeout--;
-		if (!timeout) {
-			dwc3_trace(trace_dwc3_gadget,
-					"Command Timed Out");
-			return -ETIMEDOUT;
-		}
-		udelay(1);
-	} while (1);
+	if (!timeout) {
+		ret = -ETIMEDOUT;
+		status = -ETIMEDOUT;
+	}
+
+	trace_dwc3_gadget_generic_cmd(cmd, param, status);
+
+	return ret;
 }
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
 
-int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
-		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
+int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
+		struct dwc3_gadget_ep_cmd_params *params)
 {
-	struct dwc3_ep		*dep = dwc->eps[ep];
+	struct dwc3		*dwc = dep->dwc;
 	u32			timeout = 500;
 	u32			reg;
 
+	int			cmd_status = 0;
 	int			susphy = false;
 	int			ret = -EINVAL;
 
-	trace_dwc3_gadget_ep_cmd(dep, cmd, params);
-
 	/*
 	 * Synopsys Databook 2.60a states, on section 6.3.2.5.[1-8], that if
 	 * we're issuing an endpoint command, we must check if
@@ -258,11 +256,13 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	 * We will also set SUSPHY bit to what it was before returning as stated
 	 * by the same section on Synopsys databook.
 	 */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
-		susphy = true;
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
+			susphy = true;
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
 	}
 
 	if (cmd == DWC3_DEPCMD_STARTTRANSFER) {
@@ -279,26 +279,21 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		}
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
-	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1);
-	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR2(ep), params->param2);
+	dwc3_writel(dep->regs, DWC3_DEPCMDPAR0, params->param0);
+	dwc3_writel(dep->regs, DWC3_DEPCMDPAR1, params->param1);
+	dwc3_writel(dep->regs, DWC3_DEPCMDPAR2, params->param2);
 
-	dwc3_writel(dwc->regs, DWC3_DEPCMD(ep), cmd | DWC3_DEPCMD_CMDACT);
+	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd | DWC3_DEPCMD_CMDACT);
 	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DEPCMD(ep));
+		reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
-			int cmd_status = DWC3_DEPCMD_STATUS(reg);
-
-			dwc3_trace(trace_dwc3_gadget,
-					"Command Complete --> %d",
-					cmd_status);
+			cmd_status = DWC3_DEPCMD_STATUS(reg);
 
 			switch (cmd_status) {
 			case 0:
 				ret = 0;
 				break;
 			case DEPEVT_TRANSFER_NO_RESOURCE:
-				dwc3_trace(trace_dwc3_gadget, "%s: no resource available");
 				ret = -EINVAL;
 				break;
 			case DEPEVT_TRANSFER_BUS_EXPIRY:
@@ -313,7 +308,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 				 * give a hint to the gadget driver that this is
 				 * the case by returning -EAGAIN.
 				 */
-				dwc3_trace(trace_dwc3_gadget, "%s: bus expiry");
 				ret = -EAGAIN;
 				break;
 			default:
@@ -322,21 +316,14 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 
 			break;
 		}
+	} while (--timeout);
 
-		/*
-		 * We can't sleep here, because it is also called from
-		 * interrupt context.
-		 */
-		timeout--;
-		if (!timeout) {
-			dwc3_trace(trace_dwc3_gadget,
-					"Command Timed Out");
-			ret = -ETIMEDOUT;
-			break;
-		}
+	if (timeout == 0) {
+		ret = -ETIMEDOUT;
+		cmd_status = -ETIMEDOUT;
+	}
 
-		udelay(1);
-	} while (1);
+	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
 
 	if (unlikely(susphy)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
@@ -366,7 +353,7 @@ static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
 
 	memset(&params, 0, sizeof(params));
 
-	return dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+	return dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 }
 
 static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
@@ -454,7 +441,7 @@ static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 	memset(&params, 0x00, sizeof(params));
 	cmd = DWC3_DEPCMD_DEPSTARTCFG;
 
-	ret = dwc3_send_gadget_ep_cmd(dwc, 0, cmd, &params);
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	if (ret)
 		return ret;
 
@@ -475,10 +462,14 @@ static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		const struct usb_endpoint_descriptor *desc,
 		const struct usb_ss_ep_comp_descriptor *comp_desc,
-		bool ignore, bool restore)
+		bool modify, bool restore)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 
+	if (dev_WARN_ONCE(dwc->dev, modify && restore,
+					"Can't modify and restore\n"))
+		return -EINVAL;
+
 	memset(&params, 0x00, sizeof(params));
 
 	params.param0 = DWC3_DEPCFG_EP_TYPE(usb_endpoint_type(desc))
@@ -487,30 +478,22 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 	/* Burst size is only needed in SuperSpeed mode */
 	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
 		u32 burst = dep->endpoint.maxburst;
-		u32 nump;
-		u32 reg;
-
-		/* update NumP */
-		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
-		nump = DWC3_DCFG_NUMP(reg);
-		nump = max(nump, burst);
-		reg &= ~DWC3_DCFG_NUMP_MASK;
-		reg |= nump << DWC3_DCFG_NUMP_SHIFT;
-		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
-
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst - 1);
 	}
 
-	if (ignore)
-		params.param0 |= DWC3_DEPCFG_IGN_SEQ_NUM;
-
-	if (restore) {
+	if (modify) {
+		params.param0 |= DWC3_DEPCFG_ACTION_MODIFY;
+	} else if (restore) {
 		params.param0 |= DWC3_DEPCFG_ACTION_RESTORE;
 		params.param2 |= dep->saved_state;
+	} else {
+		params.param0 |= DWC3_DEPCFG_ACTION_INIT;
 	}
 
-	params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN
-		| DWC3_DEPCFG_XFER_NOT_READY_EN;
+	params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN;
+
+	if (dep->number <= 1 || usb_endpoint_xfer_isoc(desc))
+		params.param1 |= DWC3_DEPCFG_XFER_NOT_READY_EN;
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
@@ -541,8 +524,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		dep->interval = 1 << (desc->bInterval - 1);
 	}
 
-	return dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_SETEPCONFIG, &params);
+	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
 static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep)
@@ -553,8 +535,8 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep)
 
 	params.param0 = DWC3_DEPXFERCFG_NUM_XFER_RES(1);
 
-	return dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_SETTRANSFRESOURCE, &params);
+	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETTRANSFRESOURCE,
+			&params);
 }
 
 /**
@@ -567,7 +549,7 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep)
 static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		const struct usb_endpoint_descriptor *desc,
 		const struct usb_ss_ep_comp_descriptor *comp_desc,
-		bool ignore, bool restore)
+		bool modify, bool restore)
 {
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
@@ -581,7 +563,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 			return ret;
 	}
 
-	ret = dwc3_gadget_set_ep_config(dwc, dep, desc, comp_desc, ignore,
+	ret = dwc3_gadget_set_ep_config(dwc, dep, desc, comp_desc, modify,
 			restore);
 	if (ret)
 		return ret;
@@ -600,38 +582,24 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
 		if (usb_endpoint_xfer_control(desc))
-			goto out;
+			return 0;
+
+		/* Initialize the TRB ring */
+		dep->trb_dequeue = 0;
+		dep->trb_enqueue = 0;
+		memset(dep->trb_pool, 0,
+		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
 
 		/* Link TRB. The HWO bit is never reset */
 		trb_st_hw = &dep->trb_pool[0];
 
 		trb_link = &dep->trb_pool[DWC3_TRB_NUM - 1];
-		memset(trb_link, 0, sizeof(*trb_link));
-
 		trb_link->bpl = lower_32_bits(dwc3_trb_dma_offset(dep, trb_st_hw));
 		trb_link->bph = upper_32_bits(dwc3_trb_dma_offset(dep, trb_st_hw));
 		trb_link->ctrl |= DWC3_TRBCTL_LINK_TRB;
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
-out:
-	switch (usb_endpoint_type(desc)) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		/* don't change name */
-		break;
-	case USB_ENDPOINT_XFER_ISOC:
-		strlcat(dep->name, "-isoc", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		strlcat(dep->name, "-bulk", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		strlcat(dep->name, "-int", sizeof(dep->name));
-		break;
-	default:
-		dev_err(dwc->dev, "invalid endpoint transfer type\n");
-	}
-
 	return 0;
 }
 
@@ -640,15 +608,13 @@ static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 
-	if (!list_empty(&dep->started_list)) {
-		dwc3_stop_active_transfer(dwc, dep->number, true);
+	dwc3_stop_active_transfer(dwc, dep->number, true);
 
-		/* - giveback all requests to gadget driver */
-		while (!list_empty(&dep->started_list)) {
-			req = next_request(&dep->started_list);
+	/* - giveback all requests to gadget driver */
+	while (!list_empty(&dep->started_list)) {
+		req = next_request(&dep->started_list);
 
-			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
-		}
+		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
 	}
 
 	while (!list_empty(&dep->pending_list)) {
@@ -689,10 +655,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	dep->type = 0;
 	dep->flags = 0;
 
-	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
-			dep->number >> 1,
-			(dep->number & 1) ? "in" : "out");
-
 	return 0;
 }
 
@@ -784,6 +746,8 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	req->epnum	= dep->number;
 	req->dep	= dep;
 
+	dep->allocated_requests++;
+
 	trace_dwc3_alloc_request(req);
 
 	return &req->request;
@@ -793,7 +757,9 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 		struct usb_request *request)
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
+	struct dwc3_ep			*dep = to_dwc3_ep(ep);
 
+	dep->allocated_requests--;
 	trace_dwc3_free_request(req);
 	kfree(req);
 }
@@ -825,9 +791,6 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	}
 
 	dwc3_ep_inc_enq(dep);
-	/* Skip the LINK-TRB */
-	if (dwc3_ep_is_last_trb(dep->trb_enqueue))
-		dwc3_ep_inc_enq(dep);
 
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
@@ -866,7 +829,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	if (!req->request.no_interrupt && !chain)
 		trb->ctrl |= DWC3_TRB_CTRL_IOC | DWC3_TRB_CTRL_ISP_IMI;
 
-	if (last)
+	if (last && !usb_endpoint_xfer_isoc(dep->endpoint.desc))
 		trb->ctrl |= DWC3_TRB_CTRL_LST;
 
 	if (chain)
@@ -877,137 +840,169 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dep->queued_requests++;
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-/*
- * dwc3_prepare_trbs - setup TRBs from requests
- * @dep: endpoint for which requests are being prepared
- * @starting: true if the endpoint is idle and no requests are queued.
+/**
+ * dwc3_ep_prev_trb() - Returns the previous TRB in the ring
+ * @dep: The endpoint with the TRB ring
+ * @index: The index of the current TRB in the ring
  *
- * The function goes through the requests list and sets up TRBs for the
- * transfers. The function returns once there are no more TRBs available or
- * it runs out of requests.
+ * Returns the TRB prior to the one pointed to by the index. If the
+ * index is 0, we will wrap backwards, skip the link TRB, and return
+ * the one just before that.
  */
-static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
+static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 {
-	struct dwc3_request	*req, *n;
-	u32			trbs_left;
-	unsigned int		last_one = 0;
+	if (!index)
+		index = DWC3_TRB_NUM - 2;
+	else
+		index = dep->trb_enqueue - 1;
 
-	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
+	return &dep->trb_pool[index];
+}
 
-	trbs_left = dep->trb_dequeue - dep->trb_enqueue;
+static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
+{
+	struct dwc3_trb		*tmp;
+	u8			trbs_left;
 
 	/*
-	 * If enqueue & dequeue are equal than it is either full or empty. If we
-	 * are starting to process requests then we are empty. Otherwise we are
-	 * full and don't do anything
+	 * If enqueue & dequeue are equal than it is either full or empty.
+	 *
+	 * One way to know for sure is if the TRB right before us has HWO bit
+	 * set or not. If it has, then we're definitely full and can't fit any
+	 * more transfers in our ring.
 	 */
-	if (!trbs_left) {
-		if (!starting)
-			return;
+	if (dep->trb_enqueue == dep->trb_dequeue) {
+		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
+		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
+			return 0;
 
-		trbs_left = DWC3_TRB_NUM;
+		return DWC3_TRB_NUM - 1;
 	}
 
-	/* The last TRB is a link TRB, not used for xfer */
-	if (trbs_left <= 1)
-		return;
+	trbs_left = dep->trb_dequeue - dep->trb_enqueue;
+	trbs_left &= (DWC3_TRB_NUM - 1);
 
-	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
-		unsigned	length;
-		dma_addr_t	dma;
-		last_one = false;
-
-		if (req->request.num_mapped_sgs > 0) {
-			struct usb_request *request = &req->request;
-			struct scatterlist *sg = request->sg;
-			struct scatterlist *s;
-			int		i;
-
-			for_each_sg(sg, s, request->num_mapped_sgs, i) {
-				unsigned chain = true;
-
-				length = sg_dma_len(s);
-				dma = sg_dma_address(s);
-
-				if (i == (request->num_mapped_sgs - 1) ||
-						sg_is_last(s)) {
-					if (list_empty(&dep->pending_list))
-						last_one = true;
-					chain = false;
-				}
+	if (dep->trb_dequeue < dep->trb_enqueue)
+		trbs_left--;
 
-				trbs_left--;
-				if (!trbs_left)
-					last_one = true;
+	return trbs_left;
+}
 
-				if (last_one)
-					chain = false;
+static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
+		struct dwc3_request *req, unsigned int trbs_left,
+		unsigned int more_coming)
+{
+	struct usb_request *request = &req->request;
+	struct scatterlist *sg = request->sg;
+	struct scatterlist *s;
+	unsigned int	last = false;
+	unsigned int	length;
+	dma_addr_t	dma;
+	int		i;
 
-				dwc3_prepare_one_trb(dep, req, dma, length,
-						last_one, chain, i);
+	for_each_sg(sg, s, request->num_mapped_sgs, i) {
+		unsigned chain = true;
 
-				if (last_one)
-					break;
-			}
+		length = sg_dma_len(s);
+		dma = sg_dma_address(s);
 
-			if (last_one)
-				break;
-		} else {
-			dma = req->request.dma;
-			length = req->request.length;
-			trbs_left--;
+		if (sg_is_last(s)) {
+			if (usb_endpoint_xfer_int(dep->endpoint.desc) ||
+				!more_coming)
+				last = true;
 
-			if (!trbs_left)
-				last_one = 1;
+			chain = false;
+		}
 
-			/* Is this the last request? */
-			if (list_is_last(&req->list, &dep->pending_list))
-				last_one = 1;
+		if (!trbs_left--)
+			last = true;
 
-			dwc3_prepare_one_trb(dep, req, dma, length,
-					last_one, false, 0);
+		if (last)
+			chain = false;
 
-			if (last_one)
-				break;
-		}
+		dwc3_prepare_one_trb(dep, req, dma, length,
+				last, chain, i);
+
+		if (last)
+			break;
 	}
 }
 
-static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
-		int start_new)
+static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
+		struct dwc3_request *req, unsigned int trbs_left,
+		unsigned int more_coming)
+{
+	unsigned int	last = false;
+	unsigned int	length;
+	dma_addr_t	dma;
+
+	dma = req->request.dma;
+	length = req->request.length;
+
+	if (!trbs_left)
+		last = true;
+
+	/* Is this the last request? */
+	if (usb_endpoint_xfer_int(dep->endpoint.desc) || !more_coming)
+		last = true;
+
+	dwc3_prepare_one_trb(dep, req, dma, length,
+			last, false, 0);
+}
+
+/*
+ * dwc3_prepare_trbs - setup TRBs from requests
+ * @dep: endpoint for which requests are being prepared
+ *
+ * The function goes through the requests list and sets up TRBs for the
+ * transfers. The function returns once there are no more TRBs available or
+ * it runs out of requests.
+ */
+static void dwc3_prepare_trbs(struct dwc3_ep *dep)
+{
+	struct dwc3_request	*req, *n;
+	unsigned int		more_coming;
+	u32			trbs_left;
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
+
+	trbs_left = dwc3_calc_trbs_left(dep);
+	if (!trbs_left)
+		return;
+
+	more_coming = dep->allocated_requests - dep->queued_requests;
+
+	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
+		if (req->request.num_mapped_sgs > 0)
+			dwc3_prepare_one_trb_sg(dep, req, trbs_left--,
+					more_coming);
+		else
+			dwc3_prepare_one_trb_linear(dep, req, trbs_left--,
+					more_coming);
+
+		if (!trbs_left)
+			return;
+	}
+}
+
+static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_request		*req;
 	struct dwc3			*dwc = dep->dwc;
+	int				starting;
 	int				ret;
 	u32				cmd;
 
-	if (start_new && (dep->flags & DWC3_EP_BUSY)) {
-		dwc3_trace(trace_dwc3_gadget, "%s: endpoint busy", dep->name);
-		return -EBUSY;
-	}
-
-	/*
-	 * If we are getting here after a short-out-packet we don't enqueue any
-	 * new requests as we try to set the IOC bit only on the last request.
-	 */
-	if (start_new) {
-		if (list_empty(&dep->started_list))
-			dwc3_prepare_trbs(dep, start_new);
-
-		/* req points to the first request which will be sent */
-		req = next_request(&dep->started_list);
-	} else {
-		dwc3_prepare_trbs(dep, start_new);
+	starting = !(dep->flags & DWC3_EP_BUSY);
 
-		/*
-		 * req points to the first request where HWO changed from 0 to 1
-		 */
-		req = next_request(&dep->started_list);
-	}
+	dwc3_prepare_trbs(dep);
+	req = next_request(&dep->started_list);
 	if (!req) {
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
 		return 0;
@@ -1015,16 +1010,17 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 
 	memset(&params, 0, sizeof(params));
 
-	if (start_new) {
+	if (starting) {
 		params.param0 = upper_32_bits(req->trb_dma);
 		params.param1 = lower_32_bits(req->trb_dma);
-		cmd = DWC3_DEPCMD_STARTTRANSFER;
+		cmd = DWC3_DEPCMD_STARTTRANSFER |
+			DWC3_DEPCMD_PARAM(cmd_param);
 	} else {
-		cmd = DWC3_DEPCMD_UPDATETRANSFER;
+		cmd = DWC3_DEPCMD_UPDATETRANSFER |
+			DWC3_DEPCMD_PARAM(dep->resource_index);
 	}
 
-	cmd |= DWC3_DEPCMD_PARAM(cmd_param);
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	if (ret < 0) {
 		/*
 		 * FIXME we need to iterate over the list of requests
@@ -1039,9 +1035,8 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 
 	dep->flags |= DWC3_EP_BUSY;
 
-	if (start_new) {
-		dep->resource_index = dwc3_gadget_ep_get_transfer_index(dwc,
-				dep->number);
+	if (starting) {
+		dep->resource_index = dwc3_gadget_ep_get_transfer_index(dep);
 		WARN_ON_ONCE(!dep->resource_index);
 	}
 
@@ -1064,7 +1059,7 @@ static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 	/* 4 micro frames in the future */
 	uf = cur_uf + dep->interval * 4;
 
-	__dwc3_gadget_kick_transfer(dep, uf, 1);
+	__dwc3_gadget_kick_transfer(dep, uf);
 }
 
 static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
@@ -1085,18 +1080,20 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 	if (!dep->endpoint.desc) {
 		dwc3_trace(trace_dwc3_gadget,
-				"trying to queue request %p to disabled %s\n",
+				"trying to queue request %p to disabled %s",
 				&req->request, dep->endpoint.name);
 		return -ESHUTDOWN;
 	}
 
 	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
 				&req->request, req->dep->name)) {
-		dwc3_trace(trace_dwc3_gadget, "request %p belongs to '%s'\n",
+		dwc3_trace(trace_dwc3_gadget, "request %p belongs to '%s'",
 				&req->request, req->dep->name);
 		return -EINVAL;
 	}
 
+	pm_runtime_get(dwc->dev);
+
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
 	req->direction		= dep->direction;
@@ -1131,9 +1128,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * little bit faster.
 	 */
 	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			!usb_endpoint_xfer_int(dep->endpoint.desc) &&
-			!(dep->flags & DWC3_EP_BUSY)) {
-		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
+			!usb_endpoint_xfer_int(dep->endpoint.desc)) {
+		ret = __dwc3_gadget_kick_transfer(dep, 0);
 		goto out;
 	}
 
@@ -1163,7 +1159,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 			return 0;
 		}
 
-		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
+		ret = __dwc3_gadget_kick_transfer(dep, 0);
 		if (!ret)
 			dep->flags &= ~DWC3_EP_PENDING_REQUEST;
 
@@ -1179,8 +1175,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 			(dep->flags & DWC3_EP_BUSY) &&
 			!(dep->flags & DWC3_EP_MISSED_ISOC)) {
 		WARN_ON_ONCE(!dep->resource_index);
-		ret = __dwc3_gadget_kick_transfer(dep, dep->resource_index,
-				false);
+		ret = __dwc3_gadget_kick_transfer(dep, dep->resource_index);
 		goto out;
 	}
 
@@ -1190,12 +1185,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * handled.
 	 */
 	if (dep->stream_capable)
-		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
+		ret = __dwc3_gadget_kick_transfer(dep, 0);
 
 out:
 	if (ret && ret != -EBUSY)
 		dwc3_trace(trace_dwc3_gadget,
-				"%s: failed to kick transfers\n",
+				"%s: failed to kick transfers",
 				dep->name);
 	if (ret == -EBUSY)
 		ret = 0;
@@ -1215,7 +1210,7 @@ static int __dwc3_gadget_ep_queue_zlp(struct dwc3 *dwc, struct dwc3_ep *dep)
 	struct usb_request		*request;
 	struct usb_ep			*ep = &dep->endpoint;
 
-	dwc3_trace(trace_dwc3_gadget, "queueing ZLP\n");
+	dwc3_trace(trace_dwc3_gadget, "queueing ZLP");
 	request = dwc3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
 	if (!request)
 		return -ENOMEM;
@@ -1319,23 +1314,36 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 	memset(&params, 0x00, sizeof(params));
 
 	if (value) {
-		if (!protocol && ((dep->direction && dep->flags & DWC3_EP_BUSY) ||
-				(!list_empty(&dep->started_list) ||
-				 !list_empty(&dep->pending_list)))) {
+		struct dwc3_trb *trb;
+
+		unsigned transfer_in_flight;
+		unsigned started;
+
+		if (dep->number > 1)
+			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
+		else
+			trb = &dwc->ep0_trb[dep->trb_enqueue];
+
+		transfer_in_flight = trb->ctrl & DWC3_TRB_CTRL_HWO;
+		started = !list_empty(&dep->started_list);
+
+		if (!protocol && ((dep->direction && transfer_in_flight) ||
+				(!dep->direction && started))) {
 			dwc3_trace(trace_dwc3_gadget,
 					"%s: pending request, cannot halt",
 					dep->name);
 			return -EAGAIN;
 		}
 
-		ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_SETSTALL, &params);
+		ret = dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETSTALL,
+				&params);
 		if (ret)
 			dev_err(dwc->dev, "failed to set STALL on %s\n",
 					dep->name);
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
+
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret)
 			dev_err(dwc->dev, "failed to clear STALL on %s\n",
@@ -1425,7 +1433,7 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 {
-	unsigned long		timeout;
+	int			retries;
 
 	int			ret;
 	u32			reg;
@@ -1444,8 +1452,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	if ((speed == DWC3_DSTS_SUPERSPEED) ||
 	    (speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
-		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed\n");
-		return -EINVAL;
+		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed");
+		return 0;
 	}
 
 	link_state = DWC3_DSTS_USBLNKST(reg);
@@ -1456,7 +1464,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 		break;
 	default:
 		dwc3_trace(trace_dwc3_gadget,
-				"can't wakeup from '%s'\n",
+				"can't wakeup from '%s'",
 				dwc3_gadget_link_string(link_state));
 		return -EINVAL;
 	}
@@ -1476,9 +1484,9 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	}
 
 	/* poll until Link State changes to ON */
-	timeout = jiffies + msecs_to_jiffies(100);
+	retries = 20000;
 
-	while (!time_after(jiffies, timeout)) {
+	while (retries--) {
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
 		/* in HS, means ON */
@@ -1525,6 +1533,9 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	u32			reg;
 	u32			timeout = 500;
 
+	if (pm_runtime_suspended(dwc->dev))
+		return 0;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
 		if (dwc->revision <= DWC3_REVISION_187A) {
@@ -1553,18 +1564,11 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
-		if (is_on) {
-			if (!(reg & DWC3_DSTS_DEVCTRLHLT))
-				break;
-		} else {
-			if (reg & DWC3_DSTS_DEVCTRLHLT)
-				break;
-		}
-		timeout--;
-		if (!timeout)
-			return -ETIMEDOUT;
-		udelay(1);
-	} while (1);
+		reg &= DWC3_DSTS_DEVCTRLHLT;
+	} while (--timeout && !(!is_on ^ !reg));
+
+	if (!timeout)
+		return -ETIMEDOUT;
 
 	dwc3_trace(trace_dwc3_gadget, "gadget %s data soft-%s",
 			dwc->gadget_driver
@@ -1616,36 +1620,52 @@ static void dwc3_gadget_disable_irq(struct dwc3 *dwc)
 static irqreturn_t dwc3_interrupt(int irq, void *_dwc);
 static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc);
 
-static int dwc3_gadget_start(struct usb_gadget *g,
-		struct usb_gadget_driver *driver)
+/**
+ * dwc3_gadget_setup_nump - Calculate and initialize NUMP field of DCFG
+ * dwc: pointer to our context structure
+ *
+ * The following looks like complex but it's actually very simple. In order to
+ * calculate the number of packets we can burst at once on OUT transfers, we're
+ * gonna use RxFIFO size.
+ *
+ * To calculate RxFIFO size we need two numbers:
+ * MDWIDTH = size, in bits, of the internal memory bus
+ * RAM2_DEPTH = depth, in MDWIDTH, of internal RAM2 (where RxFIFO sits)
+ *
+ * Given these two numbers, the formula is simple:
+ *
+ * RxFIFO Size = (RAM2_DEPTH * MDWIDTH / 8) - 24 - 16;
+ *
+ * 24 bytes is for 3x SETUP packets
+ * 16 bytes is a clock domain crossing tolerance
+ *
+ * Given RxFIFO Size, NUMP = RxFIFOSize / 1024;
+ */
+static void dwc3_gadget_setup_nump(struct dwc3 *dwc)
 {
-	struct dwc3		*dwc = gadget_to_dwc(g);
-	struct dwc3_ep		*dep;
-	unsigned long		flags;
-	int			ret = 0;
-	int			irq;
-	u32			reg;
+	u32 ram2_depth;
+	u32 mdwidth;
+	u32 nump;
+	u32 reg;
 
-	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
-	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
-			IRQF_SHARED, "dwc3", dwc->ev_buf);
-	if (ret) {
-		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
-				irq, ret);
-		goto err0;
-	}
+	ram2_depth = DWC3_GHWPARAMS7_RAM2_DEPTH(dwc->hwparams.hwparams7);
+	mdwidth = DWC3_GHWPARAMS0_MDWIDTH(dwc->hwparams.hwparams0);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	nump = ((ram2_depth * mdwidth / 8) - 24 - 16) / 1024;
+	nump = min_t(u32, nump, 16);
 
-	if (dwc->gadget_driver) {
-		dev_err(dwc->dev, "%s is already bound to %s\n",
-				dwc->gadget.name,
-				dwc->gadget_driver->driver.name);
-		ret = -EBUSY;
-		goto err1;
-	}
+	/* update NumP */
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &= ~DWC3_DCFG_NUMP_MASK;
+	reg |= nump << DWC3_DCFG_NUMP_SHIFT;
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+}
 
-	dwc->gadget_driver	= driver;
+static int __dwc3_gadget_start(struct dwc3 *dwc)
+{
+	struct dwc3_ep		*dep;
+	int			ret = 0;
+	u32			reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 	reg &= ~(DWC3_DCFG_SPEED_MASK);
@@ -1668,16 +1688,16 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	} else {
 		switch (dwc->maximum_speed) {
 		case USB_SPEED_LOW:
-			reg |= DWC3_DSTS_LOWSPEED;
+			reg |= DWC3_DCFG_LOWSPEED;
 			break;
 		case USB_SPEED_FULL:
-			reg |= DWC3_DSTS_FULLSPEED1;
+			reg |= DWC3_DCFG_FULLSPEED1;
 			break;
 		case USB_SPEED_HIGH:
-			reg |= DWC3_DSTS_HIGHSPEED;
+			reg |= DWC3_DCFG_HIGHSPEED;
 			break;
 		case USB_SPEED_SUPER_PLUS:
-			reg |= DWC3_DSTS_SUPERSPEED_PLUS;
+			reg |= DWC3_DCFG_SUPERSPEED_PLUS;
 			break;
 		default:
 			dev_err(dwc->dev, "invalid dwc->maximum_speed (%d)\n",
@@ -1701,6 +1721,8 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	reg &= ~DWC3_GRXTHRCFG_PKTCNTSEL;
 	dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
 
+	dwc3_gadget_setup_nump(dwc);
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -1709,7 +1731,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 			false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
-		goto err2;
+		goto err0;
 	}
 
 	dep = dwc->eps[1];
@@ -1717,7 +1739,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 			false);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
-		goto err3;
+		goto err1;
 	}
 
 	/* begin to receive SETUP packets */
@@ -1726,43 +1748,79 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 
 	dwc3_gadget_enable_irq(dwc);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
 	return 0;
 
-err3:
-	__dwc3_gadget_ep_disable(dwc->eps[0]);
-
-err2:
-	dwc->gadget_driver = NULL;
-
 err1:
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	free_irq(irq, dwc->ev_buf);
+	__dwc3_gadget_ep_disable(dwc->eps[0]);
 
 err0:
 	return ret;
 }
 
-static int dwc3_gadget_stop(struct usb_gadget *g)
+static int dwc3_gadget_start(struct usb_gadget *g,
+		struct usb_gadget_driver *driver)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
+	int			ret = 0;
 	int			irq;
 
+	irq = dwc->irq_gadget;
+	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
+			IRQF_SHARED, "dwc3", dwc->ev_buf);
+	if (ret) {
+		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+				irq, ret);
+		goto err0;
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->gadget_driver) {
+		dev_err(dwc->dev, "%s is already bound to %s\n",
+				dwc->gadget.name,
+				dwc->gadget_driver->driver.name);
+		ret = -EBUSY;
+		goto err1;
+	}
+
+	dwc->gadget_driver	= driver;
+
+	if (pm_runtime_active(dwc->dev))
+		__dwc3_gadget_start(dwc);
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+
+err1:
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	free_irq(irq, dwc);
+
+err0:
+	return ret;
+}
+
+static void __dwc3_gadget_stop(struct dwc3 *dwc)
+{
+	if (pm_runtime_suspended(dwc->dev))
+		return;
 
 	dwc3_gadget_disable_irq(dwc);
 	__dwc3_gadget_ep_disable(dwc->eps[0]);
 	__dwc3_gadget_ep_disable(dwc->eps[1]);
+}
 
-	dwc->gadget_driver	= NULL;
+static int dwc3_gadget_stop(struct usb_gadget *g)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
 
+	spin_lock_irqsave(&dwc->lock, flags);
+	__dwc3_gadget_stop(dwc);
+	dwc->gadget_driver	= NULL;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
-	free_irq(irq, dwc->ev_buf);
+	free_irq(dwc->irq_gadget, dwc->ev_buf);
 
 	return 0;
 }
@@ -1785,7 +1843,7 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 	u8				i;
 
 	for (i = 0; i < num; i++) {
-		u8 epnum = (i << 1) | (!!direction);
+		u8 epnum = (i << 1) | (direction ? 1 : 0);
 
 		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
 		if (!dep)
@@ -1794,12 +1852,14 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 		dep->dwc = dwc;
 		dep->number = epnum;
 		dep->direction = !!direction;
+		dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
 		dwc->eps[epnum] = dep;
 
 		snprintf(dep->name, sizeof(dep->name), "ep%d%s", epnum >> 1,
 				(epnum & 1) ? "in" : "out");
 
 		dep->endpoint.name = dep->name;
+		spin_lock_init(&dep->lock);
 
 		dwc3_trace(trace_dwc3_gadget, "initializing %s", dep->name);
 
@@ -1895,25 +1955,32 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 
 static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		struct dwc3_request *req, struct dwc3_trb *trb,
-		const struct dwc3_event_depevt *event, int status)
+		const struct dwc3_event_depevt *event, int status,
+		int chain)
 {
 	unsigned int		count;
 	unsigned int		s_pkt = 0;
 	unsigned int		trb_status;
 
+	dep->queued_requests--;
 	trace_dwc3_complete_trb(dep, trb);
 
+	/*
+	 * If we're in the middle of series of chained TRBs and we
+	 * receive a short transfer along the way, DWC3 will skip
+	 * through all TRBs including the last TRB in the chain (the
+	 * where CHN bit is zero. DWC3 will also avoid clearing HWO
+	 * bit and SW has to do it manually.
+	 *
+	 * We're going to do that here to avoid problems of HW trying
+	 * to use bogus TRBs for transfers.
+	 */
+	if (chain && (trb->ctrl & DWC3_TRB_CTRL_HWO))
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+
 	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
-		/*
-		 * We continue despite the error. There is not much we
-		 * can do. If we don't clean it up we loop forever. If
-		 * we skip the TRB then it gets overwritten after a
-		 * while since we use them in a ring buffer. A BUG()
-		 * would help. Lets hope that if this occurs, someone
-		 * fixes the root cause instead of looking away :)
-		 */
-		dev_err(dwc->dev, "%s's TRB (%p) still owned by HW\n",
-				dep->name, trb);
+		return 1;
+
 	count = trb->size & DWC3_TRB_SIZE_MASK;
 
 	if (dep->direction) {
@@ -1921,7 +1988,7 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 			if (trb_status == DWC3_TRBSTS_MISSED_ISOC) {
 				dwc3_trace(trace_dwc3_gadget,
-						"%s: incomplete IN transfer\n",
+						"%s: incomplete IN transfer",
 						dep->name);
 				/*
 				 * If missed isoc occurred and there is
@@ -1952,15 +2019,7 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 			s_pkt = 1;
 	}
 
-	/*
-	 * We assume here we will always receive the entire data block
-	 * which we should receive. Meaning, if we program RX to
-	 * receive 4K but we receive only 2K, we assume that's all we
-	 * should receive and we simply bounce the request back to the
-	 * gadget driver for further processing.
-	 */
-	req->request.actual += req->request.length - count;
-	if (s_pkt)
+	if (s_pkt && !chain)
 		return 1;
 	if ((event->status & DEPEVT_STATUS_LST) &&
 			(trb->ctrl & (DWC3_TRB_CTRL_LST |
@@ -1979,13 +2038,17 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	struct dwc3_trb		*trb;
 	unsigned int		slot;
 	unsigned int		i;
+	int			count = 0;
 	int			ret;
 
 	do {
+		int chain;
+
 		req = next_request(&dep->started_list);
 		if (WARN_ON_ONCE(!req))
 			return 1;
 
+		chain = req->request.num_mapped_sgs > 0;
 		i = 0;
 		do {
 			slot = req->first_trb_index + i;
@@ -1993,19 +2056,36 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 				slot++;
 			slot %= DWC3_TRB_NUM;
 			trb = &dep->trb_pool[slot];
+			count += trb->size & DWC3_TRB_SIZE_MASK;
 
 			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
-					event, status);
+					event, status, chain);
 			if (ret)
 				break;
 		} while (++i < req->request.num_mapped_sgs);
 
+		/*
+		 * We assume here we will always receive the entire data block
+		 * which we should receive. Meaning, if we program RX to
+		 * receive 4K but we receive only 2K, we assume that's all we
+		 * should receive and we simply bounce the request back to the
+		 * gadget driver for further processing.
+		 */
+		req->request.actual += req->request.length - count;
 		dwc3_gadget_giveback(dep, req, status);
 
 		if (ret)
 			break;
 	} while (1);
 
+	/*
+	 * Our endpoint might get disabled by another thread during
+	 * dwc3_gadget_giveback(). If that happens, we're just gonna return 1
+	 * early on so DWC3_EP_BUSY flag gets cleared
+	 */
+	if (!dep->endpoint.desc)
+		return 1;
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 			list_empty(&dep->started_list)) {
 		if (list_empty(&dep->pending_list)) {
@@ -2023,6 +2103,10 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		return 1;
 	}
 
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		if ((event->status & DEPEVT_STATUS_IOC) &&
+				(trb->ctrl & DWC3_TRB_CTRL_IOC))
+			return 0;
 	return 1;
 }
 
@@ -2039,7 +2123,7 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 		status = -ECONNRESET;
 
 	clean_busy = dwc3_cleanup_done_reqs(dwc, dep, event, status);
-	if (clean_busy && (is_xfer_complete ||
+	if (clean_busy && (!dep->endpoint.desc || is_xfer_complete ||
 				usb_endpoint_xfer_isoc(dep->endpoint.desc)))
 		dep->flags &= ~DWC3_EP_BUSY;
 
@@ -2068,10 +2152,18 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 		dwc->u1u2 = 0;
 	}
 
+	/*
+	 * Our endpoint might get disabled by another thread during
+	 * dwc3_gadget_giveback(). If that happens, we're just gonna return 1
+	 * early on so DWC3_EP_BUSY flag gets cleared
+	 */
+	if (!dep->endpoint.desc)
+		return;
+
 	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 		int ret;
 
-		ret = __dwc3_gadget_kick_transfer(dep, 0, is_xfer_complete);
+		ret = __dwc3_gadget_kick_transfer(dep, 0);
 		if (!ret || ret == -EBUSY)
 			return;
 	}
@@ -2099,7 +2191,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 			dwc3_trace(trace_dwc3_gadget,
-					"%s is an Isochronous endpoint\n",
+					"%s is an Isochronous endpoint",
 					dep->name);
 			return;
 		}
@@ -2122,12 +2214,12 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 					dep->name, active ? "Transfer Active"
 					: "Transfer Not Active");
 
-			ret = __dwc3_gadget_kick_transfer(dep, 0, !active);
+			ret = __dwc3_gadget_kick_transfer(dep, 0);
 			if (!ret || ret == -EBUSY)
 				return;
 
 			dwc3_trace(trace_dwc3_gadget,
-					"%s: failed to kick transfers\n",
+					"%s: failed to kick transfers",
 					dep->name);
 		}
 
@@ -2150,11 +2242,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 			/* FALLTHROUGH */
 		default:
 			dwc3_trace(trace_dwc3_gadget,
-					"unable to find suitable stream\n");
+					"unable to find suitable stream");
 		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		dwc3_trace(trace_dwc3_gadget, "%s FIFO Overrun\n", dep->name);
+		dwc3_trace(trace_dwc3_gadget, "%s FIFO Overrun", dep->name);
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
 		dwc3_trace(trace_dwc3_gadget, "Endpoint Command Complete");
@@ -2237,7 +2329,7 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	cmd |= DWC3_DEPCMD_CMDIOC;
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
-	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 	dep->flags &= ~DWC3_EP_BUSY;
@@ -2300,12 +2392,16 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	dwc->gadget.speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
 	usb_gadget_set_state(&dwc->gadget, USB_STATE_NOTATTACHED);
+
+	dwc->connected = false;
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	dwc->connected = true;
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
 	 * would cause a missing Disconnect Event if there's a
@@ -2393,12 +2489,12 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	dwc3_update_ram_clk_sel(dwc, speed);
 
 	switch (speed) {
-	case DWC3_DCFG_SUPERSPEED_PLUS:
+	case DWC3_DSTS_SUPERSPEED_PLUS:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 		dwc->gadget.ep0->maxpacket = 512;
 		dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
 		break;
-	case DWC3_DCFG_SUPERSPEED:
+	case DWC3_DSTS_SUPERSPEED:
 		/*
 		 * WORKAROUND: DWC3 revisions <1.90a have an issue which
 		 * would cause a missing USB3 Reset event.
@@ -2419,18 +2515,18 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		dwc->gadget.ep0->maxpacket = 512;
 		dwc->gadget.speed = USB_SPEED_SUPER;
 		break;
-	case DWC3_DCFG_HIGHSPEED:
+	case DWC3_DSTS_HIGHSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
 		dwc->gadget.ep0->maxpacket = 64;
 		dwc->gadget.speed = USB_SPEED_HIGH;
 		break;
-	case DWC3_DCFG_FULLSPEED2:
-	case DWC3_DCFG_FULLSPEED1:
+	case DWC3_DSTS_FULLSPEED2:
+	case DWC3_DSTS_FULLSPEED1:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
 		dwc->gadget.ep0->maxpacket = 64;
 		dwc->gadget.speed = USB_SPEED_FULL;
 		break;
-	case DWC3_DCFG_LOWSPEED:
+	case DWC3_DSTS_LOWSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
 		dwc->gadget.ep0->maxpacket = 8;
 		dwc->gadget.speed = USB_SPEED_LOW;
@@ -2440,8 +2536,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	/* Enable USB2 LPM Capability */
 
 	if ((dwc->revision > DWC3_REVISION_194A) &&
-	    (speed != DWC3_DCFG_SUPERSPEED) &&
-	    (speed != DWC3_DCFG_SUPERSPEED_PLUS)) {
+	    (speed != DWC3_DSTS_SUPERSPEED) &&
+	    (speed != DWC3_DSTS_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 		reg |= DWC3_DCFG_LPM_CAP;
 		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2610,6 +2706,17 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	dwc->link_state = next;
 }
 
+static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
+					  unsigned int evtinfo)
+{
+	enum dwc3_link_state next = evtinfo & DWC3_LINK_STATE_MASK;
+
+	if (dwc->link_state != next && next == DWC3_LINK_STATE_U3)
+		dwc3_suspend_gadget(dwc);
+
+	dwc->link_state = next;
+}
+
 static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
 		unsigned int evtinfo)
 {
@@ -2661,7 +2768,20 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_EOPF:
-		dwc3_trace(trace_dwc3_gadget, "End of Periodic Frame");
+		/* It changed to be suspend event for version 2.30a and above */
+		if (dwc->revision < DWC3_REVISION_230A) {
+			dwc3_trace(trace_dwc3_gadget, "End of Periodic Frame");
+		} else {
+			dwc3_trace(trace_dwc3_gadget, "U3/L1-L2 Suspend Event");
+
+			/*
+			 * Ignore suspend event until the gadget enters into
+			 * USB_STATE_CONFIGURED state.
+			 */
+			if (dwc->gadget.state >= USB_STATE_CONFIGURED)
+				dwc3_gadget_suspend_interrupt(dwc,
+						event->event_info);
+		}
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
 		dwc3_trace(trace_dwc3_gadget, "Start of Periodic Frame");
@@ -2767,6 +2887,13 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	u32 count;
 	u32 reg;
 
+	if (pm_runtime_suspended(dwc->dev)) {
+		pm_runtime_get(dwc->dev);
+		disable_irq_nosync(dwc->irq_gadget);
+		dwc->pending_events = true;
+		return IRQ_HANDLED;
+	}
+
 	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
 	if (!count)
@@ -2798,7 +2925,33 @@ static irqreturn_t dwc3_interrupt(int irq, void *_evt)
  */
 int dwc3_gadget_init(struct dwc3 *dwc)
 {
-	int					ret;
+	int ret, irq;
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+
+	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq <= 0) {
+		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		if (irq <= 0) {
+			irq = platform_get_irq(dwc3_pdev, 0);
+			if (irq <= 0) {
+				if (irq != -EPROBE_DEFER) {
+					dev_err(dwc->dev,
+						"missing peripheral IRQ\n");
+				}
+				if (!irq)
+					irq = -EINVAL;
+				return irq;
+			}
+		}
+	}
+
+	dwc->irq_gadget = irq;
 
 	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
 			&dwc->ctrl_req_addr, GFP_KERNEL);
@@ -2861,7 +3014,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	 */
 	if (dwc->revision < DWC3_REVISION_220A)
 		dwc3_trace(trace_dwc3_gadget,
-				"Changing max_speed on rev %08x\n",
+				"Changing max_speed on rev %08x",
 				dwc->revision);
 
 	dwc->gadget.max_speed		= dwc->maximum_speed;
@@ -2935,61 +3088,50 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	int ret;
+
 	if (!dwc->gadget_driver)
 		return 0;
 
-	if (dwc->pullups_connected) {
-		dwc3_gadget_disable_irq(dwc);
-		dwc3_gadget_run_stop(dwc, true, true);
-	}
-
-	__dwc3_gadget_ep_disable(dwc->eps[0]);
-	__dwc3_gadget_ep_disable(dwc->eps[1]);
+	ret = dwc3_gadget_run_stop(dwc, false, false);
+	if (ret < 0)
+		return ret;
 
-	dwc->dcfg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	dwc3_disconnect_gadget(dwc);
+	__dwc3_gadget_stop(dwc);
 
 	return 0;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
 {
-	struct dwc3_ep		*dep;
 	int			ret;
 
 	if (!dwc->gadget_driver)
 		return 0;
 
-	/* Start with SuperSpeed Default */
-	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-
-	dep = dwc->eps[0];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
-			false);
-	if (ret)
+	ret = __dwc3_gadget_start(dwc);
+	if (ret < 0)
 		goto err0;
 
-	dep = dwc->eps[1];
-	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
-			false);
-	if (ret)
+	ret = dwc3_gadget_run_stop(dwc, true, false);
+	if (ret < 0)
 		goto err1;
 
-	/* begin to receive SETUP packets */
-	dwc->ep0state = EP0_SETUP_PHASE;
-	dwc3_ep0_out_start(dwc);
-
-	dwc3_writel(dwc->regs, DWC3_DCFG, dwc->dcfg);
-
-	if (dwc->pullups_connected) {
-		dwc3_gadget_enable_irq(dwc);
-		dwc3_gadget_run_stop(dwc, true, false);
-	}
-
 	return 0;
 
 err1:
-	__dwc3_gadget_ep_disable(dwc->eps[0]);
+	__dwc3_gadget_stop(dwc);
 
 err0:
 	return ret;
 }
+
+void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
+{
+	if (dwc->pending_events) {
+		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc->pending_events = false;
+		enable_irq(dwc->irq_gadget);
+	}
+}
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index f21c0fccbebd..e4a1d974a5ae 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -95,11 +95,11 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
  *
  * Caller should take care of locking
  */
-static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3 *dwc, u8 number)
+static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
 {
 	u32			res_id;
 
-	res_id = dwc3_readl(dwc->regs, DWC3_DEPCMD(number));
+	res_id = dwc3_readl(dep->regs, DWC3_DEPCMD);
 
 	return DWC3_DEPCMD_GET_RSC_IDX(res_id);
 }
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 6a79c8e66bbc..a06f9a8fecc7 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -26,7 +26,6 @@
 
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
-	u32 offs = offset - DWC3_GLOBALS_REGS_START;
 	u32 value;
 
 	/*
@@ -34,7 +33,7 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 * space, see dwc3_probe in core.c.
 	 * However, the offsets are given starting from xHCI address space.
 	 */
-	value = readl(base + offs);
+	value = readl(base + offset - DWC3_GLOBALS_REGS_START);
 
 	/*
 	 * When tracing we want to make it easy to find the correct address on
@@ -49,14 +48,12 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 
 static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 {
-	u32 offs = offset - DWC3_GLOBALS_REGS_START;
-
 	/*
 	 * We requested the mem region starting from the Globals address
 	 * space, see dwc3_probe in core.c.
 	 * However, the offsets are given starting from xHCI address space.
 	 */
-	writel(value, base + offs);
+	writel(value, base + offset - DWC3_GLOBALS_REGS_START);
 
 	/*
 	 * When tracing we want to make it easy to find the correct address on
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
deleted file mode 100644
index 8826cca5fc6f..000000000000
--- a/drivers/usb/dwc3/platform_data.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/**
- * platform_data.h - USB DWC3 Platform Data Support
- *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/usb/ch9.h>
-#include <linux/usb/otg.h>
-
-struct dwc3_platform_data {
-	enum usb_device_speed maximum_speed;
-	enum usb_dr_mode dr_mode;
-	bool usb3_lpm_capable;
-
-	unsigned is_utmi_l1_suspend:1;
-	u8 hird_threshold;
-
-	u8 lpm_nyet_threshold;
-
-	unsigned disable_scramble_quirk:1;
-	unsigned has_lpm_erratum:1;
-	unsigned u2exit_lfps_quirk:1;
-	unsigned u2ss_inp3_quirk:1;
-	unsigned req_p1p2p3_quirk:1;
-	unsigned del_p1p2p3_quirk:1;
-	unsigned del_phy_power_chg_quirk:1;
-	unsigned lfps_filter_quirk:1;
-	unsigned rx_detect_poll_quirk:1;
-	unsigned dis_u3_susphy_quirk:1;
-	unsigned dis_u2_susphy_quirk:1;
-	unsigned dis_enblslpm_quirk:1;
-	unsigned dis_rxdet_inp3_quirk:1;
-
-	unsigned tx_de_emphasis_quirk:1;
-	unsigned tx_de_emphasis:2;
-
-	u32 fladj_value;
-
-	const char *hsphy_interface;
-};
-- 
2.53.0

