Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F9AC88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 10:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 042E840702;
	Sat, 12 Sep 2026 10:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SfYq6klTMaUd; Sat, 12 Sep 2026 10:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3D4DB40600
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789210312;
	b=UndP01JUy4fnPu4G1vtQtUbOW4Xk8EtXQPg8Y69YuIfrtuC9VgIyDaxCYRrMKy4+DnO0
	 LlS7qZXoa/tTNyFVG7nTda7W/g84O/V/WfNJOJtcspprs6rnzTwG3ThamDqmvKzKdtm6d
	 IlOuaH4qVIMk45+e+al7MVbaQpPppJFwyIgK8SzBr2O7Z+ST0XKIuLY/k0jmy73bbOli9
	 7s+/h2+mFrn2FAOSJUknXstwclK5g+Fc5AJwjWGYx+UpieCdJ4xgjyGBMrdEIVqlsNCEW
	 YEEMN/ejITFCJo0ZgIc96km7TYgwu3UF3OPl92dSggxeLbDo3WSYhi0/v8PmkQhQV5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789210312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SGMqnl5oGefZR0pV7fiRGDsN0m0BlpuJ6EHR1oIpL80=;
	b=ZYNS2RMfIGi4wZxrfU+ZhFRJ7AKy7bWoncprWGc7ErXY/2A+BU3NGYUu0QV8UwGYDc+v
	 tWCpo7rlCMVvwgC6DMs1wtOzlDYuhKJ8MF8uefPOT7vGsXfVlVh/tl1Yj5rhQuD0QUsiE
	 /LOxp8cuVq7nq+32tyTFck+kn3tgbut6lQzlevScIJ23bNnwCKgKEZHrxAwg/kbCzUQWs
	 tjQV9URE/zqn1Niwce7NZfhBzltjhSOn5lNcB2TuFJ954I42Bdd1b7Jhzaate2mZYCQ8F
	 Tnb1958LXF+1a+pVE3/Hjhuvhl6M4eGtlgGTndb/kwOcLlDnG3yiu6dv93GzdvdQR1Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dVA2HnR8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789210312;
	bh=SGMqnl5oGefZR0pV7fiRGDsN0m0BlpuJ6EHR1oIpL80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jz/yUyfT6n2t3zAQD9XW3fPBOo4ExjBxHYF9za3eDYALIs5kxs9/ptnZRW7/yWTdb
	 T0BgSTBBDUyySdvfrPZ4O/0XER27/rHkPTQSjtQJhMcK3CykYjDwDr28ZheAI4HL0r
	 BflcWekAH3LNa6vFvAlkCudtwCF30+7m8cfUyE+x2O/SciPXbkc2sSc7/DbClNE7a5
	 wr/NQBhUcZGCLOj94nKI2q4cKn77rQMe1+Wb28yA/DV2ohaNOeJYb3rHnba6z3da3k
	 qVzSPK/infaJVFtqJatBnf8be7d/BgJ9mUMMM0nUJxrvpT2ilzBl0BKzFUxKPnWztr
	 jssHaE9DdOmPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D4DB40600;
	Sat, 12 Sep 2026 10:51:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 522442D0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 10:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43C3340600
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 10:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0MjZAqqKNCRy for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 10:51:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B6EA6405F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789210309;
 b=IJ+QF9XpVGCgz4c/yZPmXJyukHxC1hai19lg6J2/Z4w1I1zXIQt4MeU6Ce5XkXLXQvBt
 U56IJi2lpjmtkWLOC3uOmwTBaa2TzlixvpzWDIlZg91SyP9ZPWs9qkQEtiXb2S1lJl4PB
 GxWThpPD8Rmt3lt7SuDb+/804dSzfA6cq3kEdEJXIxQnHenos65x4AR8EL6tgIvga5jUh
 hAI4EldOdo2TpG02T4/HQzRDfgZKcc/q59PVRT2Rgbc/8Ax1cVICt8jcmWLp0i6s7cDgJ
 o4Ybzqhha6A1UQ/BeQlN2az03ge/4W6jyUGE1j+neNbbaDUYb/dzUBlw+LLd7z2hg8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789210309;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=SGMqnl5oGefZR0pV7fiRGDsN0m0BlpuJ6EHR1oIpL80=;
 b=I+uts0exwBKpQ8R6NsGADIcNNEK0YW7rQuwB6xIij75BUw4QdkQRUOfb87cDTI+GqyPR
 mHaVgcC+VxKFPQabC6R8RztOpwkBnTHD3+49U8GLiS8TOYg4tKtntlQBtF6SSbHirizX6
 Os4PbidGVKs+4G0duN7FuYbfVqJOFHtYwkhOMYuhR6krpozmpYkQ7Qq6spuYBVkAA5lBK
 car4twDdz1pHgxYlZfnAxH8LjvJjLXbOOqn/jGh+czbgqFybvgXWtZr4b9/JBAORuJgWh
 dOWL1l3jBVlh6N1fhwBFTgIiQRGmBoT8VaAt9qZOzbDtgCt4QKP35c24lIvfBvB/9GA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dVA2HnR8; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dVA2HnR8
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6EA6405F9
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 10:51:47 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so2319745e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789210306; x=1789815106;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SGMqnl5oGefZR0pV7fiRGDsN0m0BlpuJ6EHR1oIpL80=;
 b=dVA2HnR8ao0gGwGP9PAt6s1u9fJPi9P1/hQy7sviRfx7HVI4XrXD7iqRUzq2u/JKBy
 IgkwAg0p2DGqi0TTWtjV7o4eFAprztLdhntLqF2dVxHN7fxdpa8wzGt71ZpbfBLPobZO
 uwzJWEJUWG3gePRPnKGE2NtsiGsbqCrxQjEySmjTLCt1agnEh8QikjW2xvzhUmalKFsL
 I6tht1zEfkTs0Df1GSSYOrsDw/VewLubgn99Rrc5O7jinfb/f6ITZkcnD97/AKHJjrEm
 2rHsq6VCflE/riuzlT7CF/RutzS5aqiqD89AdmeJ5xdd50PbueW4qTqoc+vBKkKXQrqm
 6/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789210306; x=1789815106;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SGMqnl5oGefZR0pV7fiRGDsN0m0BlpuJ6EHR1oIpL80=;
 b=o3HeLmtkwxjITW9PYTN8m/u1ySdi3optOUaH1Jm4uh1blIWsp5jHqCheqTr6nO6eob
 457Kpvu2eNx6oy9qoBm0HXbSBGndRuI1qUgsTVc/wY/kva3qnvta5lTb74q5+yQHgXaQ
 h1cNPpz6ktbG8VrlC8qmVYA8qqjPG3vXYS09c84OQooc0/h4yyDlZOvlnhfLonuWMhl4
 Xq2qvNBXDNMnu5Fxst8tdotoPDV9LYFJ+IHubp/pXggvDd5GH+jxBMV/XB0+3gsx9FyU
 n1yzu1sGQjyHcEVm+CS7rjeiq+AnRnw4XIe3d3ots49LzdHb8QKfaOU6oAZcDIsJwSSG
 J7RQ==
X-Gm-Message-State: AFuF++k2DDBXf8yb+RXf37DSYsLozooNgTXusRtk7C6BcWFbq2XWbyP4
 jx+Xi41QEXHHjYT3Fsq+rbaycsGYDWpjLOefZC4sLV/DuYFG0zevj3JRnw/pB4gbegk=
X-Gm-Gg: AYBFou2+V85SM0q8osNEiadxuimhkAVpbO2fiF3xDMC0I947t5asEJNCxNZzs2jrqS6
 swU5GN6SwvDe06IoG40SsU9VNJSIm/AmGIYGM8Dta4FNNH+G57lo/79NkMuhy8B2eX7tpo6oQuZ
 HafMfJLfWx6q9TFsT6GReMLg9aGqmEca/X7fAwQYyHkdhCwHUUbO8X+ReaTHFcC0Rb9uAR/rHGV
 YsW9u2fvVcxrve2pqjRNTkvv40ecBUiFwKXeD/4tAqYXh+CXE7YpHzPztzIP6SgGNWnnVrhbl+J
 jk0WPtn+EjE/vvB6ksOlaNxVaPKFj7KVQU+Ytccz4EDrJaDVbA/1Pz+hPGnOMJ5bjPVrPVpeexH
 GgmD3ZMSYB2LPMWk4GDzxDY9zPYzCxqj1c+aFp1D7fS5XfyIjvjd1PycrtmpU/lCQyy5SDwHSwO
 HIv1qcNsc1rFUrHMVTvUnj1MS6g+fo4MlvmgmgEReKTUfaL4BlsXEHFKYqaGTGXt3pn+YqC46Sa
 Ywfg+bXGqVMhXfFRVoYyQ72gE8FljVY+k74YX74SHn8XaHP1Uq+yzOrKw==
X-Received: by 2002:a05:600c:c4a4:b0:49c:fa21:1c86 with SMTP id
 5b1f17b1804b1-49e6cc11515mr19233065e9.27.1789210305528; 
 Sat, 12 Sep 2026 03:51:45 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2a419sm250368745e9.7.2026.09.12.03.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:51:44 -0700 (PDT)
Date: Sat, 12 Sep 2026 12:51:42 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 uboot-stm32@st-md-mailman.stormreply.com, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?B?Sm/Do28=?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 2/2] spl: mmc: support dynamic selection in raw
 partition mode
Message-ID: <aqUtjQx0haoqjaNq@macbook>
References: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
 <20260911-ccaione-upstream-part-dynamic-v2-2-295fefc9a3c4@baylibre.com>
 <20260911174122.GS1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911174122.GS1764417@bill-the-cat>
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

On Fri, Sep 11, 2026 at 11:41:22 +0100, Tom Rini wrote:
> On Fri, Sep 11, 2026 at 02:05:59PM +0200, Carlo Caione wrote:

[...] 
> This is better than v1. Did you look in to my suggestion about turning
> this in to a choice between hard-coded number, hard-coded type and this
> new dynamic option? I do wonder if that would let us get rid of a lot of
> the if/else nesting we have in these functions. Thanks!

I'll try but I do not promise anything :) The problem is that it is VERY
easy to break things when touching this code and relatek Kconfigs so I'm
basically tiptoeing around it for now, but let me try.

Thanks!

--
Carlo Caione

