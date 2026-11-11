Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B670606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SZFh0AJv;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3o46ok3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56A9160AD7;
	Wed, 11 Nov 2026 09:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70CAQ7vbpO3M; Wed, 11 Nov 2026 09:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 98A6760AA8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794388656;
	b=CYXQBX2qhOzdlQva28ALSRd+EfX2Pq5djGHb8CPnvNUEXQoU/DkA3dG+7TesLPOLBGlW
	 WTxEXZKnOaRUg/P6M/gLkxQFGrne8w37SdnlyrNIWXOdkAUtT+g8BbYgZr1FQKmhC9Zus
	 5tIwebOfjmYIY+QBux6sFrJePoIRNZX7r7+wWx1aMhPx+2laOV1ijhU/Vs18xaB/75e9E
	 EUfMl8Wep8uOWg/Wp2cYrvER10njRLIU3y0UhtIcwT1iaKRFU+7/Y41oOzb7oPxfD+kyK
	 JyXKrq5QoUPKonr1lq5aMXdHeqCu/IX5pu3St4qH2wlobYtG46nXW9jPePc6VzgyqgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794388656;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/D2phNWSPDeKTo4myLncl95zR6bNX+KCcGFLH80rZzg=;
	b=qLW9XnmJbfYP1lNhPyjCTeMorhm0deAwLqYnePYL04GJ5nRni5TB1dHZo2B8AvSE1n/X
	 OgKdeRK9HZPgp8iHGKwgsFnKy2fI18KCnPzYw5oMABHiqlaktWjdtpMEqv8HMVF1vuXlh
	 LiNwHWsAdLmw6TY3GZlmLkEgpcpdZ8B8MlNXILbYd7zlA8F7pagH4Y0fpsGCbb9KZuwrr
	 f7fyuFcTu1sKIFuqhD4K4vBFZhVfzhCNs1O97mKrBaadYGcNwHrcITsuwRcTdx+XFSbFd
	 6qwJaZhEsT3A4NtUWht3FgxKts1fpxWvi/24nl+Pbza/QUtEzcC+sdHkDB8tXHofy5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3o46ok3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794388656;
	bh=/D2phNWSPDeKTo4myLncl95zR6bNX+KCcGFLH80rZzg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SZFh0AJvno6l9j4vASy4682gTuO1SbEZVItkAydH33oYGyWpfz6YEBCCjNGt51Ptw
	 Wdm0I8F6yb/q3wj79hVk7YPX3xr80wj1HUsfgza19NS5q/XbCsSNRwo4UaN6ONNTnp
	 VLa0iMQik7LjbGCoIJbmR88Y2lY0yvnnLqPmCfW5iMPeGWjWmdli+JuWxcGz3jIyX1
	 YC76e1TSPv03EcSSWkkxeXQuvtCT954kfCASFUlIcZm+cF7SIgDzkV9q8TaWJLnQ3l
	 PwmQEz2KDMrb4XzDiL2XZBu235dSnKVAjJs4W0DxcMhVadnNuITOaAIS7bdAXpzepo
	 PF7nJe5sK1htg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98A6760AA8;
	Wed, 11 Nov 2026 09:17:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AF5D17CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8138B60797
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1W3buTS_PkXz for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFD28606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=l3o46ok3
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFD28606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:17:34 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so2333695f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388652; x=1794993452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/D2phNWSPDeKTo4myLncl95zR6bNX+KCcGFLH80rZzg=;
 b=l3o46ok3dXjqhxH1CMJYvfb6PxmoUGDLeALR+3uFYKYxyESy6U1kbjIP7E9+q0xAfw
 6Sz07lhXhaIi40MJ+vJCfWnwLVXDT1E/PRUc53LARRVqiWEUfYTDfZZq1nGW2DarVNVa
 nwFNfL3wX2jHVRhEM1pIsWLzTIuCTyfnnJNrtu28b4o054PB1LXbR+G47nfG7jXJvcgw
 gP/vQ++WqCMKv+CRPUxQvNbOMQalrE/n5nWJoy1uVA1ZVS1/9D0tCW+lKVvUSE0UJWxi
 osZTk7cXoBSUrnYCNMu0O4Xada9fw8LWpnIgGLKGj3DLPKl4DgZNE8G+UelzyuqgYBMN
 2ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388652; x=1794993452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/D2phNWSPDeKTo4myLncl95zR6bNX+KCcGFLH80rZzg=;
 b=DGSTB4tVb4zh9fMQG7xDwaY5iX1eNSBXQdRoyzjKWHxEB4M4iWhXjsqo/6qAFrX6gg
 O5awh5BPFPXZP7eWhC8EydIY3qinaNXXr3z+zCMNtZueVvk3xtUsI6CA8Z701ZA8JfwO
 pRn6VnR43mX1JlLqBMI6SAK2WUmBB1xNX9s83TwGs7TFqX7naAcFzmGe5toaMkxVnT1x
 Z3S4PjNw7UZ9V9Lo99htVcHsLQhsBXPUXJULs6x2JZ7IlMfKVwZj9jwALFWJ86GvcTkR
 dLG/HKBOEVQwCEXx7W5+eRcuFP0cW7SxRPQlQkm4Kg6aX3j15ev9ugSpMQEfAa/dWUiX
 YMOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHdx6rPZm71juIVA2aYE3Wn/Prs2H2VcgqBzvC78FqHNYySqJES8x7vHgHqeqIXdK1QlQiV2eA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Ariou3LBJdmSUoqbapfPv+k/me1IclBKeo9Q4WjRrc9s9v6+f
 rqb0j6JTstt/oEzjs0sFvOtNM6dV4QYBbZjInG/HpAKGvZH5x6fYvbbwuIq4Sg==
X-Gm-Gg: AYBFou21FAadjGYPCAqWEu4ALxlhXw+PegwyuL6FfuDKVhl97Udv4w6jnfYBek9G20o
 BZoUDHzcZcYPCgebv5b1Aw9PU12atfiTFPY2j7LilXeW7s9YyIv7nBB00QNAJWMv/9nW2Soj9DF
 ED12EJAbVGZXXhcpptHYuRKy154FmTW9BO0JfAl5x1T20L2c4Zk+Tg/hfrnmglbbugJnOvX8vrY
 ClsVVjrqGgOLTvJX83ym/9Qi7ddzg4dwPiBOR5SuhUVnSFjOhc+6IIPOuBlGn4wItviBVkpM9Ir
 ZBtaL5FPR4qqPWRl0zgy+FJ9fGmnHx6nEhGKYtGzskG0FQDuzZ3DSzfYwW5mPDuwY6y2WxcP7jA
 A+q/p7qlVU5ocV71/ijTjTg9D3Ca0ErjsN/Cir2DLEIpYRnw9CajUSqQzXu2W9XMoLssf5cu2tE
 pPdXhL5WuNic6P+BctgQ60+WH5m3wzVKKbAOB2J3b5sU2PAy+pnjZ3xnGI9AYxMPbQ3WyehX7Uz
 +UATgmNIJg4fIDadoSgDmqygPl6udAhzr4IN+z4VbjebcSlQS1ZbSyhW2V151Z8wV236UYDuOf5
 VdBGb8dtvF1+6bFPOfPGGl35X6gSwooB53wmzfVZqDLbCy73aIQOnLxa2nrxFsefM5v8oOf98St
 maLKRm4AQ7oH2CDZZ49AMPKzSIg4DssDCnevFmZui4uZ9jvNdnHzdQ82Ls4sDSq958lCaggYYQm
 JXxHSbt8Uzl5nw
X-Received: by 2002:a05:6000:26cc:b0:493:f271:b622 with SMTP id
 ffacd0b85a97d-4999832413emr3857767f8f.31.1794388651943; 
 Wed, 11 Nov 2026 01:17:31 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10209735f8f.18.2026.11.11.01.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:17:31 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 0/1] MAINTAINERS updates
Date: Wed, 11 Nov 2026 09:17:23 +0000
Message-ID: <20261111091728.3388905-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the departure of Simon there's opportunities for new
people to step up as maintainers if they so desire. If you
are interested in helping out in this regard feel reach out
to the PLC (Tom Rini, Neil Armstrong or myself) or other
exisiting maintainers in the community if you want more
information about what the role involves.

Peter Robinson (1):
  Update maintainers and mailmap

 .mailmap    |  3 ++-
 MAINTAINERS | 32 ++++++++++++++------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.56.0

