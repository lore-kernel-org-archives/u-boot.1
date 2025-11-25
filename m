Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43C7D0E6FF
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4156983F89;
	Tue, 25 Nov 2025 16:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xk5bkFkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E94A840D4; Tue, 25 Nov 2025 16:38:43 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5C183F75
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso34381745e9.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 07:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764085120; x=1764689920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1IKzL6DkppaQV6nfPyBuUeyaWkIGtr6R9OD3PJOkqY=;
 b=Xk5bkFkZxgb2in10QGZ1HYyfQffLsZZlhODjIUpBnrXDdrAFy6KapKEzB32SAb6dbX
 cal817ntPKJb+BM1CaXLSjdDf5SdTwzOsFzavdoUB1szXnt1P3VaNJAs+znJXQZ5rYJh
 kjckoALTtGnI9m1tGC1fCaxxPcrVD0T9kxNgx12WaWznoyc3joAN8mIitPcLLDxKQWV0
 5sNp/5m9nAU9XqOcPjolhNIbx0QbICCbmN+ykZ4W3mJ/BPIxIiGQ/LOC2ODhF5CsYJvv
 YSQpL1jtcs6aJ+DbPszztYXAhrb3AAfg0YMrDuOejgphdiOOwN669SRYwXdbvxJgzOjr
 f7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764085120; x=1764689920;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b1IKzL6DkppaQV6nfPyBuUeyaWkIGtr6R9OD3PJOkqY=;
 b=mSuSTbdDVprRSVD/jBzDheq3S+BEdLdp2OhqgSY5yXHAb1JrG6qm817rjecLUoaPQt
 BESbsWIxzO+mPSp+mXXMZtew5JsH5iGoQtOPT05cG7l763i/1aRTRDcnOe52wkqZ1vA0
 dxbbuRDRyonWG12zmQwbNkETqVfrd/YAD2/v6zCJhWGSLDpbp/WpzILOrAxPs1s193mu
 BT3l817TUhZD9vdEqS/bD4lZzXMZn1G7cHLK79o4E775NIi/T7GyQ2F4lhiJlaNCrOZ4
 pzsRXMiPKa24kmSaMO2t8MkKC0Uvq2b/RETlAUI6tfSL8e4LwbjQyw4gjCbweDweMjQp
 7UjA==
X-Gm-Message-State: AOJu0YyFzcvGSL+Iixx0eXZfZsqzbpIbj04A/JIRdowpAjdBPCjbctT6
 l/m/GyTnEdJbTs5He2rCStnNT4QtqTH8ZXageqQHEABe9qDLO9uS1BzeouqYKNEyEIo=
X-Gm-Gg: ASbGncsv706WFX/mexT1A+rYU0AmD159GWCnnSNsnD3zAne3Kabx3OuXwQzE5gDM5C9
 A9asQi8BI+Ot/bw5k6KJLwCzg40jU99RjMDC+MyiejRl9f/sMzNgR9fKEvOYKYnSPIAE8sc/j1A
 Cl0SQkZnYI4KFAszCrvfHKLgdbPUSqnIoD92LyZk4tTtqyy3q/osSEaSnhEGXy0OAdXIq3/w7OB
 MFKfhK2Jf/gyutten1uakVshonmn4+PhV7eMbleRZvJREvFWU1RZezjsJBP3b5eBU6W2+UOEHk7
 JsyqAulKbEMNTRbYiOp/mN8fJ1QW7njacov5Y5PphiRl0BM61eLrrndBQeaCXwNDc6pUEWuHitp
 u7Ro71NoFYsFOAY5XpYN2k++1jrqCmaRb3bMhtuDrqsu5q0mI2xFWDPwufvVPGELH3DTt1wD2D+
 xOIygotzMb6ySnVxSX
X-Google-Smtp-Source: AGHT+IGBgnk97TjSLkmen0/QBcPIWpDSgXXjXN8b1kIYLGD0YjwCM3Xa/qbiCslCHqLDwzTEwj82hQ==
X-Received: by 2002:a05:600c:5489:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-477c1119c31mr141229605e9.17.1764085119979; 
 Tue, 25 Nov 2025 07:38:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf355af6sm261261405e9.3.2025.11.25.07.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:38:39 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Anshul Dalal <anshuld@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
In-Reply-To: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
References: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/4] ufs: cadence: Rename CONFIG_CADENCE_UFS to
 CONFIG_UFS_CADENCE
Message-Id: <176408511923.2395300.10396516683752155810.b4-ty@linaro.org>
Date: Tue, 25 Nov 2025 16:38:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On Thu, 30 Oct 2025 23:35:42 +0100, Marek Vasut wrote:
> Align the Kconfig option with the rest of the subsystem, use
> CONFIG_UFS_<vendor> format for the Kconfig option.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/4] ufs: cadence: Rename CONFIG_CADENCE_UFS to CONFIG_UFS_CADENCE
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/f8d245f3698aae3fdbd9ef6b8328f36747955e5d
[2/4] ufs: qcom: Rename CONFIG_QCOM_UFS to CONFIG_UFS_QCOM
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/9ce92c31d3da03c052dfae49b4ad917fe315df21
[3/4] ufs: rockchip: Rename CONFIG_ROCKCHIP_UFS to CONFIG_UFS_ROCKCHIP
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/ddeb78b022417158a290499ec5957dd5f906b081
[4/4] ufs: ti: Rename CONFIG_TI_J721E_UFS to CONFIG_UFS_TI_J721E
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/b71967457883eddc022dc376251ad3c5c5d9c163

-- 
Neil

