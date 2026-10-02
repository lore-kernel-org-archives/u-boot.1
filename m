Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFEDCA5FD9
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 08:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A017981139;
	Fri,  2 Oct 2026 08:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0OGWNToaHXF; Fri,  2 Oct 2026 08:34:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C917181115
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790930043;
	b=cVCe/Jed8Pu7LHpXW7A6uezO0HppK2iD3M6tsjxN0HDAxVRz+o0ZAu5TdSfCYjdz4x3l
	 MqHwzR2PhPwcAjgcpBnalLVE5rG3C8fKFHsZfnKAFB3HCeJoWDO06boGeCNGyj0EvfqJG
	 Hnn7POgtu2WiiS5VITrmOkxVCxlY5qU3xEqEb6sbpoRjxFx1FmDBMbD6UueQIXJa8wThl
	 SrzNaO2Dtb5gesKheUjvfLyXHAoAZoAa7x34eEURR0CXerozxsbh5iVkwp7HvhkRZopsf
	 7Hf9/cuPQjueQJGmkHaL1u+gkWKBV5KWFEp/6AT30xAO2j5aapjf1xVomWGUrbtwKqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790930043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=55YDkERgqtr1XVCnm1XP5yTvswxQK5PHHacfw+lqE/A=;
	b=G94q2Urg9IFmxJyyKm0WNtjVaeuhv0+Vs3I7UuO4im3S5CWnEhTlohL9ikszozi3fQbc
	 jUHZE7eB4yfKQ3S1SPyOnwrbJOu8T8g3PDMS5tuy49VabGAYEWHKGydpVYy1CgMEjHOls
	 zjCxfBOPOIa7oa6H/W0sBSPheuz2Goug42V51AUG0x4imbWkxPHX1WiXZlljTa7anxvE2
	 9HWEcKoeY2s6fF+dnO0CWC8eLPn9p9zNM7aZEDWhFWftXTy0m/TCjQPaM1HrWAAZpylJz
	 20+gDj29t8eTY18+Vw6JM5t2eZguo5HI1LCcd2Boqw8VDXSFazHfYYfGlxX2xJsReQQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790930042;
	bh=55YDkERgqtr1XVCnm1XP5yTvswxQK5PHHacfw+lqE/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q+LX58cG2VkGpZlbbA5I1fJJaf+6ac8QTkG9WRbD3KaDKOqkjao5tAETRLhsgIUPN
	 Bi2mUM1pb5RcQPsMQe8FatDhPw9q69Euz8Zg25bn+OqWiiMGpnNaVAdFO/B7f6k31Y
	 52PiKhniKxj+EtLG2hX1R1h5PoUYh1s3DwYaqNw4ks92ZR/n55D05PgEKFIt64PhyU
	 hXbaPhI75gJnUVs6HBOUK9C8w+H1PxLOOQzNGcHjo7CfallBzqMh/cqPW007tVNgmJ
	 4T5N2tuD/7+Tn5O9fA/El7J47m2Usy2h5x2FntxGkQZ0yZsVqdpGs2Y5erkY0L8O/Z
	 S5YXZntPxtovQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C917181115;
	Fri,  2 Oct 2026 08:34:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AB4634D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5819740847
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cEn9xmQEFW0T for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 08:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5321240836
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790930039;
 b=Sfbk2ARAt1GMQB2npEmLmN2HByVt8sLBstwENj1Ey2MT7KX+ua4X9r41G/DZp3W6m5pk
 CeL2lTityEBFg5G3AaPHOUnJ97Ng53De6p9l73uJpuSEwiouiUBImIl3n6cWJMY26i5+E
 q2iTolqI3mD7B1ZJrqnbppV1uxY4StW1wHglS4/Ghj9QRMuu6KRpLB5qAWqJyKircN91I
 0fGT+rl/fBfDPxZDqI2zjVDuNK6jawlv3W3Rn53/ECrONfHE2BIAi2z42r5JZfzn9lUnG
 BcRUApAF6YBS+NuuoXbtiRhKoKvAzp4ZQLO7HIIae8QXJktXa481hMb0ZFAQLteLafg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790930039;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=55YDkERgqtr1XVCnm1XP5yTvswxQK5PHHacfw+lqE/A=;
 b=fS1JgvPvKY4ywH2UQ2lOdb0hYWTkvTwvnXN3WFK82ch7rzn/uEYXFbyOrD3J2MRQBftM
 RlCs2vggrOksxEuhGnkaAVv+Bktmu22XBg46GzT9TNqB4t1tgCR2LLBSRh+T5JwuXkrw1
 6VPQBGpXTUy/whjV6jDoGCt95gkNDBNVB06yuKtU0du6rVI/qdNfOuXor2y3KRp9V9TUJ
 U621dcnNBhMukygvslu2NOjksFlmIcEe3zO70Ta2tLqfJeyxhjY4rbabOhorqstCBe4lp
 8THZ8deLifU3eEUzNRuC0mgIGH17Jizv56D2tRoa7AzWNHQCuO8djvN3ukupAhvy8ig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JCFh+TlY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::e;
 helo=mail-yx2-x0e.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JCFh+TlY
Received: from mail-yx2-x0e.google.com (mail-yx2-x0e.google.com
 [IPv6:2607:f8b0:4864:41::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5321240836
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:33:58 +0000 (UTC)
Received: by mail-yx2-x0e.google.com with SMTP id
 00721157ae682-895fd505824so65203697b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 01:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790930037; cv=none;
 d=google.com; s=arc-20260327;
 b=Mcn/jpX1Q9KMkwK9NI+Y67ifTnDM10of429wjbjxvOP/ft+QT1ybbVie1MfsZZk0RI
 94Apu7k7y4viMI4lNM0kB1m1cnzXvwdjVUsHyhJc/N97bPzBezqzRRxIgNkHHzPLIe7n
 ezsGW+SeLqG7SDK6/D7ff3AvClrEihiUPxqWotYSBSLa/pglSqeJKQouS6vsPCeAkh3c
 WTenNGJloA5h5q4/fFKpsSUA1eutnoCu/wyXXs0J4vxRmOgViHglU5bQlrlijDV3MJ7B
 3yFSm1LiyURoCcNCGduzKu+WrUP4xChoClth8K1wb+1sHiGv0sna3VgUUnEceMwexR7q
 e1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=55YDkERgqtr1XVCnm1XP5yTvswxQK5PHHacfw+lqE/A=;
 fh=7SzkCKB/gzeTh0fGr6fSLT0QvZ3WZjThcXiBbm/aTec=;
 b=AgWpp66q3K0io7O+GizDmYzd59uEF/h803oJMqoRtwWMY3O9ezdgmRDJ5EgCCoFoxB
 zjI1G4vowhVwV5GQ+312cAX7n1Snmt/mzDBQNae44mEVaK3mIcZ0RKiQIjxfeG20S0Ie
 BMAlOkN86/i7MwJ0zv3qF3ef872IY4DbKb2U8SXQxiJbrr15tDD0EPCBd/HgTtLeVFzw
 WM3R0mDUcdhrZdQ0XFUtMADgmKIbYvR9jmXURddVZcL2Aruq3/zzjLu9xOhY+33SL+1I
 ghzQg11wuAsGjpzO1aaydXdGkurCq8fBzCuox96MnUjkX6DsyWifP8vLIgoKp7WorVWS
 0YLg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790930037; x=1791534837;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=55YDkERgqtr1XVCnm1XP5yTvswxQK5PHHacfw+lqE/A=;
 b=JCFh+TlY/9doBnB7DycMmuN1IIDQmzjZBIfDwx04MPcoVunZ3QVzQDQL5KWWXbJhj8
 jUO6XUgT79NUdHxEWuoCSptMnc9KPh9l3RNRZI2I+5opJenCAekNuCe+yDrObVE9YMN2
 pbF9HoBG5FY/+KNjNm92dcQWxBA4aTCmvWlikWkWvevksKvTdbtUA0z2GqnpzIer0WII
 t2DSYePI7MX3IVnAZcq3muNWtdkm3TnQhiAvXcBQPWDae0EehwWyQVnGZOEJB79O4MRd
 wm5hFuHUOe+hLfysYMJ+PiMHTSCk6fH8GSC8S53P8nIBMHxrmwmpgjG2/uyrtJx+Lje6
 2I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790930037; x=1791534837;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=55YDkERgqtr1XVCnm1XP5yTvswxQK5PHHacfw+lqE/A=;
 b=b96UVWt1MCa7t9Fhz0xVuQv5x/sC6PnYXGH0oLNMJM8EE6yvuoLDOvHVvtrBfidldq
 li1/M14u6u9uLF+/pYkC7p656Kn8icKH85A9dR2wN35DxM25gsiYAXDyOmut/5T36vAa
 OuGzv6MktP3LMIumWeo8gcx9Xdf9kew03PX94FMB0a9zjMTDIGzzxkTblaNOFmuiPHKV
 sWqeQSg7k0B54FeCEzCxFuQTB8+5KpBFBiFSeoyaxKvZJUyFzhbDJH7O3rz2lXIZdOKk
 POB+6z4DoC9aaNOi6UFqAhPuyF/p2XjK9JS3r2+ozbVKoXXQ6kl54Z91k6IPs7AtLiZU
 yeVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLqYs8PwluE+x6z57jqtxVMI1FyiibWSFr/S4+7ffIyefXeCk9Nd4aoDancRGyyMyNklDT6bg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKk28uJ6KknuQYRz5bF30jak+bnXHaT1IrzySPZJFKxdGSTU7r
 BtmVpDf6loIs7N9gO33YH8UwdcTMoP8l8p7vPU0T+9+QX4zy4IcRm4aCW0VL0vk0DL6PCjsiHts
 3y1P/39wG8XcoqLLnGuH6oA7MQSIaFpq8PDzXP43onA==
X-Gm-Gg: AYBFou3SedeFJDpXg0vJw5qUi7RSTymRO/cjDyJLriXfABzJJRhrsKu4cT9h7pbAm4H
 zlJS5sIZGFspffBPFfmF0wYrBQcAfNlxnNFVDMc7aHZ/Ll3C6qJM8qJUk+anlpvwYqEgGFh6Lai
 8IkAqoxJSHdyLGDfal2llyUuuCExVKriwt32ELKpXqlKyqq972pYNoUVwXqDGSj7ztNp9/5rvBK
 8lu4rOxwQnVVd1TSD2j2b2qulYktghMx2XwI9qby7SInP9FPsVn5EzjMHpmrlyjkaW6uC3fRleP
 OzwZr5yFPQsyoBoKGXdYNF0c197grgdBP7JVhrR7z6JG8t+mDXRCLcGTAoGZ/EIVIUtvQdDr4Vv
 fNDvwG5c8+14QJX7sXVMQuRlDaTsFKU7uqmE01RK3RRnBhKZvBE9jFA1TSUMOY+kP3WTxDKfsoF
 NXcdV0/OtQhp/F5h5dN2UVNsqw0TxNY3Kp+UPS6y7+yJoiO36oq5mDfQsUt9JZu37liALUPKpqO
 jACtprteKvf/JgibjwDmKxqPvU+0arXm2KaLFERoLnb44qhnPIKsujcQ1GXtJ2Y2DGGRXMT3XCV
 Hufys5yQ3BoN1YFgw72B8NfOtPk6x33JJ7RVjefdh2xssbLdV8MC7pdXdg29gseO/DSaNhYIBty
 LYGuj8Pbh22qQPeaQaG+jzXM87iI2c1cyob112DXn/QBBD9UuKbAXRg==
X-Received: by 2002:a05:690c:f08:b0:882:ef39:13ea with SMTP id
 00721157ae682-8ae39bb05abmr6150687b3.28.1790930037354; Fri, 02 Oct 2026
 01:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <6abb787b.db7c5649.307e91.b4fcSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6abb787b.db7c5649.307e91.b4fcSMTPIN_ADDED_BROKEN@mx.google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 11:33:21 +0300
X-Gm-Features: AclHuK-Lk4qei9kkg6CCl8kVtABIktF8_KtQqWWV6X8WtzHdgPXwtfo7pzl1W8c
Message-ID: <CAC_iWjL6fAt=rZHg4QdWokfz+jP_AGXn4QSUCQ-oKjemze1PoQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>, 
 "Beanhuo@micron.com" <Beanhuo@micron.com>,
 Zhaoxuan Zhai <zhai.zhaoxuan@canonical.com>, 
 Ethan Hsieh <ethan.hsieh@canonical.com>,
 Jian Hui Lee <jianhui.lee@canonical.com>, 
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "n-francis@ti.com" <n-francis@ti.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, 
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>, 
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>, 
 =?UTF-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>, 
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, 
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, 
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
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

[...]

> > > >
> > > > We spent  time and effort doing an implementation and sharing it
> > > > with the
> > > > community - it wouldnt be fair to us to block this merge on the
> > > > basis of
> > > > downstream projects being impacted.
> > > >
> > > >
> > >
> > > in summary and to be very clear
> > >
> > > 1- the upstream CID derivation is the u-boot/op-tee contract that
> > > matches mainline linux's ufshcd_create_device_id(). The contract is
> > > an
> > > OP-TEE-defined ABI, not a Global Platform spec.
> > >
> > > 2. Moreover CID-key is OP-TEE's own HUK-based derivation, not GP,
> > > not JEDEC.
> > >
> > > 3- Nothing here blocks anyone from overriding the static
> > > ufs_rpmb_build_cid()
> > > downstream.
> > >
> > > 3- if downstream scheme differs, that's the cost of having kept it
> > > out of tree,
> > > not a reason to hold this series for speculative plug-in
> > > infrastructure with a
> > > single backend.
> >
> > +1. Macpaul is there anything else you can review apart from the
> > downstream breakage. TBH since you didn;t bother upstreaming that,
> > objecting to code that adds real support doesn't really stand as an
> > arguement.
> >
> > Jorge, I did a quick pass and I don't see any big issues with the
> > series. I'll do another pass later this week and send a PR if the CI
> > agrees.
> >
> > Cheers
> > /Ilias
>
> Got it. That's quite reasonable for taking the current implementation.
> MediaTek will try to propose the vendor specific helper functions
> and and upstream other backends for some downstream
> implementation. Hope this could be happened soon. Thanks for taking
> time to read the previous reply.
>

YW and FWIW I'd really like to see that. What Jorge is proposing here
is easily extendable with extra algorithms with a Kconfig option or
weak per platform functions.

Thanks
/Ilias
> Best regards,
> Macpaul Lin
>
