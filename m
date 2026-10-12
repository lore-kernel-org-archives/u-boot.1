Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E74CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98D264066C;
	Mon, 12 Oct 2026 22:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SuFU-Zx0LJ_h; Mon, 12 Oct 2026 22:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D6F9540620
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844099;
	b=QH6kjZfqGhHY+AW6YbOa59J5x6VNtzdZ08fnULienYgSUHoPzKNp105/Sdpx/PhU5TIR
	 /IndDl714yp5nUQX5vOjI4ZecK6HPIP+VyEgr+I+48TM5KO+Gb38ICWbD4vvpOXDnZFTi
	 PRSKd2tai6CnkpKHfOSkr4wMf2A0r8n2RWfnS7vHVrTi0L8+46/A4CND03Xo12RKaZRDn
	 2y5b0zc7GXtIl4vPFJ+qsNMUWkCsvFluawZgmHUNBKbRcMrWACQkv+0PF00eIyMFPl5Yb
	 ONvoygg0zxvFhkyxbzVDeZ6NakxMXxya5OKywWD96jcgWLH6VJCN/TMdfAnR/+GnYnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Hi08tUHd53KDRRPGGvLpI4W8W8XQ0wwyIKB0PnegWO8=;
	b=a3bhzJH6pTDAC0TYT1zYpXVHI3qDcMUthj1DNR1T/FRMGxwD9WaJ7tjUUpa2GYqH7AEr
	 jXXQKzNLEpCwIvQD/TmkSIrPKrkrQCy90S8hVqeYTaXequhH1Yubgm426yR0c9vcDyh/R
	 YjrhfZa52k/dnOCfkF1ZjWKcWVdcTNxVZ0/ty50U2iGpS2x0fsPRFdUbGeOZk/eDUgZ7u
	 bZQHH7s83Vbz2lz2Z6kqwteK3wa8cDouFWVm0hl0T/StTawpf1xqZdsY1cLMR6vnwHRTv
	 hXQEXBxiAnur44D8oeR0WF6TNbw0u5v5KSB0fWbvj17qgasfkcVpDQN3PuelZEw3wzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BK8GVP2Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844099;
	bh=Hi08tUHd53KDRRPGGvLpI4W8W8XQ0wwyIKB0PnegWO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MGaoyHOPggUnyoP055BMDEsOdyHAyiHbBSkhKr/ZlRj5O66BeMlEkSiB5ghCasVcY
	 nH81tX096DJMO/RpiByB5jZ6yyKgMQx0+nECeDiaaIStArR0f1LHnnMt0eIARcHsi9
	 S6dpVTrajQHm8hnmW2N+M3SCKXm9/31T7FchuEA0feqmJH3OJ2fATRMRFNtyr7YKf7
	 t4FipOxjO1SALBhAVeUJF+wxYPnokcev8cOY5c66b4/Vg5CCOqv/vSAZryQu9spOWt
	 i8ht9+FjUbyqfHFUruw5xZwj+zEmAJEhA0NURJqcYg0tcNvGObfboa0tLpyHvh36qm
	 1t7rIi7VL2XlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6F9540620;
	Mon, 12 Oct 2026 22:28:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B100731
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4C99405A3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hqA-s0GYb0Qn for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23E01405E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844091;
 b=kwFA7L3jfYO6HgAxUAaWk+KMJzdMnDmRDI/GqJ5Af0fE8g3FvplNoVZcqC67rZIfHiz9
 V7LHHD3VZX4xotTKgadrrUqovMCNRdTUD/Js3W1Fg4/+drfGmxILe0qz96a07UYif72vs
 RGEb/89RH6OyQoKU5xOW1BDs/DnATy5HW/7amCb0zVlRDpcGvqSt/8tET9cAmIj0750Sg
 /yIUFR8toOY020uYYKoA+rTyhL6Xi4hotD755AZP5WY2OOzJAFp7mQO24ce74Gq3of+eE
 mwlXlaCbCI9uAJDr5Um2vvJyR4skIYJe3wTjLo8LuTbq0fqdikd95qNAKtj9uDzHNMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844091;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Hi08tUHd53KDRRPGGvLpI4W8W8XQ0wwyIKB0PnegWO8=;
 b=kYOUzTZITh5NXhte6RLCBI43RiBOtwnz7c/HQeVI6H3p1gJGx5LEaed0QF7aPX8j7FqA
 9+PZIDyWoHSU0bzmu3hhH+dt+Su1wA/9enPd656XNjUmJgEfLHJt9OcErBzdY6JGtglYg
 Z06Pi6ro2eGg9VExr1tRQVNAEZxIvmAMjaG85hjJs87VH4YQul8kSQDPUj/wZOhcmSgmt
 1+s2WqYBtmlKzZ6OM28lgnPmuM9hwgWZfIJGQzYMparLxZIv9WiAk5u3/BnnR9eGxFDh0
 OdV+AKKDt81HqyCjcHeozHejaYcRaE3WsVj6Fyu+nqRGFhVByXdNU+nLf2QCggOXqJg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BK8GVP2Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BK8GVP2Q
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23E01405E6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:10 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4b190cdc9feso1468162b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844090; x=1792448890;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hi08tUHd53KDRRPGGvLpI4W8W8XQ0wwyIKB0PnegWO8=;
 b=BK8GVP2QEwhX4w+lp73uYL6ozkePbjcZBpFL3qyP2lzDfxcOWPMRL7b8tkjWD8/rjc
 ntRzzf6PvQV87y9AB8uH0zr4KwNyNYZofGYm05kfVCy8zQFYpb6D/7+gZdPK2FMWACoH
 nyc5esY74NN3zngROvr7SPjl040BV2AIm9ok8ewNmUg5A52rKUSCLHkL9xIh5GlkKGVZ
 hzGgtHwYddjR1LBmj/inDjfT6A41L2UPlzO50p6nPTqc3iTlSDTGx/z1tfXUJVFsksIT
 qz6VG5aQ1TMC62cGpnssO62wRNDEgRsBXtbAm/88fA8pFCMEoLqvtui5lB2XR9WGYbme
 +FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844090; x=1792448890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hi08tUHd53KDRRPGGvLpI4W8W8XQ0wwyIKB0PnegWO8=;
 b=RsIymIxUFVKVMdi3zVYdwnMSsuEgCMju/6NFy+XEZJ1YPXnO+2FrqtTNJxlzGFDvi0
 u8aaOplZFOcX8vz3lRzfb28qZFgcwovuFZPi+cGazLuG/E4UeIhVpS2eV4bHcDYfTdO9
 EunKITjGOnA0GeT0nJgeno7L9waLaITf33mpb73FczvANlpY0vob4T1/gH8Fkxdav8RJ
 MV4MuXGRPqt/UEHJvKEudt3fYKgKezSL+WaF9s2zecuG8ErHE/od1B3W8W+N9JFzouHk
 gANcUM0qYGxNhImf4bT+MqVyL8rrLbCCcleyKESW8pQpm9auxVlTt647usr9XJab6dZP
 Mxtg==
X-Gm-Message-State: AFq9FYLjZhBd/dh1h/2xcQyuIPb0Fi1D7mTDxe7nuwcUTnrwuHCv2okn
 DNdlJssS19zbE0BoiNZviea4OR3uIDXsd+/tymVsKa1RAVICAlbqCnA+
X-Gm-Gg: AYBFou34qUDHiAu8OgB5wm4jpoWo3KZUjzkar4FNV35e6gwQwl5Zm6rRKl3LRPSIzYU
 ZK1Bh0PWzACYCfCCcbDk83EeVBDH6HNr6pB34epPzUphtbIEPYPyZWagrCUH6CUEOR0JrAeb7qL
 XCH5w9r1THRXSLHx9hH+dTAhucx3i3D+q2e0G5/Xk506tMeHvDgZO/i3b/01OjhLny8c/ZlU1iu
 BvDYp9eOO3eeZN8nYgiSHPtl1Y+rRoYPsBJgTOr5RG4OwauIc8fqL2c1gvchoDVYggav01+3DYP
 lSalLJ8XEScRoubZGjoRUDFDolxv50vZE6X7JJ37e4T94otWobRXIr1/IVuEGqO004rXaqsd+vG
 jW7YF8vc523CFN2T5+JVIW84G76PUcqFbUEfgQqCv0dbVGBh/JZqJrr3VPr6L8AvgHNlRqEiZjO
 xg39nMhfuOX/+dL4e2t/SQNUB0puncZkjan7wiwnslqNrt+Q/KIvafZol/94y2ZnH/XanPZ0orM
 +tCzAaAFognDCCHqrxNzsbmU9BNT4uVpfwXIczPkQ6adAA5ZPR43XEOw11BKHiPys20NKTon81i
 DnewKVnjFdeepREbZAGV0V5Qp5pk/BFXjUOuRZnqx8fPR1p/9PnANPvaff7kBldA/mb8OjJmLCN
 IQN44mooxzN0KJP4v2oLJnsXYQwmizvJRPQ==
X-Received: by 2002:a05:6808:4f22:b0:4f8:ee5d:c590 with SMTP id
 5614622812f47-50c5defa81amr10802709b6e.68.1791844089619; 
 Mon, 12 Oct 2026 15:28:09 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:28:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:28:03 -0600
Subject: [PATCH v2 8/8] net: zynq_gem: return -EAGAIN for empty receives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-8-c6a20425c15d@gmail.com>
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

zynq_gem_recv() returns -1 when the current receive descriptor has no
new packet. net_lwip_rx() only treats -EAGAIN as a non-fatal empty
receive, so DHCP can abort on an idle poll now that it checks
net_lwip_poll().

Return -EAGAIN when the descriptor's new-packet bit is clear. Leave
received-frame processing and the errors for missing frame flags or
zero-length packets unchanged.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/zynq_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index f570ae9ee73..957d5251cb8 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -772,7 +772,7 @@ static int zynq_gem_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct emac_bd *current_bd = &priv->rx_bd[priv->rxbd_current];
 
 	if (!(current_bd->addr & ZYNQ_GEM_RXBUF_NEW_MASK))
-		return -1;
+		return -EAGAIN;
 
 	if (!(current_bd->status &
 			(ZYNQ_GEM_RXBUF_SOF_MASK | ZYNQ_GEM_RXBUF_EOF_MASK))) {

-- 
2.53.0

