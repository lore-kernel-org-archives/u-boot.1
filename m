Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E916FCA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A11AB40613;
	Mon, 12 Oct 2026 22:28:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JTpv0YXF8zJv; Mon, 12 Oct 2026 22:28:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDA41405A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844093;
	b=LbadPddW0L7NWZwe5MNjX5IN1uCjKspDHnDz2lgqrZ6lkh/5wBwdEjdTPEAqcnv0uNbp
	 GaGrKcnqN0I/7e7hFxxUX5jS5eqtY7YTKwUVMkS13WxFfYb1kEZExgX72f+EeR29JlpJL
	 /SIldgcLqd3m2OHrADA1D+DL1+Oo8/Ywk65BepnAEhVWB7xexCAo+1zYI5zU4O96opMYZ
	 byBH+tae7e1SoTNHRisC9+lDSzVPpTd1V2Zs8UvRps8GZfMx2lRJ/8MsuIfdBgZPHprQV
	 9CbPHw6JVW8U4jtr7TgE5DRLjteMnZq2DuOmXOH5R1LC2IVZjY2Qjrd89d/gCIJo7WQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=r1Wnerot14Pr4YDZV0K/zjRgpEJnuSSyGj55NoMurIQ=;
	b=pwKNrx27FhKgEYMhqna5hpLgBfgsEePjQrwXsXO/nzVWowBBBInEeNkwUYO9AosBHwzj
	 iZkFfQKo6zLwm0g8px7SphUgcwcUh3GUC8WhwTfVuwZxE5swE/IBzO6hFxtrY7DIEmNdW
	 pKOowMxhLRHGsgAAVhR9Q2rnjWFz4UgiZFwOTa348R2GNaD03AvQ/3cWz8tKJ2bjwZzC+
	 2Q3cb9BzcAj/2MqHFIJLvjQUHS615tWw/Il65Sxzms2aDadGjXaTDqQ1VRvbyIWF/sp27
	 qECVZPuL+eOrZaEfErPVwPHjftiBdDcyZ56AEl1Va4UsvNI42x6oXUsehHfGTelGLKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844093;
	bh=r1Wnerot14Pr4YDZV0K/zjRgpEJnuSSyGj55NoMurIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=umcv3WJ4t6Uguiml/Kias4JfmMCKLMm62/gbA1Y7epqLdfhiA4xDEjzbUsVW/3xt2
	 uWYXiCKvjdafB0s3LqedKlw2ub9M8nixhbPXd9fCR5QirxVh8npvZ9cJMGACMTg2PW
	 WqnT6WdnCi7sxWxA5rTBf3lnKoQJDErBfuKoUXlOEwmOc62CL1o+tNCxlmtHLN+M7j
	 au8XLtqjDI8Md81167gEsQZ/CnEbJlLeExTPGrs2Hh8h+E/Wo5LWStBblWP688bvxR
	 NuuBkJvHoG0DeL+jLMZhWHh0j6XNJDTvfQC1UVQ3EdPWWulr8bUTvm9lCKZp8mP42g
	 H8xOzMEnsMO2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDA41405A3;
	Mon, 12 Oct 2026 22:28:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2764788
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98684606F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VNohiYwCkqJ3 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA2EE605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844087;
 b=l9URGvsIs+lTBhshi+uTgPNgObz8PqSJlbFW7xQGtHPrSKac381LulRlQ53H+2DgPsN8
 5bH3Ba6XDAcMT1UxUcBwa0pHTDJh5EfJJf3HTgslNcGHsa7zs7SOLMo9GJIWB/LavALLw
 6UPuDHuoAHwWMrIcSc+pfySD3Qryj84VKoQEx1pkwYjxN0aTLJDd9VUEnwv7EQfoU/Bjq
 QoAJeKG0n3iOYZpfk2gsu0M/8jAjBtvQgmlmcpcWYwXUBdGURuv+x287WquuSwskbJqom
 Xs/zItLf5HuXV/3gZ4L8VGd5GnSuHhlu8h8IQPmnGKJLGQN8nSNlEcJy6h8WcKmYa8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844087;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=r1Wnerot14Pr4YDZV0K/zjRgpEJnuSSyGj55NoMurIQ=;
 b=GbtqvoTC1W7TMeJywGdc4JXgB070JdobQTcFDV35BrRH0QHhw9FUGTbWLy2s3fEUmMF+
 xoqTJQK9gKKiQv6pz2BWGugGhe0cJJonODGPlLTVSMGjMKSFSuHo/Wws7yHXtMmYE4wCz
 YkNunUsYGuUq1IXPF7ZSP01ddwGERHfZxGRQpioC/2ABAJnA+zHkMTLa3Jfa/M4egT1dh
 c+ZyOM0Fjk1Rj+6Ugs9cmzuuwmJlacSK7fXAV/VXd8Rrfsl02YpA90lU6RWfMiFz2sIPp
 nQBOj5X7fYFbBqozsp5H32hZsS4U3pMfq9nV0f78LRFaIi+Pv7C0yPraXgyklryiiHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SwWtpaby; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SwWtpaby
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA2EE605D9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:06 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-48e2d5a69c4so1191515fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844085; x=1792448885;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r1Wnerot14Pr4YDZV0K/zjRgpEJnuSSyGj55NoMurIQ=;
 b=SwWtpabyhiaM7ox2YUJg+TvCY2saFD/hlGKLlbBm3ULzcpxGS0JLzeVUaUTLk40yY7
 HFbuuP4tGJqxKL9rIlI1qfloTX4guyg9jb3wJD3qVghU6ZjR0PK1+pHNrNKz/inoEWXs
 FQB4v0NlD2BNxxwZTsRgFr5fRd7V9VxSY2AeE7RjF8lkyQb0Rk1HahLMLfLXKyRleRdB
 8Pt771rUZp5Fsp9sCUtdzWrtc2IYc9i2fDEZp36xEJYybP3IXsTwTd7SA/PZnQ5qkZSP
 HVW6TGgpsqFWP6rsH5ZkCuttj8qBds2jNbtOG8cHFRTdXjtVaO9RDGCRu0G5trC8qH7p
 XKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844085; x=1792448885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r1Wnerot14Pr4YDZV0K/zjRgpEJnuSSyGj55NoMurIQ=;
 b=dMvVSZDXL7uhaIJCr6gdNvnwmCpYdAybIxW/H0Z4SXh4qYquNcQcrZln/hmupgvNpU
 jNxuNgN2yMDdaX9f3q9Cwi/v0ttKraESudW3EQt6DmFqFzl7niWhPv4oHbOio6smYaU6
 aqKHjinmzKvYpkOZlxq5zZ83GjUneVDAhe5cfZ2zJrxD3k/Lx69p3bPlX+vWpH9YWdRE
 /PlRnLDdXwFq8CNR2fho1XzUdu9w5x1D9YM/f3Lh9QIy8ItTauJ/3y1/WzbQIanDlRdK
 0uiyVFf8VeF04+a/sgxWl4NdZHTIC9cqmQTomMH6n12dU6qlcDadWYaUpKJyGX3fERgi
 SHzA==
X-Gm-Message-State: AFq9FYLI/2kL3Lm5fUa1fuPdkXOWsANGeAq28eTWhnkLlOJAU65BS31J
 68sLI2aRH0YD5iLLCJomrLgSwroEPCCDzpalkJ74cgqbjRrDcPgm1JzR
X-Gm-Gg: AYBFou0qbgU+Ns/FY8weEAzeBQle2Kp4lSJH9YK6fvlN6w5a038V05TWFuIRj89gO7b
 zcLMe6006PVnctquWIGKuueMU8A8DfeVaK4AWQSqZ6hGzgWEUO5zueUidcab9kQUk9ttDmCYQz+
 8UyJaDuq9fXpslnAACWphwhlxD+13/6n2j4vExy2mbVgPFZko0Htfg9mWpnS1xT3zWGORgSivr8
 WBpFtqVJBVeMJBJRyhiPA8rz84vZoXHDfvQlIuP6Rnux9lmzR9Hi5UQrqiWo3fqxyC2TtEadf9k
 YC/yJm3oH7e0pjxvMHsQhLLAZsksfE0ke0S0emjypwDvYTGC7/P8gR1P20wmONsqEKyawux78Fp
 /yCrZ46HP9ODNGZ0w4hTgIzXPjsWvDTBr8wp7CpypIkO1CAld4XpC4DqidhFDhVWGMwpi7nMr+6
 F7MmOR1/1PVF+a93DMHzRZ6JMh3UGBHO2HklgJ8ocYcAuq/j+tTnESOi0OYegGwFfVIe1qHZL+p
 gPxQwJX4tt7FTknbknoJiMgEpBZBJwq2cPK0v7Dx3VCr/aH19ok3+agvINt2fza8fuCdJdPx1/e
 OJzUJItYwJuN9LLkbSa22ri239vcwu9Y2fBYuwr9OvhukqjB8W+LWxXxl9YHb6IrhZ07vrB1lr6
 ft+WUVcoS4xUidYg7IFC1Cw==
X-Received: by 2002:a05:6870:9a12:b0:483:8eb8:71be with SMTP id
 586e51a60fabf-4a2a8a2a4ebmr9894063fac.32.1791844085549; 
 Mon, 12 Oct 2026 15:28:05 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:28:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:28:00 -0600
Subject: [PATCH v2 5/8] net: mvgbe: return -EAGAIN for empty receives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-5-c6a20425c15d@gmail.com>
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

__mvgbe_recv() returns -1 when its receive descriptor remains owned by
DMA throughout the polling loop. net_lwip_rx() only treats -EAGAIN as
a non-fatal empty receive, so DHCP can abort on an idle poll now that
it checks net_lwip_poll().

Return -EAGAIN when no packet becomes available. Preserve the existing
polling limit, received-frame checks and descriptor handling.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/mvgbe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mvgbe.c b/drivers/net/mvgbe.c
index 4dc738980cb..c37f67a4334 100644
--- a/drivers/net/mvgbe.c
+++ b/drivers/net/mvgbe.c
@@ -569,7 +569,7 @@ static int __mvgbe_recv(struct mvgbe_device *dmvgbe, uchar **packetp)
 			timeout++;
 		else {
 			debug("%s time out...\n", __func__);
-			return -1;
+			return -EAGAIN;
 		}
 	} while (readl(&p_rxdesc_curr->cmd_sts) & MVGBE_BUFFER_OWNED_BY_DMA);
 

-- 
2.53.0

