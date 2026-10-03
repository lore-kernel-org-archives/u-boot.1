Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562BACA5FE6
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 20:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B38381340;
	Sat,  3 Oct 2026 20:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oq7W3trLCSQU; Sat,  3 Oct 2026 20:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 32BDC81347
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791058094;
	b=dezVlZKyFYc/l5ai6yIA4td+WuN1zjRbql/VJT/iudmdb3dZ8oTXWQu66rsOABp9A8FW
	 IiWEX5vUO9NB1pp6ebOieAkFgAc4KLcmAzOf9hP6owkOrtqqyThSCj62mjG+0pbvirWIe
	 AFNtJafReTizcjpIZsyldkwxJetT1Qycg26dCdyybJQs4MqTM3NHKFgp+Rk/p38kPTSpL
	 oF2ZUMNMey2bRTTTflGyOmKBKkS32N7O8WgoNGtwBQwz6SEFp5IpQjogdvHBngJJmbua3
	 9OC4RIsZ/b0XhPKfpd9yssgeEb0xKrRCtGJ6boTHQyDV1m0/eC4mRp90eEhkUl3Y5bQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791058094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
	b=ZnFKMw23wCY1ogZLKsGQvJdKhwFN+NgDjV4dLvHgI7IIRTPbCPuvmLjPgL8wYXDM32Kh
	 E+ipbh9kzZnlEgifh9WifpbGmwrZ5/lC/MwbW7SSUUJWLwhKP8GcSLFn5AmPzs2a3zV1k
	 DRg9Ok1D2FyrzP9B9hEyDdcsfCffrC9zLmb2fEkrf+c7d3znepzk9ECzI6fw7t/PivBfG
	 /AqMkRrqyqjWDpSTgtG6e+pB+GmXcCxpyS2vkOon6SrPXURaBKBLAy1/jhK+4nJi0a52I
	 lNJL4bRJb+27MA+hgjdVouNrngrJRGpK3xZfIpv/qJMWbCAbpqGcLit0tWhJfNYGi0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=AYxu77I1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791058094;
	bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVZXJv7wGt6b9tOM9vRZSb1EhCffHkEd0HvR3gLECsu4BDTqhJp2f8HQlzsINIkzz
	 54nrbz/v6RRxM2N7jclMcHtd053VIfQtualXncTHJWsW6kEczsEIzzZhCBQ1zjDYym
	 rSZzDnQYMp64EEa+9vUBp9svTZHFhO6W+Oe2EJx52IH2XcPbcHP3sSRNogtnPJd8bz
	 u3A+5AqFlYvC4ehaRXiGXw+nplrYCF3k0swDG9kXb/kLGMh4vc7OVQ6oWxKGLjIQGE
	 cPntNK5rl1/4tWqnMPDhz48UtYE+2R0tXhpki8OXAr6v91bYj4L89O0ZNUojTPJY4n
	 ygXFhf4r+zUOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32BDC81347;
	Sat,  3 Oct 2026 20:08:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF522476
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A542C8109E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJ9Ww4yVXukd for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 20:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E63A8101D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791058089;
 b=YsjqIWr+xmIZ4nnjv/sfOXRsu0G2VTfvkC4FTUYJIy7RQJxWsSJQBWk/aBuzwund1hgp
 cMmYi12AgebkCcJ5PO0hHc6LIBd2XMzVCH2kDzNjY4/xBNd638bme+Bk316Qh5rgrwxIR
 RgMKz5T8nIQcqIUEVG4hypxuCKQmJqDTeTHmLetaTXQ2xLLtimcuCEqlCXV+3Y6C9tMCJ
 XUaxDf0u/v5rvTjUcUSp+VgTrjDQ00PO/QdJ9eEDeCHNL/EQQw74DC0e/2G9aMmovRWjM
 olGAa2ZXsAZq9mkrb5B5TDlg8dTe/QF092B92972Bm2rwa8GjgYMmGCoxMjuCix+Bqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791058089;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
 b=OIVP4vSKX0o0Izy0DYt8VDaksENtHC3N8RzXMx5f7sBsxpGTo6ggHVn9XphOqT0pAlkL
 35/feMWE5dPqzlNbn4V6LoV0xBeAF0cspGqOF7uyEadpsZg+c0VchpNv9wmt7GAg36mz+
 ohq8eoUVrbL6InGzNYJe/gamL6U91H2A6hjCygd11PheF5YM89CCR1/XIjNqI5Q/2A3WI
 80Qvd89E8a6Yq+nYu49FSXmn+MlAG6bTQ91uFxzQX3cfppTDv1hkSd9hhJKWLKkPwPqkz
 gSfl3LlXquVj0WgsBaO/AsVtw4htxDn1M4zwMs1x0XGROafI6CgVwQjatsyu11fRyvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=AYxu77I1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=asrinivasan@tenstorrent.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=AYxu77I1
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E63A8101D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:08 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab46253999so4507307b3.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791058088; x=1791662888;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
 b=AYxu77I1xo4NPaANpeuqzpF1pxd3v0b7Ra8ds1ik58cf5+V+45nIuKb7IK40BdOe+0
 qa0JiWGg1g4rWR55w3lgMWMRWGmPXdfW4gC89gXoKoepA21teb1N/6v+wFc22IkCd5lg
 4MFGka+rxPO6109DUZC1BQi/xz242lUHVTzRrRnSil5x7zrHlTZS945ibe1bBN7m6SRt
 Ek6S+KDavwuI9cRBW4XxQ4YO7kvefkjzMoSj/09JgzFTnowoR5SvvyoCUS2DxA6spoaf
 FAokO5+TqQ7B+E9J0TDR9Gb4ybU7QSlXUtMKhu/PanDqRKMh1K4NmlGeUXAsb/ywoiZh
 fYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791058088; x=1791662888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XAKeBFd1ED1/No4mfls9iCxl1K6TuM7J0pa8TR23iaU=;
 b=b+aDEh5qJ7rkB95+ooNYFAOoh6s2DLODkT4FwQdKgOMgySTXGnVMnH72DiCy1/uQlG
 OV/CPb9tk5xdxBqJNhICdTpkmWnyWdELYtreQhGCc/LhhEzJE0swMu+PDJl1MtoUDx4L
 7OmZyzf3XRRY4POsp/EWtGz39uEgszBKWMvI2kE/IpnxfequeAzZoVDQHtU47R5OGpyr
 H9vT3ITUTIY8frUF8TSA6j05mSOWSTSR5eH37n6miI2wVewOTXyYt15Rw87+j/3jyFDM
 LYtdNjNxN1zRlra1kXx7CRxRKMRYybQOK9DhQlNqtQ8XiidDvaW9TDCYcWAlMf9Zjrsl
 sXxg==
X-Gm-Message-State: AFq9FYLZLWZ6GrHReFU81+0WDlpD90S/zJxUFQoUUNutE1hfv5B0xKOh
 hetWNhHYAImK1tEvDG+MSWuDu+eHKAzduzhaaT0Gd3AfDZnoli5vahZMXjnHrKb0L1hmf/J+cwO
 6PgfDxnQ=
X-Gm-Gg: AYBFou19t1yGYe+fNkbQUXtvXRcsZgBLIyvEVEOPO1CLpwkWdh7sGUeHyzTTzkP/MxS
 lUQVqk+Fx/VfewFw8pJcd80zMwmcfQv0q7AeHpSHw4hc/MVNiwJonfxYSkHNRR9U62riXrXG9j5
 o3gde4nS5jiy9nRK4RUu7oNr8gZAkL+zGE/gI5rZ41MvJ5XeWuQW3/cLzabXWcMpxW7wBlQuN9h
 iMZaNDssjp9h6gKtR0T8Lqs+hksmf3FLolcnlreWY0XDoFt4un4ciuMzj10i7EPOfzS0KETc57p
 ZuqDVvZNNC5k26DxDZYqWfsqe8BKFtl+KZ9ffdl0N9rbPdtkbfoqtOZXFyRNoWAdnJR3/qo7XAr
 B28B4rFj/PPyNnbFG+leXAQrH/678LClw5QMI3qWZP7DEhOMtjzs2eHYuZ05CQpd71uvjPZJCwK
 HN7rx9y31Ui7mrAKdyZ0jCMuzF0mvp8BG5H+5i9rp5b3yw3BAkrh0DZ8r15qYudQ38CKtCD08Du
 WqZlxUG2KB/32rqK5afgogkLbqg3Ij2lQYOYORuzKIAD/gvk7aGbA==
X-Received: by 2002:a05:690e:140f:b0:677:ae83:c955 with SMTP id
 956f58d0204a3-677ae83cf77mr2872808d50.45.1791058087926; 
 Sat, 03 Oct 2026 13:08:07 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:e2e9:9d9a:5aeb:a046])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-677c16c243esm986048d50.0.2026.10.03.13.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 13:08:07 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 03 Oct 2026 15:07:55 -0500
Subject: [PATCH v2 1/5] bios_emulator: select X86EMU_RAW_IO only on x86
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-aspeed_vbios_fixes-v2-1-f8e593f024ab@oss.tenstorrent.com>
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

X86EMU_RAW_IO mode can only be used on architectures that support port
I/O like x86, so don't select this for other architectures.

This was also suggested by Tom Rini [1], but was never added in.

[1] https://lore.kernel.org/u-boot/20241117025353.GA3151182@bill-the-cat/

Suggested-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bios_emulator/Kconfig b/drivers/bios_emulator/Kconfig
index 3660576772d..5afea87a2e4 100644
--- a/drivers/bios_emulator/Kconfig
+++ b/drivers/bios_emulator/Kconfig
@@ -1,10 +1,10 @@
 config BIOSEMU
 	bool
-	select X86EMU_RAW_IO
+	select X86EMU_RAW_IO if X86
 
 config SPL_BIOSEMU
 	bool
-	select X86EMU_RAW_IO
+	select X86EMU_RAW_IO if X86
 
 config X86EMU_RAW_IO
 	bool

-- 
2.43.0

