Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E09606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ExeMkOJ/;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=R4tpuyIP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F433811C8;
	Thu, 22 Oct 2026 21:47:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHGNg1fZa1Yf; Thu, 22 Oct 2026 21:47:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6373681176
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792705671;
	b=dW+cSh9QMw7rwQWdsQb4wfL5oIxImDf+0K+eqExJ5ukg0ivmNxpFrlY37DbW1wMO2V5o
	 9RQLdQWCdZIINIvHDze5HdWbjJvaQTvg2IiRjD0To0SAydYzOQu9xIma/hP0Ku4vMNQO7
	 DtYqGFVnfk5ef05UDwMuz5i4RlsOmSalML+n/Q36s6Ai/d0I29kHlcM/cWARMjQSuUcJo
	 SG3ezssL/ZRl6sxW+COfdubvZj/vHWzjYwYkkOvWyaLaVFKYQJDf54LaLN3g+hh/Ay/xP
	 PTvHRVDtjwmI6BxcAVkDnkcgo/bJ6Oy2RJxJA9wFfh1i6VzU+qQFvP72DQrkFtZB1qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792705671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LqFJRTCOzR/9PWmZb27zVutZFAMMdoCsSlqEOENIFEM=;
	b=TflCfrwMBX0faJySd6z4pQRfLST50h8TcPWZB44jU1QjAPgCLmNEAXMKjD7eXa4RvTeh
	 +mR2AR7HWuFLECfD+Uh3hRwAPVdeUy2+dbbtc8wvTEnnaBlaWzSAcyE7PuJ508Y3V5a46
	 dg86u/qRD1R0+dFXmI5DqwUcNVFcV7/Ly9OrGnfpPQy/Ni0oeM2AJrjICYi1KBZKzgsXH
	 Larr4Q+tQsNXjHMVIlkh+hjEmhkaivw8YlMeaBp9tXNrMejy3AmqyfG+E+bNgb88iv2T6
	 gkw0e0ssQcns1bqBdyxFRVErXCQQfnSn7zQhwiRnpxf3qI3hZ4Pj+o1n8yzVrAxCe9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792705671;
	bh=LqFJRTCOzR/9PWmZb27zVutZFAMMdoCsSlqEOENIFEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ExeMkOJ/Kg0p7wv+HY8heF+FBSlf5a9HC2RvHzzekgZJcTEAe7wO+jQB5HAQwaZ2n
	 Invd6C60gRqjAWd/pZYYceJ8BwLvtCPiIojh7rmUHUr6Fran9yILCuZuZ6rKgjolL6
	 lgYyb8sPIWup7a5Mi5lWFYNe25SAvRlmfSc+VFiaAs1cSdhZAZVWc519+ofxScmvUF
	 LRRCYG+eDbC+EwbCqRqN9dXRZozzoQdy3Jj4//GMxBJwFlg4wYhTD2/W5/FoKUec2Z
	 8Vq1gyawxl42b/yTvR3qmUSpIB8IhBZLjROERW72X+YMXLyiXJ2TvT0U5Z6HmmUFZw
	 OUTla77ht32oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6373681176;
	Thu, 22 Oct 2026 21:47:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3546A499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2777940270
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q7D_VlvkI7KC for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:47:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E6E8A401DE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792705668;
 b=lFair1ARldr9EF4qoJPvCTYimS+GT6W9SkHQk1cnzSpXPtmcRw5e8Cnysg1kv7S7iI/o
 Tp9/mlVaoy7VGPIeh42JDYsiMgeth/bY0YcmnNutEOMpfZW0dNPbSni8wWn0mjoZweiip
 SFtELER6TkakrTKaNeAvZ5C2N4X09dJoWnP5zAukKSWFP12QCOGLKlZpv5KP3w5YDveYS
 6fcAhCl6nfMxiZ6WCu4NrJEb0iK71tow/EjkKVdXe+N3lihQFuiUcjTX62fBlaGi6U1dh
 JtB2L3MRkBSY78hqYsWwQobUntSCNb+fh7ccGj+43or1AyrNsgKbxR57/KH7ardN3ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792705668;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=LqFJRTCOzR/9PWmZb27zVutZFAMMdoCsSlqEOENIFEM=;
 b=kBlsohNBbWvNLxkEDE0V+YZ9QQnyYkhCHzTROmyQY0rH+k9q3Kxdym+rhv7tFMk/8WrY
 7zw0NkJyN8P1PUF7t4fAi4DEOa1RhfoW4PdFDvojzgf2mri7UrCSwd2rQIVfzcPJXFchI
 wIfigcaIdyW1diwQjEPuny7PxIArqzyX9R8pQFM+cXJcDX5FtZCkej2VhRsd3zXQylh/K
 7XNysZkAU2ZimP5FLSme9GW5zprvlA3snbgjTeV4L0VVBqVxBq/Ul/yMvX1uEHkV/DqQw
 AKPsxYzxaNNi487EV6tfyPTwSsmMS7h8zcSGZi6XGZLzVAgujVSPBuk+HOPr5D1QqRg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=R4tpuyIP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=R4tpuyIP
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6E8A401DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:47:47 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-81ba09a5d23so200897a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792705666; x=1793310466;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LqFJRTCOzR/9PWmZb27zVutZFAMMdoCsSlqEOENIFEM=;
 b=R4tpuyIPYh1o9LCv8A9wn0nsExS9K5teGA+lvUpKGAxTYobbz16k0DP3Dm6H0dapDF
 My2AmDzsV4koaAgbcO3LnFFvDFVzbChGVtvbjnkqiwZKR0sVgEh6De07D1DKI1HFiCHa
 lCOgdCOdFGS+vfC3SBcUkye1I88CadvBIhegfjC3TpBoKjsvwuBYzfAgYPBWroqQrZeT
 3n7UXPR5p96K8eyCBn8EuLU/T6/tS+yxnNhJl8JJrz+bkak2ahs1kUNph6cbBjwibWkD
 iCDOrgnsuKkRmCis3rV5E1+HrCzcXQ8241raGEH7u2a/rpgGNw/3anBc7xf5TOkv8958
 R+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705666; x=1793310466;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LqFJRTCOzR/9PWmZb27zVutZFAMMdoCsSlqEOENIFEM=;
 b=NTR+W02WFEIc8P5obj6bXJkwbe7+OVwMa7oGUiHHSHl1J39L+fyXQByBageF3UUO72
 hqboNhfRu/V0sAzbMuFdJHZ+iC2HUs/o0zgFN+gV2IB+TOGKPETqyom6gf7FWVJL8mGq
 EFu+wPH5QxmHRvMrQNoWevLOhAyVK0T1+x0KNkzD0fl5+LAFxpb4KH3Mudu/oAiofiBA
 02W2ATxoH/oOdMmsAvlM35hKKgHygJyKTwz187XkD8iSy13lQN+nKdgY3XJEY5R7SZPt
 e3KO8q00mgSmG+lLrB/YrZQs2BxZ7pp4l+metMR7X2nwkyAgbOAYmJC/oANz/glJGovh
 l1Iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6wQAcRYapZJkBv7mNBCAbssJ6P73AaOg+86nk5K1LGoZwpIt2DJjJEcUuqNWw3Ehb50zA4NM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ7EI1Uf/SG/xfBuOwCqJHQMo1es6hgDFS8vYPEXvFh8hQkQEYs
 fpLnlcuMfmhpSgjt/zlhiCViW07gVhVvzKr+ZzbrvLpHTvWZI4mUNl/ZivfozMztBiKUaRFD/oI
 9o00H/Ss=
X-Gm-Gg: AYBFou0Yz2/zQ1xIdTFB5K/Nps0vxmFdhf1BGNDRgntBPEpAaLr16JCSwhdoABGKZD6
 QjWH4vhUur0ovfsxT9HvmKgkYfwcy43T7j+PPCJojpru6upxz3ErxDiemGAvFWdUygzO0i8lXfv
 l6UI2JqfXFhxDJUBdtestNNwqZ1UWJ5A9fP23wSaRhVkD7Kl7RiCZVr1nI+vbo3R5l+oBnEEGJX
 zDeYgzpSP0jk3BuDZAhrk37hQvWl/FkVUs1sBqZ+CeyyXidF5EYQZqPvyK/ZDvI+RtXIPSfSMJN
 qSZoDoRymOktWo1nwcgZZTyRLZl/iUc2kBmtEWwjqvk8DPTzJ1KEE9D79QELCYk3K1sy9oZtwmU
 TSlgQvXwzikhkkVZQa6qvouVw4e02Pj7oSJM5juMvhV1mK+yRTNmuomJwY7Bk9EI4r6sykRnVKR
 JHSSKjkfIUdaRfhINy3mYjRSlj+ePsOeqFu0kmHPm/oKc0oYlkyiK9QvW9pZgVFTD+u+cqtJnsd
 +qf5w9AR8EjtHWQdlbQXTKN+8TIkdXEyqhaL+XVRzN2kGbY1fOPh+WuBBNn
X-Received: by 2002:a05:6830:440d:b0:81b:ac5b:ea17 with SMTP id
 46e09a7af769-84faf57ed85mr348018a34.16.1792705666445; 
 Thu, 22 Oct 2026 14:47:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbdf62c1fsm248383a34.16.2026.10.22.14.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:47:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Heiko Schocher <hs@nabladev.com>, Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
Subject: Re: [PATCH v2 00/13] mediatek: add DSI panel support for MT8365
 and MT8366 boards
Message-Id: <179270560808.3711947.6058982507354459998.b4-ty@b4>
Date: Thu, 22 Oct 2026 16:46:48 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zvCuacvEs/wrXj9nlO4qJn8RDDgMxMD1hhOgwsOM+4Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2oR4DrmTk8PJr/uoXnkbmtrd0b+NDgGLjrVXh
 c+mJ12mtz2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatqEeBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aw0EH/0oR8/xP1/K8VFAhruDNipVrU3EoE5nkJTwhb96
 2EtiZ/3x5DDDn9GB0M51Ca4s8vtDy40TEdsRGjeRR+UZjCs9eT+LtdsPftnKQ0ZSgcVs2hG9Gca
 6AraY4Ajo8i9LrLSXdTJwkJP+qi3zKadX/jrEdnJInp8ESNlYcd3WLEbxhSKd+QeH6GNCb1M7JT
 gdZx8Yfo+jKvsAsVGlooPoiZ8WtfrNQXVsuH3LhCvs+GUC6cnwB81Qu3A4gytCGDWOauNQXX9C6
 CKECh7ZR0ptO+nOByatS3fRNX6qMtvJTA3i4OXw0yko18EvkIILzm8XaWzRGT8qJsEFpldMCVIP
 ouyU=
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 02 Oct 2026 16:03:51 +0200, Julien Stephan wrote:
> mediatek: add DSI panel support for MT8365 and MT8366 boards
> 
> This series adds DSI support for MediaTek MT8365 and MT8366 based
> boards, such as the Genio 350 and the Genio 360 EVKs, in order to
> display a boot logo on a DSI panel. It builds on top of the following
> series, all sent earlier:
> 
> [...]

Applied to mediatek-for-main, thanks!

Changed the Genio 360 defconfig changes to match the Genio 350 ones while applying.

[01/13] memory: mediatek: mtk-smi: support smi_common and the larb ports
        commit: 9867d07fdb993a5cbfadff710c36a33b13d683de
[02/13] video: mediatek: add ovl component
        commit: 5491d69ba75617c9e4bd15d402e92fa966754705
[03/13] video: mediatek: add disp rdma component
        commit: 18bede0eeaab0ce89750245d96eedb6af6a9111b
[04/13] video: mediatek: add color component
        commit: 18f30ff64e653fa1ca44b7c0478becdfeed6b304
[05/13] video: mediatek: add ccorr component
        commit: 50570e150c776d49024d047d273adbdc94262877
[06/13] video: mediatek: add aal component
        commit: 42a30ff6670429dcb007e2b78401e09b8d732ab5
[07/13] video: mediatek: add gamma component
        commit: 8d2f90f12bb0076b4d84d7a5f2ff993dbc37024b
[08/13] video: mediatek: add dither component
        commit: 0aabb3906e1e5cf6fb1c4af925d1c18c575ef349
[09/13] video: mediatek: add ddp component
        commit: 19589afadbec862a8d7941e5912b30d8d52cbc0a
[10/13] video: mediatek: mtk_disp_mutex: add the DSI pipeline
        commit: f4857a693b6f1f893499a001a98c532a5eef52cd
[11/13] video: mediatek: add dsi driver
        commit: 001fed65ef9378be4f934068c54111184da8c430
[12/13] configs: mediatek: mt8365_evk: enable dsi pipeline
        commit: 12dac5b404c6b0cca2334d76b7a65779e0446f5b
[13/13] configs: mediatek: mt8366_genio_360_evk: enable dsi pipeline
        commit: 1650312dd9552a7dc32b6151cdbfa136999c6138

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

