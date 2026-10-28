Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF880606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eQxVoM6w;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IwI85p4t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3CE940635;
	Wed, 28 Oct 2026 14:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsgtL0EseBRF; Wed, 28 Oct 2026 14:46:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A4FB40744
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198799;
	b=VZHMhrUFv+QuULPvmomfLp4xDGqKFsncyqWLEAZ8Zu+RwHBi7uaSsT2pYHiadb2P8zwn
	 JnWYTIV9Vfp4cinltrDdUgiPLYZZRg0V9Vu+WiKVa/xAj7AxQF0J8ZvAvCQH1rEhYyKzC
	 io/aOQHIf8haoYdWBn9u1Pi6QIAMRBPgRNQ3F6UiBfm4bVvZQtBEOiYqZtLug7wgAyL7y
	 +9PGMrxYFoeFm4PEt07pfG7zqsyXBcribb4TBKfsGBHSgk2+EJqAuLJyqIqsKFaHAmkMP
	 roYggkAt+xA+qjRYryiMuO9mq7RoCaBUNF7DqidAD/jLadTRSar/AIAyUgSnb2r3ojA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tJxqVKtPwOPvisudj1vRt+HjjhSKUPgMmD0v5dBVmk4=;
	b=ITJ+dBZYBKHDLNHnzz4GMe4pWiqqBRFo7TBHl0VwbDOdcww4x/hZyaoDIG0M/LZUGvfS
	 DLl/IS0ozp+Fj+Q13enCczS8MWYtvezoMoM6bnYEK27M1+yxtN1I+3cItf8xld2bTtxiz
	 qLRQxNxPClg/LySYkBVKBPDse0K0vAaoPq3PUzmEV0gj6Jrs/2rCm4tgdiBSLjRWAXDo0
	 3WSsXZ3nWoUn5EiS21rdhZ/kMPXFTGmnqmqvtLkNAMaML5ALDkSQ9Ax9INMQc3QQsUH47
	 MNu84s8FdWN5hwo8tiGsVVz/wUUzHNgukcQdwJ0QYZIATGcrnVryNWH23xpvC7Dygig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198799;
	bh=tJxqVKtPwOPvisudj1vRt+HjjhSKUPgMmD0v5dBVmk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eQxVoM6w9WEraDV1ko3WmHoIaTE/8bvgJzSc7Q9QSkIPMlQyvK9l9cz/yJyXgVj1M
	 xkU29FSBROnjgrxFLDT/vHmjNoOpeZFiMkZYT9sfjaGiLDDriR9o+6XcH7krx1m6m3
	 mO75pqwSnxUqCokijMX/TVHu+JNFNaT000qanEDZtXNwGtUv/J6bmrNpVlbBoZFWrL
	 tlchI5Cvi/PE80iHyrpinBjVmzeUuIYCUUKKJmXbCYa6sXi4vRJotiqxQ3fQF0Wvco
	 yb3bgjQmCFoglSfzl71jj/76oJ0VvbXMxWAJkbGZ2vyungLFnz//jMhBJERBHLMND/
	 kl+yuQnRdI1qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A4FB40744;
	Wed, 28 Oct 2026 14:46:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A9ACD4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B6A76060B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXp-cx9sYuy4 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FC64605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196706;
 b=bIwlXhAxQLejOguxPJexQiWDreeE5SXLXLuPIqW3HSqgZQ6/C6tyqsL6tzxQgVFklmVr
 7EPsTczWyn5SBj/d16sNM0GpXNyrLS2mMFHXz9y5pZsyGP9sRU3cAf0ybcjTtfRuyo3Uo
 DPUnNRZ16gLoSR4TQ5pkrpdADqgiVwpKhb7Boic8VTUtf42+5xOsaIRR9FCSHNmTVueA5
 46qUSbxXDV+g9deLRcYh7+4bERGp/jrErCFJGKtI7AaDrXtcBSowdVvpwHfFmkr+ATpqu
 I2tGQ6+HI6cjjI4awMzDcsi77UEhDgWD8v3SqwmBDONrFAyICuH4DwkFFW4iKPtKi7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196706;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=tJxqVKtPwOPvisudj1vRt+HjjhSKUPgMmD0v5dBVmk4=;
 b=nFgxDpycuNQYTektOgipyvti20nLuAWOxPpszBWYKIagOJ0SigvE0AooW4S0rRgAM9CZ
 TMMaz4dR0HXW70mzQKjYlWU5N3eTk1wwoZohmfhBNko4LV2F/YWlpTags9KMJJXlqGqWr
 DbuBjXjB6EcCDXj+BhJMqBDO7QYOsler5u4vCAOlsdmaWzMvvJxtEbm6KZcqVEYsYLFV9
 ccZnL9lVdZ+Gsgd9G7EWxMC9hMxAfUOsgZ1gxIUDtVDI+i1a7DVrUXz57iqh80cHW1hNH
 nfkU7QzwK5k+EeFyPCKcZ3Arl0u1g6Mn/0HXPxX3tCztmcBuvHFhP+hN2tdYfhbZaxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IwI85p4t; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=IwI85p4t
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FC64605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:45 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c40aa03a96fso11187866b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196704; x=1793801504;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tJxqVKtPwOPvisudj1vRt+HjjhSKUPgMmD0v5dBVmk4=;
 b=IwI85p4tPSLbrW9xJl+QHHnP4WKYuatfSckSIbcRFZ4L7aol8eCCiJpfwqH6NWTWmo
 qWpBaw6iUJBJAPcHz1o6TJPD3wYamCHJnzpnEXqXfzaOAzzKcHzYytuh/b0AdgZmMvjK
 KLY23p/9w/Mhm/UdcAE0pSRhLPopbbuERRVK3pc84jwzJk2WBlSThcnCitBjZSGY7t6X
 uDePpQFTYaGyuoWvQkyzhWHKzNaNCZzDwek3wV9hMCS7odbsya1XXO3LNgLOe7bo4UUN
 hzV1/Poshn7OJSwtitWkA+BRhGRHizquznA8jQFG6GsUJ8YmW0bMHz++mDZmHTGB4Y9e
 YJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196704; x=1793801504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tJxqVKtPwOPvisudj1vRt+HjjhSKUPgMmD0v5dBVmk4=;
 b=GAulX6tPBJ89BF5RRuYARQkK7jVcRzWduTByEtsabPzEYYB54Ry7ImLHfiA6iPc5BW
 cHiti0IHLb0nsSNy8eSC7vARb5P2vlj7RJHybUVSuBxfg4wOEUf6yX49mmmuh63AYAVj
 EQxvYi2tTpPI8DGGSzabT1OJi/+q2n4nn2fLh23qsESHTvgY+lPpc/qIxFsAyihnsdh8
 jVHgj0KGUJAbR1W1mbMj+e2Y20uUROa3fU998dyLUmRUVY85Kda3I/EdtM87RzTfkyei
 ysfI82ldY6q/odF2yugphf/dLDJtmxv3C00JQXjVSPvTg86PySPhqVLvGumhUXlBH94H
 xvAw==
X-Gm-Message-State: AFq9FYIs1KRxEMgrrC3UuxoSzVOi3W8mQXDF6H7NidwO/+wz4VqoiI0y
 e+DRVeWwmFs85aYRKG3BSSnCK/qb9cWhHPjw/e5cBnxnwgtdyKGIjME8kBqrkGP7aBaYhLvng51
 Xex6u
X-Gm-Gg: AYBFou1EgIDQUUNvPWbr4oSGt4QP1pJlMyX/33VV5W0A/ZmucRaJ3ztnKiTWLmkKLr2
 R0KJbr6ueByIiOU6vnwr8Qk8gNk4m6xTj87q6AcFxYMOE5Jlln8+m5r9UnbzrAMq5JiHv3wnxjJ
 kTSy3qmpev5YDEMzutUxIYXkjy2a6w576pp06dVx9sBZeCG302Fm1So7Oq5W0PBU0hhOuDybgb+
 WfX4T1EIzTeHKwxVErPwpBClLdBEMGJR2Vm9mwPpcTdYFClMSWks7nhdUm/ZuNQ3zsquuZU1cGd
 61O2TPB+bbxnbkrc6WwSaTBRagWmP625Y75+9Bzf10W+9dtuU53zEc/brKfXLSARRyVBpYqFMdb
 9jjtvCtdrFNeALt9mV1CZa4HexVALJH74Y3rIQvgpWcKlWCX7YBNOuY/4sjshXEVCKDjzwXp7sn
 JKQE9YlzaBL3F0L61trReqgECnhUjb6taJzd+oODYjgZEKVm1PQTPH6lD3tOCJHjoYOl5FsUAWD
 +jok/5ZzJGoFcrsM/WbT+UC4O5zuDLq5N3AbV2O/JJsaeTeRTsswAsjXV7iPPhiiO/+tV7R+l4C
 zavaDdWx1qjte85oW60K0YFjeTU0/zxl0qn3p65GebFYssRmwOOhvxy1Y6Dm4k02Fgq+dXVD2SM
 6CAfWxMP7wA==
X-Received: by 2002:a17:906:9986:b0:c46:b5a7:5b29 with SMTP id
 a640c23a62f3a-c49bde9c83amr230994366b.2.1793196703519; 
 Wed, 28 Oct 2026 07:11:43 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64a02csm611738166b.44.2026.10.28.07.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:43 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 25/63] usb: dwc3: import from kernel v5.0
Date: Wed, 28 Oct 2026 15:08:51 +0100
Message-ID: <20261028140930.3025368-26-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.20 to v5.0.

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

List of commits: git log --oneline v4.20..v5.0
Commits imported:
1e19cdc80602 usb: dwc3: gadget: Handle 0 xfer length for OUT EP
88b1bb1f3b88 usb: dwc3: gadget: Fix the uninitialized link_state when udc starts
bd6742249b9c usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup
01c10880d242 usb: dwc3: gadget: synchronize_irq dwc irq in suspend
244add8ebfb2 usb: dwc3: gadget: Disable CSP for stream OUT ep
6abfa0f5bb7c usb: dwc3: gadget: Report isoc transfer frame number
b7a4fbe2300a usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
26d62b4d10ad usb: dwc3: don't issue no-op trb for stream capable endpoints
a7351807bd8b usb: dwc3: update stream id in depcmd
d53701067f04 usb: dwc3: gadget: check if dep->frame_number is still valid
3451f6affaef usb: dwc3: gadget: remove unnecessary dev_info()
25abad6a0584 usb: dwc3: gadget: return errors from __dwc3_gadget_start_isoc()
fec9095bdef4 usb: dwc3: gadget: remove wait_end_transfer
d4f1afe5e896 usb: dwc3: gadget: move requests to cancelled_list
d5443bbf5fc8 usb: dwc3: gadget: introduce cancelled_list
7746a8dfb3f9 usb: dwc3: gadget: extract dwc3_gadget_ep_skip_trbs()
c3acd5901414 usb: dwc3: gadget: use num_trbs when skipping TRBs on ->dequeue()
09fe1f8d7e2f usb: dwc3: gadget: track number of TRBs per request
1a22ec643580 usb: dwc3: gadget: combine unaligned and zero flags
d92021f66063 usb: dwc3: Add workaround for isoc start transfer failure
475d8e0197f1 usb: dwc3: Track DWC_usb31 VERSIONTYPE
89a9cc47513e usb: dwc3: Set default mode for DWC_usb3 v3.30a and higher
408d3ba006af usb: dwc3: don't log probe deferrals; but do log other error codes
022a0208c0ff usb: dwc3: Support option to disable USB2 LPM
eafeacf11964 usb: dwc3: Set GUSB2PHYCFG.ENBLSLPM
0d36dede4578 usb: dwc3: debugfs: Properly print/set link state for HS
62ba09d6bb63 usb: dwc3: debugfs: Dump internal LSP and ep registers
2c85a1817e4b usb: dwc3: debugfs: Properly name Tx/RxFIFO

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  19 ++-
 drivers/usb/dwc3/core.h   |  60 ++++++-
 drivers/usb/dwc3/debug.h  |  29 ++++
 drivers/usb/dwc3/gadget.c | 348 +++++++++++++++++++++++++-------------
 drivers/usb/dwc3/gadget.h |  15 ++
 5 files changed, 336 insertions(+), 135 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2f2048aa5fde..a1b126f90261 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -80,11 +80,12 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 			mode = USB_DR_MODE_PERIPHERAL;
 
 		/*
-		 * dwc_usb31 does not support OTG mode. If the controller
-		 * supports DRD but the dr_mode is not specified or set to OTG,
-		 * then set the mode to peripheral.
+		 * DWC_usb31 and DWC_usb3 v3.30a and higher do not support OTG
+		 * mode. If the controller supports DRD but the dr_mode is not
+		 * specified or set to OTG, then set the mode to peripheral.
 		 */
-		if (mode == USB_DR_MODE_OTG && dwc3_is_usb31(dwc))
+		if (mode == USB_DR_MODE_OTG &&
+		    dwc->revision >= DWC3_REVISION_330A)
 			mode = USB_DR_MODE_PERIPHERAL;
 	}
 
@@ -661,6 +662,8 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 
 	if (dwc->dis_enblslpm_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	else
+		reg |= DWC3_GUSB2PHYCFG_ENBLSLPM;
 
 	if (dwc->dis_u2_freeclk_exists_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
@@ -702,6 +705,7 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 		/* Detected DWC_usb31 IP */
 		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
 		dwc->revision |= DWC3_REVISION_IS_DWC31;
+		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
 	} else {
 		return false;
 	}
@@ -1244,8 +1248,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,is-utmi-l1-suspend");
 	device_property_read_u8(dev, "snps,hird-threshold",
 				&hird_threshold);
+	dwc->dis_start_transfer_quirk = device_property_read_bool(dev,
+				"snps,dis-start-transfer-quirk");
 	dwc->usb3_lpm_capable = device_property_read_bool(dev,
 				"snps,usb3_lpm_capable");
+	dwc->usb2_lpm_disable = device_property_read_bool(dev,
+				"snps,usb2-lpm-disable");
 	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
 				&rx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,rx-max-burst-prd",
@@ -1482,7 +1490,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		dev_err(dev, "failed to initialize core\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to initialize core: %d\n", ret);
 		goto err4;
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb62533e0f..df876418cb78 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -37,6 +37,7 @@
 #define DWC3_EP0_SETUP_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
+#define DWC3_ISOC_MAX_RETRIES	5
 
 #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
 #define DWC3_EVENT_BUFFERS_SIZE	4096
@@ -174,13 +175,19 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global Debug LSP MUX Select */
+#define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
+#define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
+#define DWC3_GDBGLSPMUX_DEVSELECT(n)	(((n) & 0xf) << 4)
+#define DWC3_GDBGLSPMUX_EPSELECT(n)	((n) & 0xf)
+
 /* Global Debug Queue/FIFO Space Available Register */
 #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
 #define DWC3_GDBGFIFOSPACE_SPACE_AVAILABLE(n) (((n) >> 16) & 0xffff)
 
-#define DWC3_TXFIFOQ		0
-#define DWC3_RXFIFOQ		1
+#define DWC3_TXFIFO		0
+#define DWC3_RXFIFO		1
 #define DWC3_TXREQQ		2
 #define DWC3_RXREQQ		3
 #define DWC3_RXINFOQ		4
@@ -253,6 +260,9 @@
 #define DWC3_GSTS_DEVICE_IP	BIT(6)
 #define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
 #define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
+#define DWC3_GSTS_CURMOD(n)	((n) & 0x3)
+#define DWC3_GSTS_CURMOD_DEVICE	0
+#define DWC3_GSTS_CURMOD_HOST	1
 
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
@@ -321,6 +331,7 @@
 #define DWC3_GHWPARAMS1_EN_PWROPT_HIB	2
 #define DWC3_GHWPARAMS1_PWROPT(n)	((n) << 24)
 #define DWC3_GHWPARAMS1_PWROPT_MASK	DWC3_GHWPARAMS1_PWROPT(3)
+#define DWC3_GHWPARAMS1_ENDBC		BIT(31)
 
 /* Global HWPARAMS3 Register */
 #define DWC3_GHWPARAMS3_SSPHY_IFC(n)		((n) & 3)
@@ -636,9 +647,9 @@ struct dwc3_event_buffer {
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
+ * @cancelled_list: list of cancelled requests for this endpoint
  * @pending_list: list of pending requests for this endpoint
  * @started_list: list of started requests on this endpoint
- * @wait_end_transfer: wait_queue_head_t for waiting on End Transfer complete
  * @lock: spinlock for endpoint request queue traversal
  * @regs: pointer to first endpoint register
  * @trb_pool: array of transaction buffers
@@ -656,14 +667,17 @@ struct dwc3_event_buffer {
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
+ * @combo_num: the test combination BIT[15:14] of the frame number to test
+ *		isochronous START TRANSFER command failure workaround
+ * @start_cmd_status: the status of testing START TRANSFER command with
+ *		combo_num = 'b00
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
+	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
-	wait_queue_head_t	wait_end_transfer;
-
 	spinlock_t		lock;
 	void __iomem		*regs;
 
@@ -705,6 +719,10 @@ struct dwc3_ep {
 
 	unsigned		direction:1;
 	unsigned		stream_capable:1;
+
+	/* For isochronous START TRANSFER workaround only */
+	u8			combo_num;
+	int			start_cmd_status;
 };
 
 enum dwc3_phy {
@@ -766,6 +784,7 @@ enum dwc3_link_state {
 #define DWC3_TRB_CTRL_ISP_IMI		BIT(10)
 #define DWC3_TRB_CTRL_IOC		BIT(11)
 #define DWC3_TRB_CTRL_SID_SOFN(n)	(((n) & 0xffff) << 14)
+#define DWC3_TRB_CTRL_GET_SID_SOFN(n)	(((n) & (0xffff << 14)) >> 14)
 
 #define DWC3_TRBCTL_TYPE(n)		((n) & (0x3f << 4))
 #define DWC3_TRBCTL_NORMAL		DWC3_TRB_CTRL_TRBCTL(1)
@@ -847,11 +866,12 @@ struct dwc3_hwparams {
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
- * @unaligned: true for OUT endpoints with length not divisible by maxp
+ * @num_trbs: number of TRBs used by this request
+ * @needs_extra_trb: true when request needs one extra TRB (either due to ZLP
+ *	or unaligned OUT)
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
  * @started: request is started
- * @zero: wants a ZLP
  */
 struct dwc3_request {
 	struct usb_request	request;
@@ -867,11 +887,12 @@ struct dwc3_request {
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
-	unsigned		unaligned:1;
+	unsigned		num_trbs;
+
+	unsigned		needs_extra_trb:1;
 	unsigned		direction:1;
 	unsigned		mapped:1;
 	unsigned		started:1;
-	unsigned		zero:1;
 };
 
 /*
@@ -918,6 +939,7 @@ struct dwc3_scratchpad_array {
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
+ * @version_type: VERSIONTYPE register contents, a sub release of a revision
  * @dr_mode: requested mode of operation
  * @current_dr_role: current role of operation when in dual-role mode
  * @desired_dr_role: desired role of operation when in dual-role mode
@@ -945,6 +967,7 @@ struct dwc3_scratchpad_array {
  * @hwparams: copy of hwparams registers
  * @root: debugfs root folder pointer
  * @regset: debugfs pointer to regdump file
+ * @dbg_lsp_select: current debug lsp mux register selection
  * @test_mode: true when we're entering a USB test mode
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
@@ -970,7 +993,10 @@ struct dwc3_scratchpad_array {
  * @pullups_connected: true when Run/Stop bit is set
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @three_stage_setup: set if we perform a three phase setup
+ * @dis_start_transfer_quirk: set if start_transfer failure SW workaround is
+ *			not needed for DWC_usb31 version 1.70a-ea06 and below
  * @usb3_lpm_capable: set if hadrware supports Link Power Management
+ * @usb2_lpm_disable: set to disable usb2 lpm
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
@@ -1095,6 +1121,7 @@ struct dwc3 {
 #define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_330A	0x5533330a
 
 /*
  * NOTICE: we're using bit 31 as a "is usb 3.1" flag. This is really
@@ -1103,6 +1130,17 @@ struct dwc3 {
 #define DWC3_REVISION_IS_DWC31		0x80000000
 #define DWC3_USB31_REVISION_110A	(0x3131302a | DWC3_REVISION_IS_DWC31)
 #define DWC3_USB31_REVISION_120A	(0x3132302a | DWC3_REVISION_IS_DWC31)
+#define DWC3_USB31_REVISION_160A	(0x3136302a | DWC3_REVISION_IS_DWC31)
+#define DWC3_USB31_REVISION_170A	(0x3137302a | DWC3_REVISION_IS_DWC31)
+
+	u32			version_type;
+
+#define DWC31_VERSIONTYPE_EA01		0x65613031
+#define DWC31_VERSIONTYPE_EA02		0x65613032
+#define DWC31_VERSIONTYPE_EA03		0x65613033
+#define DWC31_VERSIONTYPE_EA04		0x65613034
+#define DWC31_VERSIONTYPE_EA05		0x65613035
+#define DWC31_VERSIONTYPE_EA06		0x65613036
 
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
@@ -1121,6 +1159,8 @@ struct dwc3 {
 	struct dentry		*root;
 	struct debugfs_regset32	*regset;
 
+	u32			dbg_lsp_select;
+
 	u8			test_mode;
 	u8			test_mode_nr;
 	u8			lpm_nyet_threshold;
@@ -1145,7 +1185,9 @@ struct dwc3 {
 	unsigned		pullups_connected:1;
 	unsigned		setup_packet_pending:1;
 	unsigned		three_stage_setup:1;
+	unsigned		dis_start_transfer_quirk:1;
 	unsigned		usb3_lpm_capable:1;
+	unsigned		usb2_lpm_disable:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index c66d216dcc30..4f75ab3505b7 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -116,6 +116,35 @@ dwc3_gadget_link_string(enum dwc3_link_state link_state)
 	}
 }
 
+/**
+ * dwc3_gadget_hs_link_string - returns highspeed and below link name
+ * @link_state: link state code
+ */
+static inline const char *
+dwc3_gadget_hs_link_string(enum dwc3_link_state link_state)
+{
+	switch (link_state) {
+	case DWC3_LINK_STATE_U0:
+		return "On";
+	case DWC3_LINK_STATE_U2:
+		return "Sleep";
+	case DWC3_LINK_STATE_U3:
+		return "Suspend";
+	case DWC3_LINK_STATE_SS_DIS:
+		return "Disconnected";
+	case DWC3_LINK_STATE_RX_DET:
+		return "Early Suspend";
+	case DWC3_LINK_STATE_RECOV:
+		return "Recovery";
+	case DWC3_LINK_STATE_RESET:
+		return "Reset";
+	case DWC3_LINK_STATE_RESUME:
+		return "Resume";
+	default:
+		return "UNKNOWN link state\n";
+	}
+}
+
 /**
  * dwc3_trb_type_string - returns TRB type as a string
  * @type: the type of the TRB
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9f92ee03dde7..6c9b76bcc2e1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -27,7 +27,7 @@
 #include "gadget.h"
 #include "io.h"
 
-#define DWC3_ALIGN_FRAME(d)	(((d)->frame_number + (d)->interval) \
+#define DWC3_ALIGN_FRAME(d, n)	(((d)->frame_number + ((d)->interval * (n))) \
 					& ~((d)->interval - 1))
 
 /**
@@ -177,6 +177,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 	req->started = false;
 	list_del(&req->list);
 	req->remaining = 0;
+	req->needs_extra_trb = false;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
@@ -647,8 +648,6 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
-		init_waitqueue_head(&dep->wait_end_transfer);
-
 		if (usb_endpoint_xfer_control(desc))
 			goto out;
 
@@ -672,7 +671,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
@@ -919,8 +918,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -990,16 +987,20 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 				usb_endpoint_type(dep->endpoint.desc));
 	}
 
-	/* always enable Continue on Short Packet */
+	/*
+	 * Enable Continue on Short Packet
+	 * when endpoint is not a stream capable
+	 */
 	if (usb_endpoint_dir_out(dep->endpoint.desc)) {
-		trb->ctrl |= DWC3_TRB_CTRL_CSP;
+		if (!dep->stream_capable)
+			trb->ctrl |= DWC3_TRB_CTRL_CSP;
 
 		if (short_not_ok)
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1010,6 +1011,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
@@ -1046,6 +1049,8 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
 	}
 
+	req->num_trbs++;
+
 	__dwc3_prepare_one_trb(dep, trb, dma, length, chain, node,
 			stream_id, short_not_ok, no_interrupt);
 }
@@ -1073,13 +1078,14 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			struct dwc3	*dwc = dep->dwc;
 			struct dwc3_trb	*trb;
 
-			req->unaligned = true;
+			req->needs_extra_trb = true;
 
 			/* prepare normal TRB */
 			dwc3_prepare_one_trb(dep, req, true, i);
 
 			/* Now prepare one extra TRB to align transfer size */
 			trb = &dep->trb_pool[dep->trb_enqueue];
+			req->num_trbs++;
 			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
 					maxp - rem, false, 1,
 					req->request.stream_id,
@@ -1113,17 +1119,18 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 	unsigned int rem = length % maxp;
 
-	if (rem && usb_endpoint_dir_out(dep->endpoint.desc)) {
+	if ((!length || rem) && usb_endpoint_dir_out(dep->endpoint.desc)) {
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
 
-		req->unaligned = true;
+		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
 		dwc3_prepare_one_trb(dep, req, true, 0);
 
 		/* Now prepare one extra TRB to align transfer size */
 		trb = &dep->trb_pool[dep->trb_enqueue];
+		req->num_trbs++;
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
 				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
@@ -1133,13 +1140,14 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
 
-		req->zero = true;
+		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
 		dwc3_prepare_one_trb(dep, req, true, 0);
 
 		/* Now prepare one extra TRB to handle ZLP */
 		trb = &dep->trb_pool[dep->trb_enqueue];
+		req->num_trbs++;
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
 				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
@@ -1232,6 +1240,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		params.param1 = lower_32_bits(req->trb_dma);
 		cmd = DWC3_DEPCMD_STARTTRANSFER;
 
+		if (dep->stream_capable)
+			cmd |= DWC3_DEPCMD_PARAM(req->request.stream_id);
+
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
@@ -1263,17 +1274,151 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 	return DWC3_DSTS_SOFFN(reg);
 }
 
-static void __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
+/**
+ * dwc3_gadget_start_isoc_quirk - workaround invalid frame number
+ * @dep: isoc endpoint
+ *
+ * This function tests for the correct combination of BIT[15:14] from the 16-bit
+ * microframe number reported by the XferNotReady event for the future frame
+ * number to start the isoc transfer.
+ *
+ * In DWC_usb31 version 1.70a-ea06 and prior, for highspeed and fullspeed
+ * isochronous IN, BIT[15:14] of the 16-bit microframe number reported by the
+ * XferNotReady event are invalid. The driver uses this number to schedule the
+ * isochronous transfer and passes it to the START TRANSFER command. Because
+ * this number is invalid, the command may fail. If BIT[15:14] matches the
+ * internal 16-bit microframe, the START TRANSFER command will pass and the
+ * transfer will start at the scheduled time, if it is off by 1, the command
+ * will still pass, but the transfer will start 2 seconds in the future. For all
+ * other conditions, the START TRANSFER command will fail with bus-expiry.
+ *
+ * In order to workaround this issue, we can test for the correct combination of
+ * BIT[15:14] by sending START TRANSFER commands with different values of
+ * BIT[15:14]: 'b00, 'b01, 'b10, and 'b11. Each combination is 2^14 uframe apart
+ * (or 2 seconds). 4 seconds into the future will result in a bus-expiry status.
+ * As the result, within the 4 possible combinations for BIT[15:14], there will
+ * be 2 successful and 2 failure START COMMAND status. One of the 2 successful
+ * command status will result in a 2-second delay start. The smaller BIT[15:14]
+ * value is the correct combination.
+ *
+ * Since there are only 4 outcomes and the results are ordered, we can simply
+ * test 2 START TRANSFER commands with BIT[15:14] combinations 'b00 and 'b01 to
+ * deduce the smaller successful combination.
+ *
+ * Let test0 = test status for combination 'b00 and test1 = test status for 'b01
+ * of BIT[15:14]. The correct combination is as follow:
+ *
+ * if test0 fails and test1 passes, BIT[15:14] is 'b01
+ * if test0 fails and test1 fails, BIT[15:14] is 'b10
+ * if test0 passes and test1 fails, BIT[15:14] is 'b11
+ * if test0 passes and test1 passes, BIT[15:14] is 'b00
+ *
+ * Synopsys STAR 9001202023: Wrong microframe number for isochronous IN
+ * endpoints.
+ */
+static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 {
+	int cmd_status = 0;
+	bool test0;
+	bool test1;
+
+	while (dep->combo_num < 2) {
+		struct dwc3_gadget_ep_cmd_params params;
+		u32 test_frame_number;
+		u32 cmd;
+
+		/*
+		 * Check if we can start isoc transfer on the next interval or
+		 * 4 uframes in the future with BIT[15:14] as dep->combo_num
+		 */
+		test_frame_number = dep->frame_number & 0x3fff;
+		test_frame_number |= dep->combo_num << 14;
+		test_frame_number += max_t(u32, 4, dep->interval);
+
+		params.param0 = upper_32_bits(dep->dwc->bounce_addr);
+		params.param1 = lower_32_bits(dep->dwc->bounce_addr);
+
+		cmd = DWC3_DEPCMD_STARTTRANSFER;
+		cmd |= DWC3_DEPCMD_PARAM(test_frame_number);
+		cmd_status = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+
+		/* Redo if some other failure beside bus-expiry is received */
+		if (cmd_status && cmd_status != -EAGAIN) {
+			dep->start_cmd_status = 0;
+			dep->combo_num = 0;
+			return 0;
+		}
+
+		/* Store the first test status */
+		if (dep->combo_num == 0)
+			dep->start_cmd_status = cmd_status;
+
+		dep->combo_num++;
+
+		/*
+		 * End the transfer if the START_TRANSFER command is successful
+		 * to wait for the next XferNotReady to test the command again
+		 */
+		if (cmd_status == 0) {
+			dwc3_stop_active_transfer(dep, true);
+			return 0;
+		}
+	}
+
+	/* test0 and test1 are both completed at this point */
+	test0 = (dep->start_cmd_status == 0);
+	test1 = (cmd_status == 0);
+
+	if (!test0 && test1)
+		dep->combo_num = 1;
+	else if (!test0 && !test1)
+		dep->combo_num = 2;
+	else if (test0 && !test1)
+		dep->combo_num = 3;
+	else if (test0 && test1)
+		dep->combo_num = 0;
+
+	dep->frame_number &= 0x3fff;
+	dep->frame_number |= dep->combo_num << 14;
+	dep->frame_number += max_t(u32, 4, dep->interval);
+
+	/* Reinitialize test variables */
+	dep->start_cmd_status = 0;
+	dep->combo_num = 0;
+
+	return __dwc3_gadget_kick_transfer(dep);
+}
+
+static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	int ret;
+	int i;
+
 	if (list_empty(&dep->pending_list)) {
-		dev_info(dep->dwc->dev, "%s: ran out of requests\n",
-				dep->name);
 		dep->flags |= DWC3_EP_PENDING_REQUEST;
-		return;
+		return -EAGAIN;
 	}
 
-	dep->frame_number = DWC3_ALIGN_FRAME(dep);
-	__dwc3_gadget_kick_transfer(dep);
+	if (!dwc->dis_start_transfer_quirk && dwc3_is_usb31(dwc) &&
+	    (dwc->revision <= DWC3_USB31_REVISION_160A ||
+	     (dwc->revision == DWC3_USB31_REVISION_170A &&
+	      dwc->version_type >= DWC31_VERSIONTYPE_EA01 &&
+	      dwc->version_type <= DWC31_VERSIONTYPE_EA06))) {
+
+		if (dwc->gadget.speed <= USB_SPEED_HIGH && dep->direction)
+			return dwc3_gadget_start_isoc_quirk(dep);
+	}
+
+	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
+		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
+
+		ret = __dwc3_gadget_kick_transfer(dep);
+		if (ret != -EAGAIN)
+			break;
+	}
+
+	return ret;
 }
 
 static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
@@ -1314,8 +1459,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 		if ((dep->flags & DWC3_EP_PENDING_REQUEST)) {
 			if (!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
-				__dwc3_gadget_start_isoc(dep);
-				return 0;
+				return __dwc3_gadget_start_isoc(dep);
 			}
 		}
 	}
@@ -1341,6 +1485,40 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	return ret;
 }
 
+static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *req)
+{
+	int i;
+
+	/*
+	 * If request was already started, this means we had to
+	 * stop the transfer. With that we also need to ignore
+	 * all TRBs used by the request, however TRBs can only
+	 * be modified after completion of END_TRANSFER
+	 * command. So what we do here is that we wait for
+	 * END_TRANSFER completion and only after that, we jump
+	 * over TRBs by clearing HWO and incrementing dequeue
+	 * pointer.
+	 */
+	for (i = 0; i < req->num_trbs; i++) {
+		struct dwc3_trb *trb;
+
+		trb = req->trb + i;
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		dwc3_ep_inc_deq(dep);
+	}
+}
+
+static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
+{
+	struct dwc3_request		*req;
+	struct dwc3_request		*tmp;
+
+	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
+		dwc3_gadget_ep_skip_trbs(dep, req);
+		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+	}
+}
+
 static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		struct usb_request *request)
 {
@@ -1371,68 +1549,11 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dep, true);
 
-			/*
-			 * If request was already started, this means we had to
-			 * stop the transfer. With that we also need to ignore
-			 * all TRBs used by the request, however TRBs can only
-			 * be modified after completion of END_TRANSFER
-			 * command. So what we do here is that we wait for
-			 * END_TRANSFER completion and only after that, we jump
-			 * over TRBs by clearing HWO and incrementing dequeue
-			 * pointer.
-			 *
-			 * Note that we have 2 possible types of transfers here:
-			 *
-			 * i) Linear buffer request
-			 * ii) SG-list based request
-			 *
-			 * SG-list based requests will have r->num_pending_sgs
-			 * set to a valid number (> 0). Linear requests,
-			 * normally use a single TRB.
-			 *
-			 * For each of these two cases, if r->unaligned flag is
-			 * set, one extra TRB has been used to align transfer
-			 * size to wMaxPacketSize.
-			 *
-			 * All of these cases need to be taken into
-			 * consideration so we don't mess up our TRB ring
-			 * pointers.
-			 */
-			wait_event_lock_irq(dep->wait_end_transfer,
-					!(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
-					dwc->lock);
-
 			if (!r->trb)
 				goto out0;
 
-			if (r->num_pending_sgs) {
-				struct dwc3_trb *trb;
-				int i = 0;
-
-				for (i = 0; i < r->num_pending_sgs; i++) {
-					trb = r->trb + i;
-					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
-					dwc3_ep_inc_deq(dep);
-				}
-
-				if (r->unaligned || r->zero) {
-					trb = r->trb + r->num_pending_sgs + 1;
-					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
-					dwc3_ep_inc_deq(dep);
-				}
-			} else {
-				struct dwc3_trb *trb = r->trb;
-
-				trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
-				dwc3_ep_inc_deq(dep);
-
-				if (r->unaligned || r->zero) {
-					trb = r->trb + 1;
-					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
-					dwc3_ep_inc_deq(dep);
-				}
-			}
-			goto out1;
+			dwc3_gadget_move_cancelled_request(req);
+			goto out0;
 		}
 		dev_err(dwc->dev, "request %pK was not queued to %s\n",
 				request, ep->name);
@@ -1440,9 +1561,6 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		goto out0;
 	}
 
-out1:
-	/* giveback the request */
-
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
 out0:
@@ -1867,6 +1985,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
@@ -1934,8 +2053,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
-	int			epnum;
-	u32			tmo_eps = 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
@@ -1944,36 +2061,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	__dwc3_gadget_stop(dwc);
 
-	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
-		struct dwc3_ep  *dep = dwc->eps[epnum];
-		int ret;
-
-		if (!dep)
-			continue;
-
-		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
-			continue;
-
-		ret = wait_event_interruptible_lock_irq_timeout(dep->wait_end_transfer,
-			    !(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
-			    dwc->lock, msecs_to_jiffies(5));
-
-		if (ret <= 0) {
-			/* Timed out or interrupted! There's nothing much
-			 * we can do so we just log here and print which
-			 * endpoints timed out at the end.
-			 */
-			tmo_eps |= 1 << epnum;
-			dep->flags &= DWC3_EP_END_TRANSFER_PENDING;
-		}
-	}
-
-	if (tmo_eps) {
-		dev_err(dwc->dev,
-			"end transfer timed out on endpoints 0x%x [bitmap]\n",
-			tmo_eps);
-	}
-
 out:
 	dwc->gadget_driver	= NULL;
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -2148,6 +2235,8 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	dep->direction = direction;
 	dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
 	dwc->eps[epnum] = dep;
+	dep->combo_num = 0;
+	dep->start_cmd_status = 0;
 
 	snprintf(dep->name, sizeof(dep->name), "ep%u%s", num,
 			direction ? "in" : "out");
@@ -2176,6 +2265,7 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
+	INIT_LIST_HEAD(&dep->cancelled_list);
 
 	return 0;
 }
@@ -2235,6 +2325,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	dwc3_ep_inc_deq(dep);
 
 	trace_dwc3_complete_trb(dep, trb);
+	req->num_trbs--;
 
 	/*
 	 * If we're in the middle of series of chained TRBs and we
@@ -2249,12 +2340,26 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (chain && (trb->ctrl & DWC3_TRB_CTRL_HWO))
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 
+	/*
+	 * For isochronous transfers, the first TRB in a service interval must
+	 * have the Isoc-First type. Track and report its interval frame number.
+	 */
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+	    (trb->ctrl & DWC3_TRBCTL_ISOCHRONOUS_FIRST)) {
+		unsigned int frame_number;
+
+		frame_number = DWC3_TRB_CTRL_GET_SID_SOFN(trb->ctrl);
+		frame_number &= ~(dep->interval - 1);
+		req->request.frame_number = frame_number;
+	}
+
 	/*
 	 * If we're dealing with unaligned size OUT transfer, we will be left
 	 * with one TRB pending in the ring. We need to manually clear HWO bit
 	 * from that TRB.
 	 */
-	if ((req->zero || req->unaligned) && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
+
+	if (req->needs_extra_trb && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}
@@ -2331,11 +2436,10 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
 
-	if (req->unaligned || req->zero) {
+	if (req->needs_extra_trb) {
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
-		req->unaligned = false;
-		req->zero = false;
+		req->needs_extra_trb = false;
 	}
 
 	req->request.actual = req->request.length - req->remaining;
@@ -2430,7 +2534,7 @@ static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
 	dwc3_gadget_endpoint_frame_from_event(dep, event);
-	__dwc3_gadget_start_isoc(dep);
+	(void) __dwc3_gadget_start_isoc(dep);
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -2468,7 +2572,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
 			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
-			wake_up(&dep->wait_end_transfer);
+			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
@@ -3277,6 +3381,8 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
+	synchronize_irq(dwc->irq_gadget);
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 2aacd1afd9ff..023a473648eb 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -79,6 +79,21 @@ static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 	list_move_tail(&req->list, &dep->started_list);
 }
 
+/**
+ * dwc3_gadget_move_cancelled_request - move @req to the cancelled_list
+ * @req: the request to be moved
+ *
+ * Caller should take care of locking. This function will move @req from its
+ * current list to the endpoint's cancelled_list.
+ */
+static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req)
+{
+	struct dwc3_ep		*dep = req->dep;
+
+	req->started = false;
+	list_move_tail(&req->list, &dep->cancelled_list);
+}
+
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status);
 
-- 
2.53.0

