Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE1606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NcvxMLLC;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GV/dEyIf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 296D5810F7;
	Wed, 28 Oct 2026 14:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEKyLHxiFJlS; Wed, 28 Oct 2026 14:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 095C280D58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198786;
	b=AAea1OKkIMii2Bst1K1kU9I+LhcrpOdE876QJhtOckMqlUtpzHY2YygwmtZUJR2/unvO
	 Lt9JQeAtWdpTQqr5xnu8VoazjRRt74SrMpcFBOA+Bk0mmhr9PN/zEipJvkA3lBK5X252G
	 9Zs5/yuMCtnz+K1WuKNTdmk4NsRrpQ7WjoP1A0vvxEvMVjV8jjMhRFykrJwsi/6UwcvSs
	 LnqDgympx991H2+Q4/zYnVQp0/VcYEYKNk2+7qPN98CvAJ3RXwFJKeUOxvvQttQPEfHD3
	 DPM6cAC8X6Kzae7J1S6I5adWfn+XUyufsHYs5DD8uiKWEHPwuZ9o0QTk+CAIVqAVbVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
	b=Zn6CAn1DumBh2pokjSoffWDgGRUV6ZfN1OHgHEy/jx//9GeIuFAHUb6SCdOYJglc01D/
	 +SivIi6Jo4PiUQ3oDTKtK0IETyUhzuldVIJb/Q2Dk1DGjms1gMD7oymQueNA4VCLT0PO0
	 ScgFWz4oOxjTe58Ovd5fvdwdd3fm4+SnSk174Hbd/ForFuh78o41oZ3jyjdlJouFvd2HJ
	 fynwjQz2Xy/qTCPjVYehwexr+FG7enmz1GdSq0a19xFCOqPyIfw2RpHk+f1RRnaDQxvQW
	 nG+M++DJViphwS2uzfXvlCGWyOGGObQDN88uSOMXMisUf7Amp/BvWkr/PqlcF3HauMw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198786;
	bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NcvxMLLCEbKgk/ZM7ZIOWJSeewC/llsxSF+wDUv511uWsek+O1GVfsWRnJlRBqzX4
	 POkSFpdsN8GKDTUmNUg3aBwS0nt4H48S/QlVaaolObjTYKsdtkYEuBHdmvKhpyirP7
	 pWcrpUkUGadSdY2NKQeCJVDe9C4Wqprkbt+K5gIVlvFF2ciJbEUJq6BI8+FcvLtWvG
	 L0z+OYOqViB+7mRds1bZpGWqZfmjVeXA4h4By9KJ/+5JcdiwiCfPInkU3sunle7RQA
	 VPZJtGiPbH/xHcjhw5PaAmHzDHb5z6LxkCmNuFA5AaUUIu3vtXhpbnFnSPII5Mazji
	 4PvyKAoRtPzKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 095C280D58;
	Wed, 28 Oct 2026 14:46:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6B14529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97C1D6060B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJNJcmJf2K2B for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C288605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196665;
 b=S36rW2MJG0wRnhAGIfl3Jfx2ma8zubbuUC4pWnWcq2mZC2qSgwrndBVQUwGnqH5iySQi
 SxjT6/gK9FtAnNQ3ESjvM3uXjZbdwyns4adeOJ1XoMml5fYTujtQXB03I+vPqe+13mnja
 VttmYQOfKyVNAT/YuJ6fUg0J5Ib56AuJ8bQTo4d6cgami9nh5vOMh6bIEkRRf7RDLk1+O
 4Zc7eAo67Zm9781KnO3i1+TbfUb4WvSnyUPa8hADFiwIwlBjBakxL17x6dQ7CsqaUVMyZ
 hnvOrsCqSkz0S38omhcMA45jlx19zFrwnD4OJrcUzf0rjHJZ6OxEb1XL0AnPGzmWDvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
 b=hHVM9IMUdCofpZFTP3+v9VgKfDUtRGOKMFAaNRcCGwIK4XhAUj45NJOKVBH37QLVyovY
 8PdIJmRlrHMu0OJd+Z97m4KrwOvAOGN4/Jchou6ANazYI9RfSXruQANHIOUXAce7eLcMk
 x3Xy5T9jeKfOS2nW8Iad680Gj7FU7oi32G+jtDCw7xvtxyRhskEcThcASLZtgXbVgSbZi
 F2+7GvLryKNNq5oQHfjICbQ++wFAZVvM7mU4JW2sgMwhI4cX65F65HG1IPUKd5prxe75+
 j+5diXf4pWjJ1fmUJh7+Iti4TXjvMtjb3HB7t7u1+oHJ/MmfPqTdOd2BDl6F3lYdq+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="GV/dEyIf"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GV/dEyIf
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C288605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:03 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c33700b6435so16127766b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196662; x=1793801462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
 b=GV/dEyIfuoujVAIDwsob5uHZfgIKt/ZbwEzl/GPJdqNyOgMtl9piy1cyTKEduLRf7f
 XMQVWvP2uWUihlPTj5tR0AxHrPJHGIeIrOGhe17f09UY1aNfSr5zhvdHFLEuoPXZp2/3
 ijYcSyZhJzri7IzlL2obCQYNkuMoNqplbN2SqoM/+sOm2sR1EZ2SA/XFJxC0HDMgI19O
 fYQDoXwFdmAZ5BbCd+JRTp4UohLlyq3ttyPQhmokaiZNtaC2/HQTArWfsD5AACT1IocX
 cY2YtaEbpywcrKR6g7PY39wIiZrs/YKTHJjM3YRc0/1AowEToyyk23N8z70bMvBNezUN
 lzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196662; x=1793801462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
 b=mNHeesZ+SjdCBiXB2Xr4fLfntsicWZhudbo5wxOOLhr3raUY+O1UIjTtaGQmzoZmEb
 INAidHJz+Wt8V7TBhOZ/ZOHsvqlhwVMN9xWjwp9e91wLPfWinN/ob5/dCAceI/gLFG2t
 OsmT1DayVjQs7H2n1/78Nr3+llEFaWPdy9aznuMxsaDy1HZLUoBmYRd8p7BiOFzRifew
 QM4Rw93Fud2PmBsRMeqfTXslUgOFpIL9bRQckgO5uG/0YT6VtjH1aSkOpTaT8lILQFCe
 w62vGbGP3FdGdhDCSGaqQPTIrCnZI3P8uihRhaeDbzJVs5+1bjPmShkFgeklRHwwvfKr
 jvuQ==
X-Gm-Message-State: AFq9FYJPB9o3bCtRaqB9Fty5qv816GRLqUzOcLTfOMN/oX/rNbCPGdJx
 /GPZYAjGTzMxeLed5L805iJMaBN377JBRm3f19pd8cxfjEiXH/uxI1DlOzw8Rf14GfMUlipYir5
 MK88X
X-Gm-Gg: AYBFou2WMvS0Xc2G8Z68sL3V+YygmcedbT/w3lWy2fYTE6TIH7Eu/Sq9XaAMlha28or
 NlklIRdsjIjK+r8T78d5IxeOYhH9tYlGhYJmvOYTJcaGGu/f0yyDlss2NgQdRqH/RNuYaQMYgzS
 Ah/bAt9d82hkcdreQiVCcttS5CI72RicOmLqUp6k/Hb/HHJRpUhfKXlpzdGygYOpnUYS6etbdxd
 u2SwuDWd22D/rH6yOAynZu9zoyIE2Kpv4EqpAmMR3QRypsiqWOZYLa+BARXEcVtv7jkiOdVJivZ
 8khXVOf9UtIzQ7cDt8Q6Fajc8HQ8l+1QPKLXURrtrciXQenVaeIkYqfIuQOdKM4PjpzGiCoK+y/
 vQJ8p/S9Gs8O/O08Hxc6SmIeApSmfrJiLUpRzVOn6FRnX8zh014ye259yMUtWj3vDNCHjt4TmJ0
 Vi1HdeV2yX7hmXOQd+qHbmagkr4qrh0o0gUt6PkIrAPJRd/z31c/InnyexnC0+O9nmFUzJuLeym
 9hI6Yab5i/ldlg5EPb6DNTwZVSwYjg18pK96yYCsgsrkdTC1tiXT3db9qdHhKsLHEHGAGasRMoT
 fPgKtdnHYg8A2C0wqhoEYwne96J9zlmQJPCxNtz9VNJgOCMdjFMFymHK6etTK1yoMh5BaKRDghy
 uwpC3F+GVFA==
X-Received: by 2002:a17:906:8f14:b0:c46:ae89:cd3c with SMTP id
 a640c23a62f3a-c49bddd28ddmr277995766b.1.1793196662190; 
 Wed, 28 Oct 2026 07:11:02 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 18/63] usb: dwc3: import from kernel v4.14
Date: Wed, 28 Oct 2026 15:08:44 +0100
Message-ID: <20261028140930.3025368-19-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.13 to v4.14.

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

List of commits: git log --oneline v4.13..v4.14
Commits imported:
551684708356 usb: dwc3: ep0: fix DMA starvation by assigning req->trb on ep0

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 827e376bfa97..75e6cb044eb2 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -990,6 +990,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 maxpacket - rem,
@@ -1015,6 +1017,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 0, DWC3_TRBCTL_CONTROL_DATA,
@@ -1029,6 +1033,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
+
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-- 
2.53.0

