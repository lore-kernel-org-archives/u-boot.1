Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E6606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SFKO+mqL;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PaHyb6F7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DA2C407F5;
	Tue, 20 Oct 2026 23:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I85H2aUA0CM2; Tue, 20 Oct 2026 23:32:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53A65407E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792539131;
	b=bXlW/QyudTWw3I57sevJ39ba6gA6PBV0PiL+cG7uwdGGl2mJelUovpIFyXQmJ17np0GY
	 GQ9SNsa/8qZKPdJtRVG0fp7O8PWmWQHKGi12hSWOylZxNacpExUQ3cvU4YI9TZUFFEqEU
	 RIop2IHq43DclY37R0kB1SRwcOO91FvvfV8WzQRQZIdMDW6/RHkjqk8Hhfh7v93MQ58YM
	 TOzjnvhQO4Tmrn+VRyVjqaN52miA3CErEbotaf/lEjFP43nas5BR5onoCbUCu6QFaoSW5
	 sDZuhHVaRTjhiBzMnFd8anb4kKAYhOslsdN8MaNC5R0InpltlCIt8RT7NYJwO1dLFuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792539131;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2aC9MTAUPWLZNdmsRGa/4QJqSBlXDLHh3a1VeCRcOX8=;
	b=Emov4KBgB/+2UktYnz5n19cKQxF/k580pIp4wU/ykiRAI3pYVLggt4vxslf+OIbhaHME
	 tZ6Pqvr2GHyBq/yG08iupmcJU6mFOnMYeB9vVAFfIdeGj8uzjRPScKbZLL5xRE9DXz6sd
	 oxr8MCRVuj80l8pUTp0INrPoGyVRVj1daslkzWGKFkzA72jSDu3ON2bgyFnlR13j09xR6
	 u4vZC98MIKXu5u4oVYo0geoacNwmV7O6HhuKJ4LGy1pSoimZHMDGhbzXh0vBv0MetmQkG
	 oFzlzw7pXcPxNvb7APEk8a1BybRUFo7bjo8nLS0Rl/YxI+vieugI6f6ZxURQPnyJyWw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792539131;
	bh=2aC9MTAUPWLZNdmsRGa/4QJqSBlXDLHh3a1VeCRcOX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFKO+mqLlK1l+7wxNAJdcHKoIt4Y4GtdXCa2rdS/DLGFS8Jn0/bKoHBKVqp2G4nP4
	 ZF62uAjOrFY69q2GhlN5mr0SyIZYTzppDrPOaR8Ue6Hk2C+E1FKYo1hWi/baGiLgZv
	 pRUTOmzPf4jIWXk5s+pLjP018twAyjrIWi80lp2pUFeZzluTS/CD0zNO2F/3MFnT7X
	 EnFiXwzoV1u20MkMgt6nRV8ik3cDnhOzJpra0W012MOf+Fqtnw6r+sCoh1o+7w8xcy
	 Y81eD4vkNEStBKC0p8E0yulNNoJbZDDGEsmWtOL8l/RR//OkA+TvSHHrdyqjOI4mOL
	 B5Nq++0su506A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53A65407E8;
	Tue, 20 Oct 2026 23:32:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72C551AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 702CB6073F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhfKE4WgVQOZ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 23:32:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BE7560719
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792539129;
 b=KUd8fwa1p9dysc7GFxeIfeGVN/XNUb/LYSR/HKfXQoiAoaQZFx+PEi1Iydwm8Kpp3es2
 +nBm9bFJLRTXrq/BDX+S+gpyQG4OXNNW8B0QKc22N0TgvZgLtR1vlSa2P4A7xySHocp3P
 WxpqU93QBdXfgaFJRUIIUQTGVhGDysBlRPujx4vTbL/esG57wuRNtgX0Q098B/3H0DVcz
 OI6MA2KCeDOndpgvRR89GSfbK2/ZKtQCrabmn8tMT0VoF5nxM+DoMElkWL3kOW9NMae97
 4kP+ZV/soLwaFDMYqZJudJtlo58HqGM/rWbJbuJDIzrlkt6bGyrW5FmIcWcEjFFwt6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792539129;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=2aC9MTAUPWLZNdmsRGa/4QJqSBlXDLHh3a1VeCRcOX8=;
 b=f7PRji1D96hXW1m+vrfoeTgNRIG2i3KCwFT/NgwUVE7AFaWsMlrN7cKTOhLHh5fxJjAM
 9k5tHWEaWob8SDs6HGwrmM4L2xHnMaP0wngjYW85SCmWqWA+tjuCXVokOHCykd3E39h+F
 BTsxp7SSSmGfdJcgI5laoICWKrhn4qurtTOFkMK6hPexSRh3RMAc2bGg27PdLoUYQhz2a
 o+UOI/TxXMLX0tmTt9BTIOHIZq3fPF/APluhmS9uFF/7HVT6z9bwNXgoBawwKw72p7nBc
 NHlLaO29dPSPC0/dEmKE0CJdBwomflFXzF4byvf3meTcUBuis6IrlqnDqUBzEWRE56A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PaHyb6F7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PaHyb6F7
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BE7560719
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:32:08 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4f48d91ba7dso108764b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792539127; x=1793143927;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2aC9MTAUPWLZNdmsRGa/4QJqSBlXDLHh3a1VeCRcOX8=;
 b=PaHyb6F7UA9My56qwH9u25a2Fp13iURpfuKgk07kHr/cqTx3BDfhRRxmZ39AjTrY+g
 WLY+fdw93UrDqim6x++sXWdOrn3entpT18Y2xsfFO4WmokNuM8P6cOTHRemQQQZuVZpy
 09wfWOa5Cb2m27ewJYmOoDFVll46o/fEB/oehcITmpNDXEQV14BpwjmJUDl/iTPA423K
 Nm74C3dvsrFfbdXiRxnoGBjH2sWfBkY1sNlIpt3iFLx55njCGL6ADmWh25SWyAishgAp
 0c7tVlj7LxTIsCnuq9eVYOYbtwOesK6V9qfHXitkiWuFjwRXLciHb+pk6ZMEk+40MdMk
 KFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792539127; x=1793143927;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2aC9MTAUPWLZNdmsRGa/4QJqSBlXDLHh3a1VeCRcOX8=;
 b=JP5dNPCXC3p7NGSZU3qVouXjp4Yg/JjjoaKNNrO5NbmBk6Om5ItBPCftQ+A0fRJqGW
 suEpuwo5RKDzyWnKAkzXn0xMPYwn41XwZlzflafx8A9oD4Q+4Sjvk+L2p3Z+a+5S5Za8
 aXJ+co1uEAPPMdb4J7RIU/DWvLh+NVWSusszEwBVfVt/kBhfv7qifdNir2+BmfUZ4R4C
 vwpIttKu5IMxHYKtjSIFv/1Zk39Gwqh2kuIMbc091MZlk47vd6KW8eYjmNDLj38xvo9L
 yzCDCK9s/MSUAIg269WJ74XKqiRDUOM1sV5DJ2YXLT1oLFmpYpDYmHlCPbrjstJ00/jK
 xGGg==
X-Gm-Message-State: AFq9FYIap7yZqLy0ctchmdRzlSS4LHl+Rfz8ylTa037/7y0obYn493uI
 P1JLy5grSHYjBxLu6Lf/9MO+BRBBn695/zShNp9ZB5wQX6yZQlZMDs5BRVwtyWEUmhQ=
X-Gm-Gg: AYBFou1yEbc8O6aKDFpsua9DBKUYWcFSpSkakIVHAaKELqGNnXcaU1FtX8LIArICESr
 MehQMXfAtGLx/26j7VK6ZUN6ZT3rIN6Oz7L3zyx222AXM0AfNXyKOQm4qeU/jYE8AKDDD/bYIAS
 +MSzt9r9FOxPTb/HBwvEnb8XMAF+pPSYU9SEw0+7fl/Hndj7AY/2/2vU/ov8HNFRUowVB+0PU0E
 swK/Pvw5EJtBzTEucbg4Oeq2BWh4S2LFHdt/zI7YqmoVWs+hePVDosUozuRw2l4E92kjNh5uTe6
 CTEmNQO0IzHIpsazfcE5TC1mPQ0ZQPV8pdVGYrPc23BYdnli9pwCyUqYVjJKuP+JTe4l3j77Jrs
 RKpeK51S08T21G9IWidmqGYb1GvDDxh5tvbezfuIiDknOEd5acL59Zgx+cB0hN2lcG2lZaEU4s7
 JYSS4GthSgk543Dt5ZHLNM1HUtiRvbrNlhDEwVn30mQTBEL6d6rXzTObIV3wjxktctOtnysfFH3
 4Cr6OG6Ns6ey7G54gDGfUuUk2ooDq68tGzImLDjyBahrRDgjttsH7iBN2tg
X-Received: by 2002:a05:6808:bc6:b0:4f7:d324:bc3a with SMTP id
 5614622812f47-553587670ccmr296833b6e.18.1792539127659; 
 Tue, 20 Oct 2026 16:32:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b400ba34sm621698b6e.4.2026.10.20.16.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 16:32:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261005-mtk-pwrap-mt8366-v1-1-db6b3d29ce17@baylibre.com>
References: <20261005-mtk-pwrap-mt8366-v1-1-db6b3d29ce17@baylibre.com>
Subject: Re: [PATCH] power: pmic: mtk-pwrap: add mt8366 compatible
Message-Id: <179253906507.3711947.15710033443356740607.b4-ty@b4>
Date: Tue, 20 Oct 2026 18:31:05 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=320; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HUuyrF3gafy1lleX4eXowkvDCOtis1USTBxWhAFL3f8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq1/m6LZYlIIJXLsy5V2mUE8t/UAxfuCZ5Pl7Z5
 YGreisSeE+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatf5uhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AOTkH/jP6SOWzS9lGoMrBCsVx67ini8lfv/94M5a4Onv
 bGnyJuIEcKIdHXoS7VNAe+Ca6vkACFBjSxYT9HZzNe647Oc4fQe5xAcQM4XUaCouTftqtn21uI/
 infUBzIXzDg0ItF7v3lfkBD4SmEGCVPELphIkElg6E2YaqsOGrM25c9QFESJ/uPt4OOZklynMxr
 CTQvbEKpYr0CMLRlt9csf3x3eI4LFQ5ZtoT46TauRdg6SkWNXo4AF3HAzNAizR6APHeJAsNyjmq
 A4yKjkATpERlOHvz5HzafWCvRO5wfA37UsiM2s9R8kgCcAD1LqgNPEtUed0vM8Nr1Mk48+O7QjD
 SFEo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 05 Oct 2026 16:33:20 -0500, David Lechner wrote:
> power: pmic: mtk-pwrap: add mt8366 compatible

Applied to mediatek-for-main, thanks!

[1/1] power: pmic: mtk-pwrap: add mt8366 compatible
      commit: fad3d427a83ea091468194802c1a15c5b4db105b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

