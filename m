Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3468C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D0C9809B1;
	Mon, 21 Sep 2026 20:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHebCFFDv4nd; Mon, 21 Sep 2026 20:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BCE3D808AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790023055;
	b=Ir5gBZZM4zB+n3ZiiUT43kW1x85wkDle92H0MI/HXmkdY4Cc9zahsrlEvVFTNfUm1nWD
	 RgE3IzSJc34pcglIBGDhpyI99tTogRlwiyvo0ubyyHky5LY201MYrXF9xstvTkUx1DpWY
	 mTQzCeuwsi/FvMA7WylM3CbaXNeTl0Z9dug7wDfmciSTCDyf2Qi4VnL/k6gb7UVGhgBCk
	 A13Uloj2ChsuJgeljubPFQ6MVTTVXvjJEv6T2P0+6vPkZBszocWsZhlN+MNKab/gW4pSn
	 osiVm5IETbdM9JdnKmqP8oPCILXLhcbYoWw9j4IxQfGk2/c6InMWFEOvf9RmPcF14KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790023055;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+sdJWcO7wOzGGE9jcuZF0PBAR3NYuspYbZTLyvtpgdM=;
	b=GwR5PY5qzDTiYTfLk+5Z1nudyoJ6bnjqP6B/pSSnwYXtOwLN1tlmKv6IWio07p0SPx2P
	 CPp7lnhZOI+cqwUmJlb70Pj1X5jYWaZV8d6+R2bX8iAzvU8jyiaSVVq6efetDv37SMK+S
	 xV5mV7kt7SYGIjP6ulnlo66UR+/fGsILHhtDIPX/X4IOcUWgYjyoc36z/Sv/kcL1J16ZC
	 1MyBvPB/bCSZ1V3cCGprWXm8VZ+nbcxKObxZsqDoYBGRBrUA2FQ4r1bwZMHBPqJcoQd6E
	 edbTIcZ47kBi7ShQekN5vk5RIUGWWReXWiTg1MH0NwUmiTrednh7uxOQyaOsOARZcMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fOCvWn0Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790023055;
	bh=+sdJWcO7wOzGGE9jcuZF0PBAR3NYuspYbZTLyvtpgdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UOgt9zWIwLbgOh+pTgWZ1agPL/MABr/HkBc+3K0rPSa/xnz4bqwn08M9c0yszvQyw
	 fTk7IHNw+r2IRiS3Zj9iBF4kpZM4ZpkWn9HTw3qxx7O0LqVd2CzTuoIEWKVNhbNw+/
	 XLuFB/nRHhrFzOKYoNfwxtkW61aTYSVtAdzQjCECKYZ12DCgZm9qYszrzS7aW/55S2
	 WKZGa0FoW41fbsgypBpPgu2fH5TKZWTz73v2VK+uOj1NEXiId+Wuq5RNUIVrn804Ya
	 4m7u1vWwkW0q21oQCmIomol3fWLrkfSBOlP6YTjIM+4iBgZMGJe8B1nYJFURNibFCm
	 9rPlU5jNrNj7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCE3D808AD;
	Mon, 21 Sep 2026 20:37:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98A85D1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A4A280868
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftrSuaZDi-MS for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A86D808AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790023054;
 b=J91W3G7Z/zf10hpMXJfVc0UHBCDO7KBSSHs/R8OOD2bgEUIvAwq+DvfcZ93Cqc3ybJec
 XWWBMBrqMiIoL7MojetIyhp5xukZu9LhjyKn1QkccHoT6HAwRRiG811U9hnGAhbP1JQAD
 jAOBBvkYU/esF7g35dyTW7zXK8inBpWaEVOnR+Tl0/nzon5NvFl6z+ThYrdL9PAYdWnPu
 O3cIdpbGBFGnm5eHUIAiIxOeC+w4kfO/jFqM0VlU07rE12usUTlppbLOmd0vvXDQAw8K5
 KsAfvoc91WW8P28lAEI7y+NfcNzwuZ9wQZd+4OILOAo04rgTWDQ6OxfJrwWTDTnYHcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790023054;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+sdJWcO7wOzGGE9jcuZF0PBAR3NYuspYbZTLyvtpgdM=;
 b=fDlNMtoUB/SByujF2+iEbl9icqC+ZtftbGlg+9KSah8rgk5nsZRGBiWJfLmpeKtZOqg7
 0s1zft1jbnYGGB2FImzy00rscgo4vA/keILna0sXvgrP7N+v0USdtJRvwiHWPJ2dvELvT
 0GS+XM+6ucG9bJKPJ6RjF9LDCC1MeoVYMuUtGzobrUpbY24pkVwcNcm5ISPRrPKSRrHTC
 donKy8BLyiaZoitNdLrRk7uaUIo588nDpfYcI6Dp6vgUusBIehP2SY45U8TPQIOlIibHZ
 Q6NX7upUJ+eQYWcA7e0t5UK7rIpCyIu9Tn6zq+9F62RHRanpmn4pK6KilF2p8Cc7oIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fOCvWn0Z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fOCvWn0Z
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A86D808AD
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:37:31 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0cfb29cso1382151a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790023050; x=1790627850;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+sdJWcO7wOzGGE9jcuZF0PBAR3NYuspYbZTLyvtpgdM=;
 b=fOCvWn0ZZ6pGLKkQHbWt5jgURlXqNkZXJ5Y++Cp4fNBHURn8Rx/QZtbFxBFNBQhPXE
 Xt4LziS/YRDOwpqNtI/3UKFzThi2aG2vslBpri7/q3apoxUew6DfgNWUxSgJdXg2U4Kg
 JRdMt7G6xnhybK+YrBMKNWgdp2W6l2BVsm8hzBE6xNU5Bpw/PwHn2tGZv43tQVopSOP7
 M/MRn//A65xk19ZUIA2ag4K6GxxBn0CqWH7kt+Xqxj4osFjukd58mKv6F9SUXjerKT4Z
 xsTghZZbGR9b47FveiTVcOq3szlnBQSXMOHLD2jEWpRnBe3y/DarkOO1h14n8bLQ3vz8
 2w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023050; x=1790627850;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sdJWcO7wOzGGE9jcuZF0PBAR3NYuspYbZTLyvtpgdM=;
 b=FINGIZ7uciTls1jVHLXASsHoY8rsB3WCWk/ddb9OQfxkib9SZOmaJWZVIhz9jOe2Ka
 bD5YnsPjjVpgIamhq4NN7lQ9Ql1eaQxlY1ddkDHzgtRQnEqsz0U+6XZ22pWRO71euesQ
 8JtLs201/PBqi6qAG1vs6g7S6REImifU/TSFmIHqumrlA1/lm2JgW2mzCIPMrVC2mMsa
 AxyTFTtwu5+2HHZ9WCI2VQReIQj5Me4Es1ckVkcfbA22IMvz531k8YLxVAlzJKBf6czb
 tqYL0+xvDaJrhX6uX7hISipSPSkHvSn3mETBaRKPEqdVbcsph91961cuTpGQdFXbfPoN
 30WQ==
X-Gm-Message-State: AFuF++nZYokRwh73F1cbqDOdDO6fzQIKad3BfMgEwrjYN6DYLZzxgtla
 Zr/zh2R4VR1vEkNH3NBMGd5ybQj7mLe5ydTjauAS1K05gOA73ziGfRx/ge0+ghVRrdM=
X-Gm-Gg: AYBFou2eqV9VDQKRhHsycO6UGGCXzKoFp3kGDnwruGQJSWrmX3+OO7Oy33ro/mm7+Eu
 UGNI7LOeJjwfpLgsvnDk1BWAi3vjtxMT/g1oVc69B1au7BrFwG9tpHAFsXuuvqbJsgtH5WhRLo9
 JfrDrpgP5BLzNcVT4FLnwPCK1oaZ8fvyfRBP7qj7Z+dsfNgvsmMI34t+rEnxHfZm1KWtTZM+9V1
 bynSuLdqsvRafPWFNGhXyhR54XbZlxMhrE8iuxTIqzi5puY/TtAQw9qIYD6FqpYz8rlh3xEEhma
 0MXmcz7T9+Lfzff71pjNlErCGZm81urFxLH5Km76d2Q+RMV/KAAa7K9oCHL8dYkavkG4w/v7v4X
 UU6Ct8S4+Qs0KipPHiqV99GaotXQvuOcRbHhsbfcZlrDc6XIdNIt/L3LwZ2Vd+AP/IJ7c25vTnV
 RPDarJ1I2BpOra4bLM5uefV+TxTqiY4egBeFnprx5/h1pXyl1V4mYjn9T+6uos3C5T7jmFsIKM3
 fg=
X-Received: by 2002:a05:6808:14ce:b0:4cb:f21c:a797 with SMTP id
 5614622812f47-4ccf91560c4mr13706540b6e.31.1790023050616; 
 Mon, 21 Sep 2026 13:37:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:48dc:2ff3:bb18:4337])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d42441a915sm1229010b6e.16.2026.09.21.13.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:37:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260819-add-panel-startek-kd070fhfid015-v2-1-0bdb6c6820c5@baylibre.com>
References: <20260819-add-panel-startek-kd070fhfid015-v2-1-0bdb6c6820c5@baylibre.com>
Subject: Re: [PATCH v2] video: panel: Support for startek-kd070fhfid015
 MIPI-DSI panel
Message-Id: <179002303772.18666.14340866809769236460.b4-ty@b4>
Date: Mon, 21 Sep 2026 15:37:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=355; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5YprZ2F9r1rJYXxk03M/FX3W6aY+GvpT0DlOJvFXY8c=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqsZV/j0yudb8Sy4JvkE0sAUWeEvlkjoxhOD5pH
 i7k7v+e9QWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarGVfxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATaEH/A0t5pJJ3NBqEMGUdwn9LIQzO0D6wxVTnU67s07
 3bcgR68QdgNa01/GDsD6pTEdXdJC4JDhLlbuxmyyBKXvOGj8KS39en1/enWidEOd+kUz0DszjKU
 GWcWH4ZXgDHeTD13yKSsVisi2G1cyy82Dm84H4XCYJ1qUOsRmyIsxIbtvSJgx3l70Z+hY0J7Pbl
 E5JUv/rL9wi6mluMH2QZYnGtNW0QAj6JiHeIIOAvqVtDu7n1nIdXurea2JCNqavpXUaJYj5E/ym
 nRnFpk5BSaEJuFSWB9dg3aaEFsKoFSkKOWh/WrPgkWxy3YvGFtjwpIOLB78zAZTcvGw0a1fuE20
 RXGU=
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

On Wed, 19 Aug 2026 13:59:38 +0200, Julien Stephan wrote:
> video: panel: Support for startek-kd070fhfid015 MIPI-DSI panel

Applied to mediatek-for-next, thanks!

[1/1] video: panel: Support for startek-kd070fhfid015 MIPI-DSI panel
      commit: a97302427e635faef527eeded9e66e7fedf7e7e8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

