Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFB9C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A49280868;
	Mon, 21 Sep 2026 20:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WlshtRONKr_f; Mon, 21 Sep 2026 20:37:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D58780AF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790023072;
	b=Bz8THbVF66Jy1jA4TvRfsSTgqaNqMZm0/KST+HyaBnjzMPNiQnb0YQy3pByiaE4irvm9
	 hKVJbwaYNxtsZGGR/PFbaHmx8z1nl0/w1JRZgYq8s8RzN9nbRiFZoFwodtNLhVE809zVq
	 W3xwv3Nl6+b7QGvWljcFeklLBtUy0jJOgwa4dWBC+YOKU8zY0lHbK2x9fQKzlwBLysdds
	 C+uz75QdwM5ZljLp0IbpgKbjth4NRpizE/7JLecxnzEV7xkX0elwo9xctyVGw+HfmUdaR
	 GzK6wlKkKiMtoPv4tLmYdckBZSEIEKzmBZhDMXYnHdObxR6YMUqXSO0/hPVAkhxuE5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790023072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q84R4Er2+YOc4y+vMqX+UDWVvpU3USzw5ySAV3wKB/c=;
	b=gfGlLrQ+WLuoiJxFImEG56tHdRIDjaVHu8fZ9Bf8pd3FMx6EApTiDzkx1ThpZy+JQQEj
	 MHVe+THhqlG/ArY3A24TyazWO7yowfV0oZdm83wwY5T95+Tp4mKmFdF3yaw31vbFxu4ih
	 JY6M7Eo1VBdRZORMCvwp1YU6lLpngYNt5HTMYVOy0BljsEVQBwIIf1Z8XN8USej++lm6t
	 8623kAJ6tLNs5czwAxP7xmfLjLU7Uc8q3UdTzJifZ5Jp4m5Fo2VqMpK7lifcWFur4A3km
	 J52xzqkg0lJDGqODfAHFoTkEPrF8VcCzfltYAEwypPGv9KrUVzjzckcLXj9tIgjEyew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790023072;
	bh=Q84R4Er2+YOc4y+vMqX+UDWVvpU3USzw5ySAV3wKB/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIpTV++mLgG799ak1e9Roaw4LA1oj5+D+UKgVAMzj+u2O2oNVSEXzRmxsAbOPWV5t
	 P1pDfo9tvT68sm+sqJtEkJhMA0qgmVFPy4TglUAgWnQI8qi0Mbpq94IE3aUVvzQxzg
	 7PbzoHSYtVjvObI4OrbA/PCTgqUc6Mt/mRgt2yi0aEvOLY+trl3PBJZao2tMtGmvR8
	 OkWS20FZjmT6MfA0dG/377yxW8M+ZI8VYuEvWjAdZ5L60rt5h4df8qHqZGIkoZiU/6
	 /RYtvFE/taeabwRnQQn4ah5qWyDeAURvxeoLObN9WV7JlYsAnnT/MOBYnN3xWiwvPT
	 EItzIxfeC7EAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D58780AF3;
	Mon, 21 Sep 2026 20:37:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D29091C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29E5E40177
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:37:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC-0HXVSBvUc for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:37:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 59906400F1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790023070;
 b=KZ8cEYG1bU4PBNyuEKzQqS5fGraJBIPhHCtrzOCQjVQMDTUgvMBmCGm5uuFd09zSONwi
 xVbEmuDY5PXi+L0J2ZS8/ue3rD1gIRYNJrMNyj64GY/xP2MXGdxT0P4F0PhKZTiaiZiWL
 oSGVLSZB7B+8jD45NS+7XCz3JcKYIhLZizt6cd+lI4T31JIPlfhzDh8UFKwYWVyi8U2DN
 c3ARTf/JqIJdpQHB1JfjbH8N8d9X7WHtXFs9aQkw1oGok9q4q/fzfl8PnDMx3E0Td+yEa
 /80K3SHSLD8iyJkaIUUDSYBfGF8IC6lHXPzBfI2VouSQeJqawlxdnZMGkbunVp0pgjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790023070;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Q84R4Er2+YOc4y+vMqX+UDWVvpU3USzw5ySAV3wKB/c=;
 b=UlvvCtyXKV8gTr3TNNeVsjekwQO8RSVLxgIDCBWbr7Nkp/aVrELAlTTC9z82amgQnSnC
 KqMDGN6CnrQoI/rr8Z3QJR2Y8xWkszLeXgBPOoUKiuwviYKBF5KS6UUx/+jkI+nXvWYD/
 Bi+PjW7kb5SaQd3eHg4xx/IuOJZRk37Ekw6O5k9Y6BXywECpVwk+P/BTkOjKvmv3ZKjRf
 wiJHWlZMrQEOZj/KMsv9IMfZ6KdAX7ch88QeoJUZHCGj0wbTQLMj4QUa6wFLVSKqoqlfl
 F/eTSLGCTU7rtAwGsVc1YCbFy9yCUH2qgBkl2eQ5ribIHLRB1a2EK1ZBYZe7DH1E/ww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ME7856DR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ME7856DR
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59906400F1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:37:49 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4be07e7c54dso268189b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790023069; x=1790627869;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q84R4Er2+YOc4y+vMqX+UDWVvpU3USzw5ySAV3wKB/c=;
 b=ME7856DR/fDfuHflfKOlUHP6W/CWyhHwZdlpsltGGckA1OmcJB4sjp4VLS6yS19IA+
 cO8ZmXjR/0E4eUCiT4R0nNBrw4LVKIR9/OdpsETWn4FkH+zsxeFJpz2KDf9iyhoY0872
 RosmxPh5TvssrCcHuRGJ0MATG9rkctKMA5sT4nQ/9312xqrDj8Lr9wmZ5cfJnT/QwO84
 D5iguXu+vVcTYA+ton+J1DykXAzBzZoRrHGm2tKceKqls+GWsFptMAGU2b0XIzvjMntc
 ZiM1LR8kA1aeqvCXuRfKMbOIlO5FGIoN89C1ug2cFrE2zDUv8CpRA+ExnLK7QSGSPNVM
 TGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023069; x=1790627869;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q84R4Er2+YOc4y+vMqX+UDWVvpU3USzw5ySAV3wKB/c=;
 b=YsB4ffJdzaL6Hn47Ncq+CWrNHgzqyluegR9BIzaKHLJ5iqpAwb9bgV5Gs6zvqq/IZw
 SOzr6qUUPEwmEfz+UOrl7tM+PTifUvpdEjxo707m/7yePJZjljpfEuDLdYx2FxJLA3pX
 trjttxBtgEuAPR4LzLIWoUvcxkCis9blRO1r0YgoTktZEDjuxY6L8IIW0VCHPkcnSy2Y
 +BgCVAI3MPsaPXf2LnlIwunHGkiTerHXXx6Y7acDexyIjOVABIz0eo0LTWPsodvAwpUo
 oChLtk8Bopqo+JIrj8mOVSZ3hQEpZVzF7CgM0XykhlHiiRtaUZvYjbW1sGRPrzrhJD4P
 nsiA==
X-Gm-Message-State: AFuF++nrYKVEBQaohFO6U6UA+UOaF9pdz8TRLv9nV0t5L7QirFg6vawg
 hjl1duuJXMUGWVfqLX4yKv/j3BtSpHhQA6zVYsxzgCRELednHi+hOHedEA7uCF/E/xU=
X-Gm-Gg: AYBFou06IDaxwLMRYxbaHsdZyeCGBuzGtn3YFy6SwirPQShVm6havhLIgDz6Z2t96Hx
 1p9RxGCvI/OlafTJvmr42BlGGBeKxn6gWmoFE8/uIiC9tTtRNLLKZHYlqF3MJPz2eG41aQFPBe7
 lYO93mRGQzcRg3w5tLkoiBUbDrrVe4qTrzYJa+qzYDErHKz/LstAIlXLGr8sHbVgZg52Bc5jhqU
 F4moZeFCiQuuYcg4EjHBWYJCsKKiEkF9w3Qg+8vTI5z272yTPJ2hGicgdmOaIZnJNUGb0U6zMBF
 6J8iZx5HR/IzKXrmfGtbcqwkpOBFsaMvsONoCHaPB5p4QZz1qwWrqYoBOoqx7CPvid2LqMhqYEn
 LGDZtxdiMgS2S5cCqV8Y5lgGBIP/KpKHmhIMHLx0lCXwVtQNBB6qJIqpBkgjaGZgzxfwvCnD3N5
 plNjZQt/fSyDLXA/9wUeJ+DfadM+7/K7l2fFXwHeap5HT2ugI6iw+DdyjkjcbK8E+s5XgPboxzs
 ew=
X-Received: by 2002:a05:6808:138d:b0:4b8:4703:db97 with SMTP id
 5614622812f47-4d4398f7e02mr773388b6e.32.1790023068601; 
 Mon, 21 Sep 2026 13:37:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:48dc:2ff3:bb18:4337])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d422eff067sm1140998b6e.5.2026.09.21.13.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:37:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260902-mtk-pwm-disp-backlight-v2-1-e68c64d29bcd@baylibre.com>
References: <20260902-mtk-pwm-disp-backlight-v2-1-e68c64d29bcd@baylibre.com>
Subject: Re: [PATCH v2] pwm: add MediaTek display PWM driver
Message-Id: <179002305619.18666.6392639214424674743.b4-ty@b4>
Date: Mon, 21 Sep 2026 15:37:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=302; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Ju8sZGHw23filuj5acrDx+pSJLBXkyJA99cF85MFUOU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqsZWSPb2G6mZYffgup8MRgNt8xp4nTDtZw5bVR
 ZnGVnrXMqGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarGVkhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ARR8H/iUb0NIP3HjuAqeCvZx4yWgkkvLpgEoeGO4Y0L9
 AoyDGlbbUNHSySmp5jyMQNrtNZmfoAMQaqLgIZOt0kfgw/GRywAVtz06mCuoO/o03da53RPmo7Q
 WmYp5DynJZBzgLJdmb48ZS1q5Ox+n4zQfODN9gCDxAc+CdemYRF0Lk3MtUH+nX5WuF1qRNXC2HM
 vPuNGnb6stcSaqXNdo2b/xC5IqPhHwgWLEF2sxBJU+aZyp7gjk+aY2G71P/t0M5rY4tc8fye5bc
 zr48W2nsioz/TpNVa+j7js6nGgWhJAqD+IAxt13h2TIYZgkeaRMfbHbo0bWhLjTLLDRrIG0lj+h
 D3HY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Wed, 02 Sep 2026 09:44:27 -0500, David Lechner wrote:
> pwm: add MediaTek display PWM driver

Applied to mediatek-for-next, thanks!

[1/1] pwm: add MediaTek display PWM driver
      commit: 8509800afa7d7a58e486f9adc9e2517acc9631b9

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

