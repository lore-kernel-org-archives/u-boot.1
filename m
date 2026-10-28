Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B09606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xDbI7u5u;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H8D+UkPh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A38E1810B9;
	Wed, 28 Oct 2026 14:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ojvnmKchB1_v; Wed, 28 Oct 2026 14:46:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC3D580F79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198774;
	b=Dk7DCeWR1grKNwGG9HVoxyMn+Xk3eUImk755c1muD7ANI09Sg+kf4J/BuCdr26J/lpEN
	 uR56DrdyzEiKz8VLjNRtqhXBnFJKkDWmtYiy+sOnAEsU9qREs7b7J2iVZoH+jYpLXxmu1
	 Y9H0UyqSkgQVWoa/4aolIBO6lYraEP9auRGSVCo+RZOdwaSj6U3Q2NopXJeHcG/wxG9gh
	 SfKLap3m+NvsK8sEUE4iIiRgsubJkak5q6HuMEY4OqQkkaUsPNl6+i/lbB7X4271AJmpw
	 YhacbVVaen0A/zyb/CJ6CTAHsBrqofJN+ub0RsecZLCztdXHfWi1LAA7tJFsLkrLSqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198774;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6pYD9pcxcM+40JRK8lCG0sUzq2y0iXVjpJt0zulE7OI=;
	b=KVAnxba4dA2kfK5fp55HpXPajWbYkZDF4KCnH+hKG/ecPx4C2SAVbhsMt+2wX05oReoO
	 Vi8gMYUQEsAYb6bwzoL2G7ILFA1YaQmBRVk0ChqO5utm1fBFd0jOz1oxoG2XNwQxV0gP7
	 in+VPBMmB4n1xptXEXUy0zsjMbyVmqodR+RfsoFhBvgTX+VzvhSGH7RGTknGlzl/S+aiR
	 uGMsN6CHIf7N39xpNOJHNrltM9IKW4sOuBbGtJgXUFAkYp1q+hca200EP49nibO8Mle+8
	 Y+m6g1coaF/K6bwLI9hKxwjtwoQXCGmhNk3bnlkXNXxxoCdGSimN/gtRtxns0tS0BuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H8D+UkPh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198774;
	bh=6pYD9pcxcM+40JRK8lCG0sUzq2y0iXVjpJt0zulE7OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xDbI7u5uCNqyXQ5m6u5T0oWV7KbYoAGD/zDfZh3DxRMZcuVE2qnLHTSq7azDnS940
	 SUE6eBEqiOuhgzPHqd5cf9lIketMVQb5b3KiV8r292fllh0rT2Orh/Mx18BUMEwSv7
	 /VCn9Khsjx/Vk5yWVOSNwtg2DLuj2EmP/ZU1flXxYqsCAU0iie7AOqpzbo7Fgg2MdL
	 j6COKR/eavFwLjjVNbTQGHfojVy+BIvTWFnG5+iwy9k1AqPFuT3Y+a9QEPxZtNfu6k
	 LQCoybRLa/flU4h3itd+S4gDemy/HKj1KBJv5+E+TcuIloHVlT3Yq9jGoiZc8AMqmr
	 9B20ud8SMhjvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC3D580F79;
	Wed, 28 Oct 2026 14:46:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 75EBA380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6796E80BDB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZPr8nm4yzVEj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:10:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C64C80BDF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196656;
 b=jseoRAxBHSp6w8TSA3x9b/uthMqbnCYHXYZ6ciEYOYptuGtowzKNK7x4cpOfXkm+Qui4
 dqzM/1JMNKOMAptOHXj3igRMG31UT3J11lFQo818a/BS4TkbSbWRjx0cOTi0ByRSJiLRl
 a8P9ZNg5kEbz9xv9988gp4ex3BlbdER536Vc8SoDJs/kXlPtVnRuXH48Ag/bz26w1l8ye
 HjOzYNNdc2hCadhhQQkHmMJ+ZabmiZmRPHyU/4Qlgm3Spzc5pI3Cvrd4yBnta4LO6hmj+
 oyUkZBss5gY/ZHfyXGVD7C3qHX9m+SswD7JEXKSIMFZW1ej0m5wPiBxQ0RixaPx+1GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6pYD9pcxcM+40JRK8lCG0sUzq2y0iXVjpJt0zulE7OI=;
 b=nH4oiDrdhJRB9o0FE1r/muKI0R16mnHaeBB2WtCX1BJpSvr/rBlLj3VHOl3AW4xlS8Y+
 TaOKWikGII/TuBN8XQPTRyHcQ/73yco0I4wNQvqhfNB+fdtPG8SzHRWcG3FIAu40H4V0z
 Iw6T/1a/eiK0nqq0IondfS4i6G4BqJusofRpFvW2laUEdxoBufhLcz3kdRQUYoL2Mcmu2
 0HJ0VYC0DFnWqQtN0awO/px4dJeL5ivKYzuyxbdXE1B1EhAsZvKAub2mF+nBnPUpDhTH7
 lSNDW6/n2EIjKBEx/U61yWBTXMFLz561R866Jlh53LRNfoUXWUH8tewFJwIrXIK5XxQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=H8D+UkPh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=H8D+UkPh
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C64C80BDF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:55 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c33700b6435so16123166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196653; x=1793801453;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6pYD9pcxcM+40JRK8lCG0sUzq2y0iXVjpJt0zulE7OI=;
 b=H8D+UkPhwtO8wc2N0GZhWpgBQBaUIyT93mkB5O6z+YBU9xinY0/f2/Da+sJHmFrSHx
 wCsRRtAXjGQrTEek1sR/jkazfyuAtX/m9Wi2Ku1x3d3L5vCgdLeIt4ib/23oJ7bZnjDy
 wqWNCUfDBHltiC06qiwxvAj+R9q/jclfyCa+gDqG5Jt61bzZDxavbvN5JgcBkWRwVAIZ
 l6IG1pHV/QkteXV0Lh3qwLRJDjV/xWfH6funWXRYhX9h54gwXs8TAetGlI2xQntnEwJJ
 cFtRuulurNxKB/b9T4Ba+eeViiy7Z2vkAXQj5jEwwzIKDFpXhvpvJWTRmUVUmVSzXxu0
 Dj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196653; x=1793801453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6pYD9pcxcM+40JRK8lCG0sUzq2y0iXVjpJt0zulE7OI=;
 b=QUOUsLFfXOy/rnl8HQZyRd1EYTWMeh9m/h52i4ayYaZ6r8WQyU0eBiP6JRfo2guAO8
 wwsj4M9674/kfRCeIT6lTIoQw+i/nzTOwI43c6ERTqZbdP+3Z3JaAH/A53F99lGWaIsF
 zsx6w5vGtbmD+w6jSi4IeXi6x3ikZ2rMnrZR68xyHc8QngXSNQwjaOpaZf/kMn6YAot8
 zBAYAQ5FVrEye65w1qa+01Ies3UScha4yBGRjTefkkjGGKecNmul6WAD1YmNBEuFpUe5
 5LVTqJ5m/C6pfDUMbOrtKnQY1iaozmxjQfDMrvhGL2yVI/8hClxv731iMafL3C55XtWV
 cU0g==
X-Gm-Message-State: AFq9FYK9duRyJdLkTP4jABEjbIRjI8lMAhKX5ikVds4EOX4HL5/D4nri
 xF9wCAotiZIO5U2RquJXdF3GkP4YRokLCKye7MKNXk++Faiui7OYS+aN9zleoxj9gJvBV+8KSHO
 5fonW
X-Gm-Gg: AYBFou1rNdh2Rk2T7Rq5m0wERYRxlmrI2cYFj0mGK8Yg9b9FlmhZ+9eHd1PwezcRR2X
 ASkT/3j1UkdjaVbGikA43Tj0VhYsy7ccUFMWhvyROpl/C1HcgOEFBB3krAhwpxhr6PEZhiDot+m
 mBspC9uMJIN+vaf4LfyvKrJy7bE1Ab2V1lTeCdeSx4b/3uuLnzylMp5ZTZDxllMwLwIhfb5su2R
 5+tGFEzG5HioRmyfnSvXvgsx+sjjaJa7TTsXMpZ9ZUebT+ISVb6mzxbMxpTZjIIgIz0aVGbgIGU
 1eIASkMc/Gh0BCodfyRqNB0LIFlbDLbeSIjqSWe2/IAGDZfchz24ugFYG3M3lw4oDIiVy0Gb46P
 +SyjtpVucXffospjh3X8F9ggNAUmtMaC56opTEnlV6R31/lj3oBoHAJ4SZYGbNKO/07avcIVUzh
 RvU+KdFaw/ertfmHrShxl4peXT+DtznFlU4uTDbWGi7BYxDp6xAMdTX9MgYjmXfxyDJuK0e3Vxp
 CmzpVhZj9axUFUJN+3/Kvh8P28Qhc4TZA1tYJJKm3zpJd+je/0InSkqs/if+9qBpOIOQ/cQGWvJ
 L2+sdrg4s7XlKWqARJ5rn8WBIVamNz6tLddl8EUrNoKTpvlB4EOnnxqYK4MZSz6wjfunQJoW5rF
 f+bC3slZ+nw==
X-Received: by 2002:a17:906:5154:20b0:c49:ce7c:8a60 with SMTP id
 a640c23a62f3a-c49ce7c8bb6mr44433666b.2.1793196652908; 
 Wed, 28 Oct 2026 07:10:52 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:10:52 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 11/63] usb: dwc3: import from kernel v4.7
Date: Wed, 28 Oct 2026 15:08:37 +0100
Message-ID: <20261028140930.3025368-12-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.6 to v4.7.

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

List of commits: git log --oneline v4.6..v4.7
Commits imported:
50c763f8c1ba usb: dwc3: Set the ClearPendIN bit on Clear Stall EP command
973986126a41 usb: dwc3: gadget: fix mask and shift order in DWC3_DCFG_NUMP()
2a58f9c12bb3 usb: dwc3: gadget: disable automatic calculation of ACK TP NUMP
676e34974481 usb: dwc3: gadget: update DCFG.NumP to max burst size
7b9cc7a2b101 usb: dwc3: gadget: give better command return code
ae4114137607 usb: dwc3: ep0: sanity check test mode selector
b058f3e8a399 usb: dwc3: core: add helper to extract trb type
cf6d867d3b57 usb: dwc3: core: add fifo space helper
4e9f311833a9 usb: dwc3: make dwc3_debugfs_init return value be void
8e7046b71dae usb: dwc3: gadget: don't interrupt when chained
052ba52efa17 usb: dwc3: gadget: remove newline from trace
36b68aae8e39 usb: dwc3: gadget: use link TRB for all endpoint types
4faf75504a7d usb: dwc3: gadget: move % operation to increment helpers
ef966b9d3353 usb: dwc3: gadget: add trb enqueue/dequeue helpers
70fdb273db37 usb: dwc3: get rid of DWC3_TRB_MASK
c28f82595dde usb: dwc3: switch trb enqueue/dequeue and first_trb_index to u8
5ef68c56e169 usb: dwc3: core: document struct dwc3_request
53fd88189e08 usb: dwc3: gadget: rename busy/free_slot to trb_enqueue/dequeue
e58dd357741b usb: dwc3: add disable receiver detection in P3 quirk
c36d8e947a56 usb: dwc3: gadget: put link to U0 before Start Transfer
218ef7b647e3 usb: dwc3: gadget: extract unlocked dwc3_gadget_wakeup()
2b0f11df84bb usb: dwc3: gadget: clear SUSPHY bit before ep cmds
c0ca324d09a0 usb: dwc3: gadget: combine return points into a single one
dea520a4a283 usb: dwc3: gadget: pass ev_buff as cookie to irq handler
696c8b128220 usb: dwc3: drop ev_buffs array
660e9bde74d6 usb: dwc3: remove num_event_buffers
aa3342c8bb61 usb: dwc3: better name for our request management lists
8495036e986b usb: dwc3: increase maximum number of TRBs per endpoint
ca4d44ea2a91 usb: dwc3: gadget: always enable CSP
bc5081617fae usb: dwc3: drop FIFO resizing logic

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c          | 118 ++++----
 drivers/usb/dwc3/core.h          |  85 ++++--
 drivers/usb/dwc3/debug.h         |   6 +-
 drivers/usb/dwc3/ep0.c           |  43 +--
 drivers/usb/dwc3/gadget.c        | 457 +++++++++++++++----------------
 drivers/usb/dwc3/gadget.h        |   6 +-
 drivers/usb/dwc3/platform_data.h |   2 +-
 7 files changed, 374 insertions(+), 343 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 34277ced26bd..a590cd225bb7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -60,6 +60,20 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
+u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
+{
+	struct dwc3		*dwc = dep->dwc;
+	u32			reg;
+
+	dwc3_writel(dwc->regs, DWC3_GDBGFIFOSPACE,
+			DWC3_GDBGFIFOSPACE_NUM(dep->number) |
+			DWC3_GDBGFIFOSPACE_TYPE(type));
+
+	reg = dwc3_readl(dwc->regs, DWC3_GDBGFIFOSPACE);
+
+	return DWC3_GDBGFIFOSPACE_SPACE_AVAILABLE(reg);
+}
+
 /**
  * dwc3_core_soft_reset - Issues core soft reset and PHY reset
  * @dwc: pointer to our context structure
@@ -203,13 +217,10 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 static void dwc3_free_event_buffers(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
-	int i;
 
-	for (i = 0; i < dwc->num_event_buffers; i++) {
-		evt = dwc->ev_buffs[i];
-		if (evt)
-			dwc3_free_one_event_buffer(dwc, evt);
-	}
+	evt = dwc->ev_buf;
+	if (evt)
+		dwc3_free_one_event_buffer(dwc, evt);
 }
 
 /**
@@ -222,27 +233,14 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  */
 static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 {
-	int			num;
-	int			i;
-
-	num = DWC3_NUM_INT(dwc->hwparams.hwparams1);
-	dwc->num_event_buffers = num;
-
-	dwc->ev_buffs = devm_kzalloc(dwc->dev, sizeof(*dwc->ev_buffs) * num,
-			GFP_KERNEL);
-	if (!dwc->ev_buffs)
-		return -ENOMEM;
-
-	for (i = 0; i < num; i++) {
-		struct dwc3_event_buffer	*evt;
+	struct dwc3_event_buffer *evt;
 
-		evt = dwc3_alloc_one_event_buffer(dwc, length);
-		if (IS_ERR(evt)) {
-			dev_err(dwc->dev, "can't allocate event buffer\n");
-			return PTR_ERR(evt);
-		}
-		dwc->ev_buffs[i] = evt;
+	evt = dwc3_alloc_one_event_buffer(dwc, length);
+	if (IS_ERR(evt)) {
+		dev_err(dwc->dev, "can't allocate event buffer\n");
+		return PTR_ERR(evt);
 	}
+	dwc->ev_buf = evt;
 
 	return 0;
 }
@@ -256,25 +254,22 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
-	int				n;
 
-	for (n = 0; n < dwc->num_event_buffers; n++) {
-		evt = dwc->ev_buffs[n];
-		dwc3_trace(trace_dwc3_core,
-				"Event buf %p dma %08llx length %d\n",
-				evt->buf, (unsigned long long) evt->dma,
-				evt->length);
-
-		evt->lpos = 0;
-
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(n),
-				lower_32_bits(evt->dma));
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(n),
-				upper_32_bits(evt->dma));
-		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(n),
-				DWC3_GEVNTSIZ_SIZE(evt->length));
-		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(n), 0);
-	}
+	evt = dwc->ev_buf;
+	dwc3_trace(trace_dwc3_core,
+			"Event buf %p dma %08llx length %d\n",
+			evt->buf, (unsigned long long) evt->dma,
+			evt->length);
+
+	evt->lpos = 0;
+
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
+			lower_32_bits(evt->dma));
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
+			upper_32_bits(evt->dma));
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+			DWC3_GEVNTSIZ_SIZE(evt->length));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 
 	return 0;
 }
@@ -282,19 +277,16 @@ static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 static void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
-	int				n;
 
-	for (n = 0; n < dwc->num_event_buffers; n++) {
-		evt = dwc->ev_buffs[n];
+	evt = dwc->ev_buf;
 
-		evt->lpos = 0;
+	evt->lpos = 0;
 
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(n), 0);
-		dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(n), 0);
-		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(n), DWC3_GEVNTSIZ_INTMASK
-				| DWC3_GEVNTSIZ_SIZE(0));
-		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(n), 0);
-	}
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0), 0);
+	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0), 0);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_INTMASK
+			| DWC3_GEVNTSIZ_SIZE(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 }
 
 static int dwc3_alloc_scratch_buffers(struct dwc3 *dwc)
@@ -434,6 +426,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
+	if (dwc->dis_rxdet_inp3_quirk)
+		reg |= DWC3_GUSB3PIPECTL_DISRXDETINP3;
+
 	if (dwc->req_p1p2p3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
 
@@ -882,9 +877,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->usb3_lpm_capable = device_property_read_bool(dev,
 				"snps,usb3_lpm_capable");
 
-	dwc->needs_fifo_resize = device_property_read_bool(dev,
-				"tx-fifo-resize");
-
 	dwc->disable_scramble_quirk = device_property_read_bool(dev,
 				"snps,disable_scramble_quirk");
 	dwc->u2exit_lfps_quirk = device_property_read_bool(dev,
@@ -907,6 +899,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,dis_u2_susphy_quirk");
 	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
 				"snps,dis_enblslpm_quirk");
+	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
+				"snps,dis_rxdet_inp3_quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -926,7 +920,6 @@ static int dwc3_probe(struct platform_device *pdev)
 		if (pdata->hird_threshold)
 			hird_threshold = pdata->hird_threshold;
 
-		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
 		dwc->usb3_lpm_capable = pdata->usb3_lpm_capable;
 		dwc->dr_mode = pdata->dr_mode;
 
@@ -941,6 +934,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->dis_u3_susphy_quirk = pdata->dis_u3_susphy_quirk;
 		dwc->dis_u2_susphy_quirk = pdata->dis_u2_susphy_quirk;
 		dwc->dis_enblslpm_quirk = pdata->dis_enblslpm_quirk;
+		dwc->dis_rxdet_inp3_quirk = pdata->dis_rxdet_inp3_quirk;
 
 		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
 		if (pdata->tx_de_emphasis)
@@ -1050,19 +1044,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret)
 		goto err5;
 
-	ret = dwc3_debugfs_init(dwc);
-	if (ret) {
-		dev_err(dev, "failed to initialize debugfs\n");
-		goto err6;
-	}
-
+	dwc3_debugfs_init(dwc);
 	pm_runtime_allow(dev);
 
 	return 0;
 
-err6:
-	dwc3_core_exit_mode(dwc);
-
 err5:
 	dwc3_event_buffers_cleanup(dwc);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6254b2ff9080..654050684f4f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -152,6 +152,24 @@
 
 /* Bit fields */
 
+/* Global Debug Queue/FIFO Space Available Register */
+#define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
+#define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
+#define DWC3_GDBGFIFOSPACE_SPACE_AVAILABLE(n) (((n) >> 16) & 0xffff)
+
+#define DWC3_TXFIFOQ		1
+#define DWC3_RXFIFOQ		3
+#define DWC3_TXREQQ		5
+#define DWC3_RXREQQ		7
+#define DWC3_RXINFOQ		9
+#define DWC3_DESCFETCHQ		13
+#define DWC3_EVENTQ		15
+
+/* Global RX Threshold Configuration Register */
+#define DWC3_GRXTHRCFG_MAXRXBURSTSIZE(n) (((n) & 0x1f) << 19)
+#define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
+#define DWC3_GRXTHRCFG_PKTCNTSEL (1 << 29)
+
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
 #define DWC3_GCTL_U2RSTECN	(1 << 16)
@@ -193,6 +211,7 @@
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
+#define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
 #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
@@ -257,6 +276,9 @@
 #define DWC3_DCFG_LOWSPEED	(2 << 0)
 #define DWC3_DCFG_FULLSPEED1	(3 << 0)
 
+#define DWC3_DCFG_NUMP_SHIFT	17
+#define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
+#define DWC3_DCFG_NUMP_MASK	(0x1f << DWC3_DCFG_NUMP_SHIFT)
 #define DWC3_DCFG_LPM_CAP	(1 << 22)
 
 /* Device Control Register */
@@ -380,6 +402,7 @@
 #define DWC3_DEPCMD_GET_RSC_IDX(x)	(((x) >> DWC3_DEPCMD_PARAM_SHIFT) & 0x7f)
 #define DWC3_DEPCMD_STATUS(x)		(((x) >> 12) & 0x0F)
 #define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
+#define DWC3_DEPCMD_CLEARPENDIN		(1 << 11)
 #define DWC3_DEPCMD_CMDACT		(1 << 10)
 #define DWC3_DEPCMD_CMDIOC		(1 << 8)
 
@@ -438,18 +461,17 @@ struct dwc3_event_buffer {
 #define DWC3_EP_DIRECTION_TX	true
 #define DWC3_EP_DIRECTION_RX	false
 
-#define DWC3_TRB_NUM		32
-#define DWC3_TRB_MASK		(DWC3_TRB_NUM - 1)
+#define DWC3_TRB_NUM		256
 
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
- * @request_list: list of requests for this endpoint
- * @req_queued: list of requests on this ep which have TRBs setup
+ * @pending_list: list of pending requests for this endpoint
+ * @started_list: list of started requests on this endpoint
  * @trb_pool: array of transaction buffers
  * @trb_pool_dma: dma address of @trb_pool
- * @free_slot: next slot which is going to be used
- * @busy_slot: first slot which is owned by HW
+ * @trb_enqueue: enqueue 'pointer' into TRB array
+ * @trb_dequeue: dequeue 'pointer' into TRB array
  * @desc: usb_endpoint_descriptor pointer
  * @dwc: pointer to DWC controller
  * @saved_state: ep state saved during hibernation
@@ -464,13 +486,11 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
-	struct list_head	request_list;
-	struct list_head	req_queued;
+	struct list_head	pending_list;
+	struct list_head	started_list;
 
 	struct dwc3_trb		*trb_pool;
 	dma_addr_t		trb_pool_dma;
-	u32			free_slot;
-	u32			busy_slot;
 	const struct usb_ss_ep_comp_descriptor *comp_desc;
 	struct dwc3		*dwc;
 
@@ -486,6 +506,18 @@ struct dwc3_ep {
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		(1 << 31)
 
+	/*
+	 * IMPORTANT: we *know* we have 256 TRBs in our @trb_pool, so we will
+	 * use a u8 type here. If anybody decides to increase number of TRBs to
+	 * anything larger than 256 - I can't see why people would want to do
+	 * this though - then this type needs to be changed.
+	 *
+	 * By using u8 types we ensure that our % operator when incrementing
+	 * enqueue and dequeue get optimized away by the compiler.
+	 */
+	u8			trb_enqueue;
+	u8			trb_dequeue;
+
 	u8			number;
 	u8			type;
 	u8			resource_index;
@@ -557,6 +589,7 @@ enum dwc3_link_state {
 #define DWC3_TRB_CTRL_IOC		(1 << 11)
 #define DWC3_TRB_CTRL_SID_SOFN(n)	(((n) & 0xffff) << 14)
 
+#define DWC3_TRBCTL_TYPE(n)		((n) & (0x3f << 4))
 #define DWC3_TRBCTL_NORMAL		DWC3_TRB_CTRL_TRBCTL(1)
 #define DWC3_TRBCTL_CONTROL_SETUP	DWC3_TRB_CTRL_TRBCTL(2)
 #define DWC3_TRBCTL_CONTROL_STATUS2	DWC3_TRB_CTRL_TRBCTL(3)
@@ -623,19 +656,32 @@ struct dwc3_hwparams {
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
+/**
+ * struct dwc3_request - representation of a transfer request
+ * @request: struct usb_request to be transferred
+ * @list: a list_head used for request queueing
+ * @dep: struct dwc3_ep owning this request
+ * @first_trb_index: index to first trb used by this request
+ * @epnum: endpoint number to which this request refers
+ * @trb: pointer to struct dwc3_trb
+ * @trb_dma: DMA address of @trb
+ * @direction: IN or OUT direction flag
+ * @mapped: true when request has been dma-mapped
+ * @queued: true when request has been queued to HW
+ */
 struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
-	u32			start_slot;
 
+	u8			first_trb_index;
 	u8			epnum;
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
 	unsigned		direction:1;
 	unsigned		mapped:1;
-	unsigned		queued:1;
+	unsigned		started:1;
 };
 
 /*
@@ -667,7 +713,6 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @nr_scratch: number of scratch buffers
- * @num_event_buffers: calculated number of event buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
@@ -709,9 +754,7 @@ struct dwc3_scratchpad_array {
  * 	0	- utmi_sleep_n
  * 	1	- utmi_l1_suspend_n
  * @is_fpga: true when we are using the FPGA board
- * @needs_fifo_resize: not all users might want fifo resizing, flag it
  * @pullups_connected: true when Run/Stop bit is set
- * @resize_fifos: tells us it's ok to reconfigure our TxFIFO sizes.
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @start_config_issued: true when StartConfig command has been issued
  * @three_stage_setup: set if we perform a three phase setup
@@ -756,7 +799,7 @@ struct dwc3 {
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
 
-	struct dwc3_event_buffer **ev_buffs;
+	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
 	struct usb_gadget	gadget;
@@ -780,7 +823,6 @@ struct dwc3 {
 	u32			gctl;
 
 	u32			nr_scratch;
-	u32			num_event_buffers;
 	u32			u1u2;
 	u32			maximum_speed;
 
@@ -855,9 +897,7 @@ struct dwc3 {
 	unsigned		has_lpm_erratum:1;
 	unsigned		is_utmi_l1_suspend:1;
 	unsigned		is_fpga:1;
-	unsigned		needs_fifo_resize:1;
 	unsigned		pullups_connected:1;
-	unsigned		resize_fifos:1;
 	unsigned		setup_packet_pending:1;
 	unsigned		three_stage_setup:1;
 	unsigned		usb3_lpm_capable:1;
@@ -873,6 +913,7 @@ struct dwc3 {
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
+	unsigned		dis_rxdet_inp3_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
@@ -938,6 +979,10 @@ struct dwc3_event_depevt {
 #define DEPEVT_STATUS_CONTROL_DATA	1
 #define DEPEVT_STATUS_CONTROL_STATUS	2
 
+/* In response to Start Transfer */
+#define DEPEVT_TRANSFER_NO_RESOURCE	1
+#define DEPEVT_TRANSFER_BUS_EXPIRY	2
+
 	u32	parameters:16;
 } __packed;
 
@@ -1025,7 +1070,7 @@ struct dwc3_gadget_ep_cmd_params {
 
 /* prototypes */
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
-int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
+u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
 /* check whether we are on the DWC_usb31 core */
 static inline bool dwc3_is_usb31(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 07fbc2d94fd4..71e318025964 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -217,11 +217,11 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 void dwc3_trace(void (*trace)(struct va_format *), const char *fmt, ...);
 
 #ifdef CONFIG_DEBUG_FS
-extern int dwc3_debugfs_init(struct dwc3 *);
+extern void dwc3_debugfs_init(struct dwc3 *);
 extern void dwc3_debugfs_exit(struct dwc3 *);
 #else
-static inline int dwc3_debugfs_init(struct dwc3 *d)
-{  return 0;  }
+static inline void dwc3_debugfs_init(struct dwc3 *d)
+{  }
 static inline void dwc3_debugfs_exit(struct dwc3 *d)
 {  }
 #endif
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index eca2e6d8e041..51b52a79dfec 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -70,10 +70,10 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 		return 0;
 	}
 
-	trb = &dwc->ep0_trb[dep->free_slot];
+	trb = &dwc->ep0_trb[dep->trb_enqueue];
 
 	if (chain)
-		dep->free_slot++;
+		dep->trb_enqueue++;
 
 	trb->bpl = lower_32_bits(buf_dma);
 	trb->bph = upper_32_bits(buf_dma);
@@ -124,7 +124,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	req->request.status	= -EINPROGRESS;
 	req->epnum		= dep->number;
 
-	list_add_tail(&req->list, &dep->request_list);
+	list_add_tail(&req->list, &dep->pending_list);
 
 	/*
 	 * Gadget driver might not be quick enough to queue a request
@@ -240,7 +240,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	}
 
 	/* we share one TRB for ep0/1 */
-	if (!list_empty(&dep->request_list)) {
+	if (!list_empty(&dep->pending_list)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -272,10 +272,10 @@ static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	dep->flags = DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
-	if (!list_empty(&dep->request_list)) {
+	if (!list_empty(&dep->pending_list)) {
 		struct dwc3_request	*req;
 
-		req = next_request(&dep->request_list);
+		req = next_request(&dep->pending_list);
 		dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
@@ -463,8 +463,18 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 			if (!set)
 				return -EINVAL;
 
-			dwc->test_mode_nr = wIndex >> 8;
-			dwc->test_mode = true;
+			switch (wIndex >> 8) {
+			case TEST_J:
+			case TEST_K:
+			case TEST_SE0_NAK:
+			case TEST_PACKET:
+			case TEST_FORCE_EN:
+				dwc->test_mode_nr = wIndex >> 8;
+				dwc->test_mode = true;
+				break;
+			default:
+				return -EINVAL;
+			}
 			break;
 		default:
 			return -EINVAL;
@@ -586,9 +596,6 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 			reg |= (DWC3_DCTL_ACCEPTU1ENA | DWC3_DCTL_ACCEPTU2ENA);
 			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-
-			dwc->resize_fifos = true;
-			dwc3_trace(trace_dwc3_ep0, "resize FIFOs flag SET");
 		}
 		break;
 
@@ -809,7 +816,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	trace_dwc3_complete_trb(ep0, trb);
 
-	r = next_request(&ep0->request_list);
+	r = next_request(&ep0->pending_list);
 	if (!r)
 		return;
 
@@ -848,7 +855,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 			trb++;
 			length = trb->size & DWC3_TRB_SIZE_MASK;
 
-			ep0->free_slot = 0;
+			ep0->trb_enqueue = 0;
 		}
 
 		transfer_size = roundup((ur->length - transfer_size),
@@ -897,8 +904,8 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 
 	trace_dwc3_complete_trb(dep, trb);
 
-	if (!list_empty(&dep->request_list)) {
-		r = next_request(&dep->request_list);
+	if (!list_empty(&dep->pending_list)) {
+		r = next_request(&dep->pending_list);
 
 		dwc3_gadget_giveback(dep, r, 0);
 	}
@@ -1027,12 +1034,6 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
-	if (dwc->resize_fifos) {
-		dwc3_trace(trace_dwc3_ep0, "Resizing FIFOs");
-		dwc3_gadget_resize_tx_fifos(dwc);
-		dwc->resize_fifos = 0;
-	}
-
 	WARN_ON(dwc3_ep0_start_control_status(dep));
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8e4a1b195e9b..07248ff1be5c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -145,90 +145,21 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	return -ETIMEDOUT;
 }
 
-/**
- * dwc3_gadget_resize_tx_fifos - reallocate fifo spaces for current use-case
- * @dwc: pointer to our context structure
- *
- * This function will a best effort FIFO allocation in order
- * to improve FIFO usage and throughput, while still allowing
- * us to enable as many endpoints as possible.
- *
- * Keep in mind that this operation will be highly dependent
- * on the configured size for RAM1 - which contains TxFifo -,
- * the amount of endpoints enabled on coreConsultant tool, and
- * the width of the Master Bus.
- *
- * In the ideal world, we would always be able to satisfy the
- * following equation:
- *
- * ((512 + 2 * MDWIDTH-Bytes) + (Number of IN Endpoints - 1) * \
- * (3 * (1024 + MDWIDTH-Bytes) + MDWIDTH-Bytes)) / MDWIDTH-Bytes
- *
- * Unfortunately, due to many variables that's not always the case.
- */
-int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc)
+static void dwc3_ep_inc_enq(struct dwc3_ep *dep)
 {
-	int		last_fifo_depth = 0;
-	int		ram1_depth;
-	int		fifo_size;
-	int		mdwidth;
-	int		num;
-
-	if (!dwc->needs_fifo_resize)
-		return 0;
-
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
-	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
-
-	/* MDWIDTH is represented in bits, we need it in bytes */
-	mdwidth >>= 3;
-
-	/*
-	 * FIXME For now we will only allocate 1 wMaxPacketSize space
-	 * for each enabled endpoint, later patches will come to
-	 * improve this algorithm so that we better use the internal
-	 * FIFO space
-	 */
-	for (num = 0; num < dwc->num_in_eps; num++) {
-		/* bit0 indicates direction; 1 means IN ep */
-		struct dwc3_ep	*dep = dwc->eps[(num << 1) | 1];
-		int		mult = 1;
-		int		tmp;
-
-		if (!(dep->flags & DWC3_EP_ENABLED))
-			continue;
-
-		if (usb_endpoint_xfer_bulk(dep->endpoint.desc)
-				|| usb_endpoint_xfer_isoc(dep->endpoint.desc))
-			mult = 3;
-
-		/*
-		 * REVISIT: the following assumes we will always have enough
-		 * space available on the FIFO RAM for all possible use cases.
-		 * Make sure that's true somehow and change FIFO allocation
-		 * accordingly.
-		 *
-		 * If we have Bulk or Isochronous endpoints, we want
-		 * them to be able to be very, very fast. So we're giving
-		 * those endpoints a fifo_size which is enough for 3 full
-		 * packets
-		 */
-		tmp = mult * (dep->endpoint.maxpacket + mdwidth);
-		tmp += mdwidth;
-
-		fifo_size = DIV_ROUND_UP(tmp, mdwidth);
-
-		fifo_size |= (last_fifo_depth << 16);
-
-		dwc3_trace(trace_dwc3_gadget, "%s: Fifo Addr %04x Size %d",
-				dep->name, last_fifo_depth, fifo_size & 0xffff);
-
-		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num), fifo_size);
+	dep->trb_enqueue++;
+	dep->trb_enqueue %= DWC3_TRB_NUM;
+}
 
-		last_fifo_depth += (fifo_size & 0xffff);
-	}
+static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
+{
+	dep->trb_dequeue++;
+	dep->trb_dequeue %= DWC3_TRB_NUM;
+}
 
-	return 0;
+static int dwc3_ep_is_last_trb(unsigned int index)
+{
+	return index == DWC3_TRB_NUM - 1;
 }
 
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
@@ -237,21 +168,19 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	struct dwc3			*dwc = dep->dwc;
 	int				i;
 
-	if (req->queued) {
+	if (req->started) {
 		i = 0;
 		do {
-			dep->busy_slot++;
+			dwc3_ep_inc_deq(dep);
 			/*
 			 * Skip LINK TRB. We can't use req->trb and check for
 			 * DWC3_TRBCTL_LINK_TRB because it points the TRB we
 			 * just completed (not the LINK TRB).
 			 */
-			if (((dep->busy_slot & DWC3_TRB_MASK) ==
-				DWC3_TRB_NUM- 1) &&
-				usb_endpoint_xfer_isoc(dep->endpoint.desc))
-				dep->busy_slot++;
+			if (dwc3_ep_is_last_trb(dep->trb_dequeue))
+				dwc3_ep_inc_deq(dep);
 		} while(++i < req->request.num_mapped_sgs);
-		req->queued = false;
+		req->started = false;
 	}
 	list_del(&req->list);
 	req->trb = NULL;
@@ -307,6 +236,8 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 	} while (1);
 }
 
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+
 int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
 {
@@ -314,8 +245,40 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	u32			timeout = 500;
 	u32			reg;
 
+	int			susphy = false;
+	int			ret = -EINVAL;
+
 	trace_dwc3_gadget_ep_cmd(dep, cmd, params);
 
+	/*
+	 * Synopsys Databook 2.60a states, on section 6.3.2.5.[1-8], that if
+	 * we're issuing an endpoint command, we must check if
+	 * GUSB2PHYCFG.SUSPHY bit is set. If it is, then we need to clear it.
+	 *
+	 * We will also set SUSPHY bit to what it was before returning as stated
+	 * by the same section on Synopsys databook.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
+		susphy = true;
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
+	if (cmd == DWC3_DEPCMD_STARTTRANSFER) {
+		int		needs_wakeup;
+
+		needs_wakeup = (dwc->link_state == DWC3_LINK_STATE_U1 ||
+				dwc->link_state == DWC3_LINK_STATE_U2 ||
+				dwc->link_state == DWC3_LINK_STATE_U3);
+
+		if (unlikely(needs_wakeup)) {
+			ret = __dwc3_gadget_wakeup(dwc);
+			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
+					ret);
+		}
+	}
+
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1);
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR2(ep), params->param2);
@@ -324,12 +287,40 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DEPCMD(ep));
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
+			int cmd_status = DWC3_DEPCMD_STATUS(reg);
+
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Complete --> %d",
-					DWC3_DEPCMD_STATUS(reg));
-			if (DWC3_DEPCMD_STATUS(reg))
-				return -EINVAL;
-			return 0;
+					cmd_status);
+
+			switch (cmd_status) {
+			case 0:
+				ret = 0;
+				break;
+			case DEPEVT_TRANSFER_NO_RESOURCE:
+				dwc3_trace(trace_dwc3_gadget, "%s: no resource available");
+				ret = -EINVAL;
+				break;
+			case DEPEVT_TRANSFER_BUS_EXPIRY:
+				/*
+				 * SW issues START TRANSFER command to
+				 * isochronous ep with future frame interval. If
+				 * future interval time has already passed when
+				 * core receives the command, it will respond
+				 * with an error status of 'Bus Expiry'.
+				 *
+				 * Instead of always returning -EINVAL, let's
+				 * give a hint to the gadget driver that this is
+				 * the case by returning -EAGAIN.
+				 */
+				dwc3_trace(trace_dwc3_gadget, "%s: bus expiry");
+				ret = -EAGAIN;
+				break;
+			default:
+				dev_WARN(dwc->dev, "UNKNOWN cmd status\n");
+			}
+
+			break;
 		}
 
 		/*
@@ -340,11 +331,42 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		if (!timeout) {
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Timed Out");
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			break;
 		}
 
 		udelay(1);
 	} while (1);
+
+	if (unlikely(susphy)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
+	return ret;
+}
+
+static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	struct dwc3_gadget_ep_cmd_params params;
+	u32 cmd = DWC3_DEPCMD_CLEARSTALL;
+
+	/*
+	 * As of core revision 2.60a the recommended programming model
+	 * is to set the ClearPendIN bit when issuing a Clear Stall EP
+	 * command for IN endpoints. This is to prevent an issue where
+	 * some (non-compliant) hosts may not send ACK TPs for pending
+	 * IN transfers due to a mishandled error condition. Synopsys
+	 * STAR 9000614252.
+	 */
+	if (dep->direction && (dwc->revision >= DWC3_REVISION_260A))
+		cmd |= DWC3_DEPCMD_CLEARPENDIN;
+
+	memset(&params, 0, sizeof(params));
+
+	return dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
 }
 
 static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
@@ -464,9 +486,19 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 
 	/* Burst size is only needed in SuperSpeed mode */
 	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
-		u32 burst = dep->endpoint.maxburst - 1;
+		u32 burst = dep->endpoint.maxburst;
+		u32 nump;
+		u32 reg;
+
+		/* update NumP */
+		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+		nump = DWC3_DCFG_NUMP(reg);
+		nump = max(nump, burst);
+		reg &= ~DWC3_DCFG_NUMP_MASK;
+		reg |= nump << DWC3_DCFG_NUMP_SHIFT;
+		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
-		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst);
+		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst - 1);
 	}
 
 	if (ignore)
@@ -567,10 +599,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
-		if (!usb_endpoint_xfer_isoc(desc))
+		if (usb_endpoint_xfer_control(desc))
 			goto out;
 
-		/* Link TRB for ISOC. The HWO bit is never reset */
+		/* Link TRB. The HWO bit is never reset */
 		trb_st_hw = &dep->trb_pool[0];
 
 		trb_link = &dep->trb_pool[DWC3_TRB_NUM - 1];
@@ -608,19 +640,19 @@ static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 
-	if (!list_empty(&dep->req_queued)) {
+	if (!list_empty(&dep->started_list)) {
 		dwc3_stop_active_transfer(dwc, dep->number, true);
 
 		/* - giveback all requests to gadget driver */
-		while (!list_empty(&dep->req_queued)) {
-			req = next_request(&dep->req_queued);
+		while (!list_empty(&dep->started_list)) {
+			req = next_request(&dep->started_list);
 
 			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
 		}
 	}
 
-	while (!list_empty(&dep->request_list)) {
-		req = next_request(&dep->request_list);
+	while (!list_empty(&dep->pending_list)) {
+		req = next_request(&dep->pending_list);
 
 		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
 	}
@@ -783,20 +815,19 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 			chain ? " chain" : "");
 
 
-	trb = &dep->trb_pool[dep->free_slot & DWC3_TRB_MASK];
+	trb = &dep->trb_pool[dep->trb_enqueue];
 
 	if (!req->trb) {
-		dwc3_gadget_move_request_queued(req);
+		dwc3_gadget_move_started_request(req);
 		req->trb = trb;
 		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
-		req->start_slot = dep->free_slot & DWC3_TRB_MASK;
+		req->first_trb_index = dep->trb_enqueue;
 	}
 
-	dep->free_slot++;
-	/* Skip the LINK-TRB on ISOC */
-	if (((dep->free_slot & DWC3_TRB_MASK) == DWC3_TRB_NUM - 1) &&
-			usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		dep->free_slot++;
+	dwc3_ep_inc_enq(dep);
+	/* Skip the LINK-TRB */
+	if (dwc3_ep_is_last_trb(dep->trb_enqueue))
+		dwc3_ep_inc_enq(dep);
 
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
@@ -812,6 +843,9 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS_FIRST;
 		else
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS;
+
+		/* always enable Interrupt on Missed ISOC */
+		trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 		break;
 
 	case USB_ENDPOINT_XFER_BULK:
@@ -826,15 +860,14 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		BUG();
 	}
 
+	/* always enable Continue on Short Packet */
+	trb->ctrl |= DWC3_TRB_CTRL_CSP;
+
 	if (!req->request.no_interrupt && !chain)
-		trb->ctrl |= DWC3_TRB_CTRL_IOC;
+		trb->ctrl |= DWC3_TRB_CTRL_IOC | DWC3_TRB_CTRL_ISP_IMI;
 
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
-		trb->ctrl |= DWC3_TRB_CTRL_CSP;
-	} else if (last) {
+	if (last)
 		trb->ctrl |= DWC3_TRB_CTRL_LST;
-	}
 
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
@@ -860,55 +893,29 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 {
 	struct dwc3_request	*req, *n;
 	u32			trbs_left;
-	u32			max;
 	unsigned int		last_one = 0;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
-	/* the first request must not be queued */
-	trbs_left = (dep->busy_slot - dep->free_slot) & DWC3_TRB_MASK;
-
-	/* Can't wrap around on a non-isoc EP since there's no link TRB */
-	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		max = DWC3_TRB_NUM - (dep->free_slot & DWC3_TRB_MASK);
-		if (trbs_left > max)
-			trbs_left = max;
-	}
+	trbs_left = dep->trb_dequeue - dep->trb_enqueue;
 
 	/*
-	 * If busy & slot are equal than it is either full or empty. If we are
-	 * starting to process requests then we are empty. Otherwise we are
+	 * If enqueue & dequeue are equal than it is either full or empty. If we
+	 * are starting to process requests then we are empty. Otherwise we are
 	 * full and don't do anything
 	 */
 	if (!trbs_left) {
 		if (!starting)
 			return;
+
 		trbs_left = DWC3_TRB_NUM;
-		/*
-		 * In case we start from scratch, we queue the ISOC requests
-		 * starting from slot 1. This is done because we use ring
-		 * buffer and have no LST bit to stop us. Instead, we place
-		 * IOC bit every TRB_NUM/4. We try to avoid having an interrupt
-		 * after the first request so we start at slot 1 and have
-		 * 7 requests proceed before we hit the first IOC.
-		 * Other transfer types don't use the ring buffer and are
-		 * processed from the first TRB until the last one. Since we
-		 * don't wrap around we have to start at the beginning.
-		 */
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dep->busy_slot = 1;
-			dep->free_slot = 1;
-		} else {
-			dep->busy_slot = 0;
-			dep->free_slot = 0;
-		}
 	}
 
 	/* The last TRB is a link TRB, not used for xfer */
-	if ((trbs_left <= 1) && usb_endpoint_xfer_isoc(dep->endpoint.desc))
+	if (trbs_left <= 1)
 		return;
 
-	list_for_each_entry_safe(req, n, &dep->request_list, list) {
+	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
 		unsigned	length;
 		dma_addr_t	dma;
 		last_one = false;
@@ -927,7 +934,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
 				if (i == (request->num_mapped_sgs - 1) ||
 						sg_is_last(s)) {
-					if (list_empty(&dep->request_list))
+					if (list_empty(&dep->pending_list))
 						last_one = true;
 					chain = false;
 				}
@@ -957,7 +964,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 				last_one = 1;
 
 			/* Is this the last request? */
-			if (list_is_last(&req->list, &dep->request_list))
+			if (list_is_last(&req->list, &dep->pending_list))
 				last_one = 1;
 
 			dwc3_prepare_one_trb(dep, req, dma, length,
@@ -988,18 +995,18 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 	 * new requests as we try to set the IOC bit only on the last request.
 	 */
 	if (start_new) {
-		if (list_empty(&dep->req_queued))
+		if (list_empty(&dep->started_list))
 			dwc3_prepare_trbs(dep, start_new);
 
 		/* req points to the first request which will be sent */
-		req = next_request(&dep->req_queued);
+		req = next_request(&dep->started_list);
 	} else {
 		dwc3_prepare_trbs(dep, start_new);
 
 		/*
 		 * req points to the first request where HWO changed from 0 to 1
 		 */
-		req = next_request(&dep->req_queued);
+		req = next_request(&dep->started_list);
 	}
 	if (!req) {
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
@@ -1046,7 +1053,7 @@ static void __dwc3_gadget_start_isoc(struct dwc3 *dwc,
 {
 	u32 uf;
 
-	if (list_empty(&dep->request_list)) {
+	if (list_empty(&dep->pending_list)) {
 		dwc3_trace(trace_dwc3_gadget,
 				"ISOC ep %s run out for requests",
 				dep->name);
@@ -1114,7 +1121,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	if (ret)
 		return ret;
 
-	list_add_tail(&req->list, &dep->request_list);
+	list_add_tail(&req->list, &dep->pending_list);
 
 	/*
 	 * If there are no pending requests and the endpoint isn't already
@@ -1149,7 +1156,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		 * notion of current microframe.
 		 */
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			if (list_empty(&dep->req_queued)) {
+			if (list_empty(&dep->started_list)) {
 				dwc3_stop_active_transfer(dwc, dep->number, true);
 				dep->flags = DWC3_EP_ENABLED;
 			}
@@ -1267,13 +1274,13 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	list_for_each_entry(r, &dep->request_list, list) {
+	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req)
 			break;
 	}
 
 	if (r != req) {
-		list_for_each_entry(r, &dep->req_queued, list) {
+		list_for_each_entry(r, &dep->started_list, list) {
 			if (r == req)
 				break;
 		}
@@ -1313,10 +1320,10 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 
 	if (value) {
 		if (!protocol && ((dep->direction && dep->flags & DWC3_EP_BUSY) ||
-				(!list_empty(&dep->req_queued) ||
-				 !list_empty(&dep->request_list)))) {
+				(!list_empty(&dep->started_list) ||
+				 !list_empty(&dep->pending_list)))) {
 			dwc3_trace(trace_dwc3_gadget,
-					"%s: pending request, cannot halt\n",
+					"%s: pending request, cannot halt",
 					dep->name);
 			return -EAGAIN;
 		}
@@ -1329,8 +1336,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
-		ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-			DWC3_DEPCMD_CLEARSTALL, &params);
+		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret)
 			dev_err(dwc->dev, "failed to clear STALL on %s\n",
 					dep->name);
@@ -1417,22 +1423,16 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 	return DWC3_DSTS_SOFFN(reg);
 }
 
-static int dwc3_gadget_wakeup(struct usb_gadget *g)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 {
-	struct dwc3		*dwc = gadget_to_dwc(g);
-
 	unsigned long		timeout;
-	unsigned long		flags;
 
+	int			ret;
 	u32			reg;
 
-	int			ret = 0;
-
 	u8			link_state;
 	u8			speed;
 
-	spin_lock_irqsave(&dwc->lock, flags);
-
 	/*
 	 * According to the Databook Remote wakeup request should
 	 * be issued only when the device is in early suspend state.
@@ -1445,8 +1445,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	if ((speed == DWC3_DSTS_SUPERSPEED) ||
 	    (speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	link_state = DWC3_DSTS_USBLNKST(reg);
@@ -1459,14 +1458,13 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 		dwc3_trace(trace_dwc3_gadget,
 				"can't wakeup from '%s'\n",
 				dwc3_gadget_link_string(link_state));
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
 		dev_err(dwc->dev, "failed to put link in Recovery\n");
-		goto out;
+		return ret;
 	}
 
 	/* Recent versions do this automatically */
@@ -1490,10 +1488,20 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 
 	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
 		dev_err(dwc->dev, "failed to send remote wakeup\n");
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
-out:
+	return 0;
+}
+
+static int dwc3_gadget_wakeup(struct usb_gadget *g)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+	int			ret;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	ret = __dwc3_gadget_wakeup(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1620,7 +1628,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 
 	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
 	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
-			IRQF_SHARED, "dwc3", dwc);
+			IRQF_SHARED, "dwc3", dwc->ev_buf);
 	if (ret) {
 		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
 				irq, ret);
@@ -1682,6 +1690,17 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	}
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
+	/*
+	 * We are telling dwc3 that we want to use DCFG.NUMP as ACK TP's NUMP
+	 * field instead of letting dwc3 itself calculate that automatically.
+	 *
+	 * This way, we maximize the chances that we'll be able to get several
+	 * bursts of data without going through any sort of endpoint throttling.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+	reg &= ~DWC3_GRXTHRCFG_PKTCNTSEL;
+	dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -1720,7 +1739,7 @@ err2:
 err1:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	free_irq(irq, dwc);
+	free_irq(irq, dwc->ev_buf);
 
 err0:
 	return ret;
@@ -1743,7 +1762,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
-	free_irq(irq, dwc);
+	free_irq(irq, dwc->ev_buf);
 
 	return 0;
 }
@@ -1815,8 +1834,8 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 		dep->endpoint.caps.dir_in = !!direction;
 		dep->endpoint.caps.dir_out = !direction;
 
-		INIT_LIST_HEAD(&dep->request_list);
-		INIT_LIST_HEAD(&dep->req_queued);
+		INIT_LIST_HEAD(&dep->pending_list);
+		INIT_LIST_HEAD(&dep->started_list);
 	}
 
 	return 0;
@@ -1913,11 +1932,11 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 				 * If there are still queued request
 				 * then wait, do not issue either END
 				 * or UPDATE TRANSFER, just attach next
-				 * request in request_list during
+				 * request in pending_list during
 				 * giveback.If any future queued request
 				 * is successfully transferred then we
 				 * will issue UPDATE TRANSFER for all
-				 * request in the request_list.
+				 * request in the pending_list.
 				 */
 				dep->flags |= DWC3_EP_MISSED_ISOC;
 			} else {
@@ -1963,15 +1982,14 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	int			ret;
 
 	do {
-		req = next_request(&dep->req_queued);
+		req = next_request(&dep->started_list);
 		if (WARN_ON_ONCE(!req))
 			return 1;
 
 		i = 0;
 		do {
-			slot = req->start_slot + i;
-			if ((slot == DWC3_TRB_NUM - 1) &&
-				usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			slot = req->first_trb_index + i;
+			if (slot == DWC3_TRB_NUM - 1)
 				slot++;
 			slot %= DWC3_TRB_NUM;
 			trb = &dep->trb_pool[slot];
@@ -1989,8 +2007,8 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	} while (1);
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			list_empty(&dep->req_queued)) {
-		if (list_empty(&dep->request_list)) {
+			list_empty(&dep->started_list)) {
+		if (list_empty(&dep->pending_list)) {
 			/*
 			 * If there is no entry in request list then do
 			 * not issue END TRANSFER now. Just set PENDING
@@ -2039,7 +2057,7 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
 
-			if (!list_empty(&dep->req_queued))
+			if (!list_empty(&dep->started_list))
 				return;
 		}
 
@@ -2250,7 +2268,6 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 
 	for (epnum = 1; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
 		struct dwc3_ep *dep;
-		struct dwc3_gadget_ep_cmd_params params;
 		int ret;
 
 		dep = dwc->eps[epnum];
@@ -2262,9 +2279,7 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 
 		dep->flags &= ~DWC3_EP_STALL;
 
-		memset(&params, 0, sizeof(params));
-		ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
-				DWC3_DEPCMD_CLEARSTALL, &params);
+		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		WARN_ON_ONCE(ret);
 	}
 }
@@ -2686,14 +2701,13 @@ static void dwc3_process_event_entry(struct dwc3 *dwc,
 	}
 }
 
-static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
+static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 {
-	struct dwc3_event_buffer *evt;
+	struct dwc3 *dwc = evt->dwc;
 	irqreturn_t ret = IRQ_NONE;
 	int left;
 	u32 reg;
 
-	evt = dwc->ev_buffs[buf];
 	left = evt->count;
 
 	if (!(evt->flags & DWC3_EVENT_PENDING))
@@ -2718,7 +2732,7 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
 		evt->lpos = (evt->lpos + 4) % DWC3_EVENT_BUFFERS_SIZE;
 		left -= 4;
 
-		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(buf), 4);
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 4);
 	}
 
 	evt->count = 0;
@@ -2726,39 +2740,34 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
 	ret = IRQ_HANDLED;
 
 	/* Unmask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(buf));
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
 	reg &= ~DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(buf), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
 
 	return ret;
 }
 
-static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc)
+static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 {
-	struct dwc3 *dwc = _dwc;
+	struct dwc3_event_buffer *evt = _evt;
+	struct dwc3 *dwc = evt->dwc;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
-	int i;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-
-	for (i = 0; i < dwc->num_event_buffers; i++)
-		ret |= dwc3_process_event_buf(dwc, i);
-
+	ret = dwc3_process_event_buf(evt);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
 }
 
-static irqreturn_t dwc3_check_event_buf(struct dwc3 *dwc, u32 buf)
+static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
-	struct dwc3_event_buffer *evt;
+	struct dwc3 *dwc = evt->dwc;
 	u32 count;
 	u32 reg;
 
-	evt = dwc->ev_buffs[buf];
-
-	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(buf));
+	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
 	if (!count)
 		return IRQ_NONE;
@@ -2767,28 +2776,18 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3 *dwc, u32 buf)
 	evt->flags |= DWC3_EVENT_PENDING;
 
 	/* Mask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(buf));
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
 	reg |= DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(buf), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
 
 	return IRQ_WAKE_THREAD;
 }
 
-static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
+static irqreturn_t dwc3_interrupt(int irq, void *_evt)
 {
-	struct dwc3			*dwc = _dwc;
-	int				i;
-	irqreturn_t			ret = IRQ_NONE;
+	struct dwc3_event_buffer	*evt = _evt;
 
-	for (i = 0; i < dwc->num_event_buffers; i++) {
-		irqreturn_t status;
-
-		status = dwc3_check_event_buf(dwc, i);
-		if (status == IRQ_WAKE_THREAD)
-			ret = status;
-	}
-
-	return ret;
+	return dwc3_check_event_buf(evt);
 }
 
 /**
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 18ae3eaa8b6f..f21c0fccbebd 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -68,12 +68,12 @@ static inline struct dwc3_request *next_request(struct list_head *list)
 	return list_first_entry(list, struct dwc3_request, list);
 }
 
-static inline void dwc3_gadget_move_request_queued(struct dwc3_request *req)
+static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 {
 	struct dwc3_ep		*dep = req->dep;
 
-	req->queued = true;
-	list_move_tail(&req->list, &dep->req_queued);
+	req->started = true;
+	list_move_tail(&req->list, &dep->started_list);
 }
 
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 2bb4d3ad0e6b..8826cca5fc6f 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -23,7 +23,6 @@
 struct dwc3_platform_data {
 	enum usb_device_speed maximum_speed;
 	enum usb_dr_mode dr_mode;
-	bool tx_fifo_resize;
 	bool usb3_lpm_capable;
 
 	unsigned is_utmi_l1_suspend:1;
@@ -43,6 +42,7 @@ struct dwc3_platform_data {
 	unsigned dis_u3_susphy_quirk:1;
 	unsigned dis_u2_susphy_quirk:1;
 	unsigned dis_enblslpm_quirk:1;
+	unsigned dis_rxdet_inp3_quirk:1;
 
 	unsigned tx_de_emphasis_quirk:1;
 	unsigned tx_de_emphasis:2;
-- 
2.53.0

