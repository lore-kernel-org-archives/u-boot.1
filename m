Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1298ACA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D099A80C33;
	Mon, 12 Oct 2026 22:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Jjr5aqKYk3n; Mon, 12 Oct 2026 22:28:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CCE880C26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844097;
	b=NfNmsyUK+eL0io/UQiQkDy49u9O77RhQfMjXLx5bxCekoP1RDeW6QR503ZWzTnj85gj7
	 vrhUnbxdeJeN2tUQO1y8XBRBXCinXLuHR9YOeNx2KztIb1uOKBBKLp9/p9LuQIc8sEuQZ
	 Zge4/wODamSQg5SGhi19x8MvIM6KhiAIZA+/hcHx0wveXuBkWU09Lx1HgbprT+0TEnF78
	 plPLrGDzpDLMYfG3qwjsgco/0d27snDEDB4And8FubLXPBJYOTI23DoCZDn1D9DuGwbbn
	 B7bCb8cnC1H+n4fue+I2Mho70VVK65GgkXy60nbqtlGCRYZSMIgvtXKUbpaYBPDzn1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Q/lGE5QRYixZgqKzhBMrEaRgl9SLZBsYRXsKMHJwclw=;
	b=YYLwl44EfXmsK2L03OSSahLVa1Q/ETKpuhInhbNf9D+LYpjuFFt7M3uTMHxZe13DoTZJ
	 psfhA3xa8+Lo0joZogTh+ILMWAEyEk+43sEYIrwOTvcoAzbxVYPYjqaZ23pJ5Lmt7AUeS
	 pVFJPNQSxDFv6ThueQp4HSAr7UGEBXFOJomb+hTLSKKjlzXViLK82VPud9UslvEiKzJmW
	 IbxUt4Vzl1pvBe6oAej22V0f3ciQAeI97KrCeTzWJIpjfH8xjS15JrJEMuFuCKnNvggcn
	 5jXp/WYcMBMTt0NffFImodNs5cFRLQ+rY2Xse3+WHfplRFaDM374aDmkbCJuXjGsOUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lsb7hjNC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844097;
	bh=Q/lGE5QRYixZgqKzhBMrEaRgl9SLZBsYRXsKMHJwclw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+v+DreN0s+97JfeVXD9eYw+Y+0gHmh1sNSKp7yXB3j8NGPUcIV641aUhmPjYGC5t
	 DsXU52tI/lyu3ViozsfJw2tQMvKahnjfsUyuELXliqoKx7IV+q9f27dGBzUfZlApAp
	 Fqx7ri+FVo2AkH9Ehapq2iU2uZyY2rbrBSf7fR/8eExlLxqm7+mWWsu0zUJklJ6gxl
	 KHKy74PaKeiMjEHJLahcRkn4BjaDTg/wJNttgiQzXnipnFKH2JJG00J1fGp3lj6tVd
	 NU5dOVdRN+oIqpC95+G3ImqBBVoT8J0hn+m7idJPcS+x5KNw+qrllfajHUVO3EgalO
	 4iDGTS0NoO5Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CCE880C26;
	Mon, 12 Oct 2026 22:28:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CABF74DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC82680BF7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7q-_Thq-oMo for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEA2780BD6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844090;
 b=lxzCEAmGa6wk/kWmSf1Rt95bf5Fdi5YJuNqjpAqJr3DtxNc0nUd5aiwdl4lV26epUkwx
 F8ujpjOFL8uxTx7Z7rvRhgCwmG8P5hMwp/hCPA5mJELkRt3G7GhgYK8OSjUwsfBAxYzts
 tPn+494XJQU7HIeAhogfiMxsRVWiRLq5NyCgghuTy1zWo1469XNsQiVdjW3axbkCB/01e
 nYu5zPRdIxkebnFHx+/Qs2z+e+/qCNSjZy2UHs7SZtErat5z5WqBjBs5MklN+axBbGPLL
 1v7TDVfTguU8dzxAm7lgqaZ1rQFmTSjNMLsHldjdOhlNytO+p4A3iVUDKHDbMjK1KGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844090;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Q/lGE5QRYixZgqKzhBMrEaRgl9SLZBsYRXsKMHJwclw=;
 b=fU+UvzYZ7+a/OZXgtrhH8J6d8LapcBajkv9/nkRd7Uwk8UasCyQhh1ID5XxqZzwy+7HM
 oNE58Iyelecev6NxW5R6fb8Pp9SmKfmzqCoZRB9t8Dk3AG5nHieg06m/zQcTo3ewu3FbC
 m9L8UKJ45uwVRHPnF/fhm5QUB/MQfzu6j8oXZQ+YPCQVm+oEQ/urQdAax0nLbuuF4OTA3
 5pFCWJW4fAeq2RWlgz2iqBFTlzmJKq+g8eT86IADgCPW1sv2CXRK9uaNxNsAt9hPOBdac
 1L4ASSc+Sev0SfvP3b8NV/CdBz08sa+73qnbx9QGLrYMceUY7xshsrsWa3X45VDqUsw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Lsb7hjNC; 
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Lsb7hjNC
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DEA2780BD6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:09 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-49e1251674cso939754fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844088; x=1792448888;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q/lGE5QRYixZgqKzhBMrEaRgl9SLZBsYRXsKMHJwclw=;
 b=Lsb7hjNCuBrYVJv6GyM4xrEvpVHR0a8vwJ1rWHbWygq9edZ9M6U2xwQNooszoweFXs
 fDRah6sBEPMYiQuIyB3GSkae52cXKC0GGtwKEsdNZvduCieCgX6ylMszk6CXvzN62w04
 vE0v68z9Y5skYn+6MgKy+OyuVGL0sLEjoU+mHIn63WXHzj9JFTCl4d/IbKdNQWBXQU8U
 SNnubxZ9BCTRNKVwQNMbmg3QsJ09vqv80FfiMMx+YgnM46L40pctFwTQ8WnW+SK4YZPE
 4OiJPEq0isVmLd/W/Eg6gqXrbEK4uCZecUTYLYJZk8+3Hxjq0xt2lyiSU0C9W02w5aIp
 M4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844088; x=1792448888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q/lGE5QRYixZgqKzhBMrEaRgl9SLZBsYRXsKMHJwclw=;
 b=jBDCGBgILxlpHRymZFwlkaGj8nuc+yKmqbkdup3MS6UsCVLk/tvX325lt0Tl4IUUPO
 u1oKOSVPp3uwlPDTUIk48BhDpMX3o95ZeK9Dbvcxcs+zhtUo19VtrndQQB6WR7TfZl2d
 I9F38M0fe8aQaa+xtZymsUFQHam9iVmQEjiaLnAT3uiaL05liN2GRjHD/80Ry4VurRmi
 Au83GphNc3cCBnXbSw4vvds5iW6EA2cuqwrZQvFDIvz2tYf5a8/V9pBT4DUmh2rBvotE
 FK35gX7t9gaFCniOwZqu79uWO80OhsPibqCaPAitaZdkE9gWOk0w6dkAOXsqGV7sUzTX
 XhoA==
X-Gm-Message-State: AFq9FYIL+If3H/OuWNNn4LQIiRmZBGwdRYEXZLY/u0TRWsy8lnau980l
 T8dFxgdb89ey/0+5uSkleAbU2jrspqCb23wTk0qXPLkFB2igOi1d3yXI
X-Gm-Gg: AYBFou2slo4XnZ7zU6C3u2l0MIv2sJqpU1kqfGLLMXwANLqQ49R30ordwDr3hh9R+Y/
 5H9QXvgUwLQgbl/D/KbzOLN+WrUKl9mChAr5U1nDFSFVzEpn6W2GZKN7b28QaV8yxdKHAl346L8
 /cSoXCPh37bSUWs9VGXoWRvFodauT64HLuBex2wFiL1HlxHUP4cVGNxrdCFTGPFE/srw1EtLDAX
 OYqwAMcK6jP2Tf00Le9S/EnuvGpK9FlkPHnU5EVcJQ7z5SZ/HV0BzSC3Tl0wWA27CPO6g68kIip
 DB2LUaF6wuYZUBklWRjUZ+mOOR2M6/3FRCIQe+rIIVpafaWWgo9lgESKZEcRzphPyE2c/1BBPX7
 Zqc+f8p1KRO7zCdmADz1reTcyVAI/D2yPMCqzPGNAvGlv5f4akOU+uLEwEnSYw3/6eWpy9AwPNQ
 MELTaCdqoQXHvfh7ZdGqWpnvSPSNpbOVqrv5ZPzSBWNeufbHCEtRRM9n62U065UDFNhLAylLZmz
 gbgsj/jOHLRkc9i4ONY7ncgAYW/NwGFukP1rNvBz6xUpE2PZg3G4Q/g+/sspn8DFFX/jNPZ9zE9
 SlIIUOkLoD+LdJUtrsxoSa1Hw2XmZFOEsb9r4HY+vh33wSTBA0gnykBRG6fBnW7+uPIn1ZNWRV0
 vKHNRg5+1Lt4PDVEM+NVctw==
X-Received: by 2002:a05:6870:3c8b:b0:49e:7e48:9325 with SMTP id
 586e51a60fabf-4a2a8703289mr8056958fac.7.1791844088461; 
 Mon, 12 Oct 2026 15:28:08 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:28:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:28:02 -0600
Subject: [PATCH v2 7/8] net: xilinx_emaclite: return -EAGAIN for empty receives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-7-c6a20425c15d@gmail.com>
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

emaclite_recv() returns -1 when neither receive buffer has a packet.
net_lwip_rx() only treats -EAGAIN as a non-fatal empty receive, so DHCP
can abort on an idle poll now that it checks net_lwip_poll().

Return -EAGAIN from all three no-packet paths: an empty ping buffer
without pong support, and both orders of checking the two buffers.
Leave buffer selection, frame parsing and acknowledgment unchanged.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/xilinx_emaclite.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xilinx_emaclite.c b/drivers/net/xilinx_emaclite.c
index c25ac2e6600..ba3c4d6f68f 100644
--- a/drivers/net/xilinx_emaclite.c
+++ b/drivers/net/xilinx_emaclite.c
@@ -473,11 +473,11 @@ try_again:
 			debug("Data not found in rx_ping buffer\n");
 			/* Pong buffer is not available - return immediately */
 			if (!emaclite->rxpp)
-				return -1;
+				return -EAGAIN;
 
 			/* Try pong buffer if this is first attempt */
 			if (attempt++)
-				return -1;
+				return -EAGAIN;
 			emaclite->use_rx_pong_buffer_next =
 					!emaclite->use_rx_pong_buffer_next;
 			goto try_again;
@@ -493,7 +493,7 @@ try_again:
 			debug("Data not found in rx_pong buffer\n");
 			/* Try ping buffer if this is first attempt */
 			if (attempt++)
-				return -1;
+				return -EAGAIN;
 			emaclite->use_rx_pong_buffer_next =
 					!emaclite->use_rx_pong_buffer_next;
 			goto try_again;

-- 
2.53.0

