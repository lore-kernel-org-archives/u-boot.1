Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE527606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eSxIyq9D;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvS9AGp0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83F0C8166E;
	Sat, 24 Oct 2026 10:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vcunfoak15wR; Sat, 24 Oct 2026 10:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2DD38169A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836797;
	b=pfce+DRjYpZoBubvQvKnDHtMMBG2W/DXYow+OMqZd+ANnJ4NPVYaXKhxexADXudoOTGP
	 cMtnaFwKEKUSHDwhTAsqtytkXsy39M4lCEvnIY4sO+FKCW1uR87bBLoL88TjE7upMM1Ul
	 WUNLdcuVvZorYbH/PzlqVfCBnfRLVV0e5gi3Vz1InI8HtPkTDWpAD03sECAqEPUAFOkfU
	 FrJUSfzRFOi1ITUc/HrkDWZI4zwWEAMJBUaAXz3N5NhpXnRrysfm+KR/iNVX/GoYtbN+d
	 84MeRYnWQBbp+7fLM8XkOU3xc4d2P7qo1VhojohGa2q+KUCRcDt+n58JTu4k/s1QutA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QaFwjDtZezl4+km3XA/1R5P9hbsRbZFinMAw1y3ngu8=;
	b=fCNBexIqo2Bbx1tRoM9iiQZAY9HzlGhWr8gszT6ju0KW32HJo3E0G8bcRvu9U40JgWw+
	 GaJgL8vfd8m8vJSbvMi3QjUdnVT8Hf3O+c9lOBj7Lz9pIh/Dq8ZGx4sRYwN3W5u+XhpsP
	 c6/9hoKhNIA7T/b8Qa2IO8r18OKJsIxiFhVfkHYv6aI3WRQZCH+vUUoX04L0xTVzfbj1g
	 CEsliER8VrQ3d9YdgwEbOBX7FEXN4XGMrd1U5bmBqk3+RDI1HGlHYByEsOgI7Uuh3lEgA
	 wJKVn5FdzCcupXrqA5SdJoue0FxKcYCsSnV72NmbuDTr7SQViYQHl7KhpUIi30nP4Vg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvS9AGp0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836797;
	bh=QaFwjDtZezl4+km3XA/1R5P9hbsRbZFinMAw1y3ngu8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eSxIyq9D3l/yOBDAhUGxavFKgj9aaoK2svXUlrXAREggpKxqNHpxtKVdhcsxvYVX/
	 dSGGZTQnHwSGhsdMCz1qfkyiqFGXWRJ+MLEmEuOkRvQcgG5fnXg14b8OOuAJhy1peV
	 n7jWyUQY5tkF03B/BjHfpK+vSyXZX40w+0apst6ahhWL3vJ+Ym7I6dJZo+p8w3xum2
	 koiLf/1QSTRorOlHLSTqzWEBbLPxTnGlG8iSFuSsBo0TAIixa5A3UW9Si3m8uoO2Kw
	 9lR1JSkmzAOxNEk0dng3A2U5ZX7QTlJPoz1WyMShEJOJHNcvfo8n2VaUZqi6+20+SG
	 r6Z1QnLcUhWGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2DD38169A;
	Sat, 24 Oct 2026 10:13:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DCB97380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE7CE8166E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 95O_dX96haYR for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08CA08169A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::2f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836796;
 b=VgWeqB7DR02LYuUlT1kR5s5bFKnhd/W+EceQuSa423kLyc2RyIrKgxFl+N4QtrTY5+Cp
 zuyMUyFLiAfs824gTJyCgKAPwR322FWQHoPgzeVhn7OHLM6EL5romeqinUeDDpu1bs2X4
 VhYweAtCg4wuw2T6CGrLWwP73LM4gNc1PMwoxaqFUQbEOLulwYExEaCmincyEX5JjI8/p
 BJKSVm7wuF1vEhUO5DWSpQmF1F523wILDRyI1Z7sham1LOlcEU9pHPhChYfcAmKqvwJjc
 3yqbAAKT01VEhhMdrrXdaS9vG3+wwSQpewpXabS9Al+9nWZJAbSCjE8gxQ9xFCSnWnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836796;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=QaFwjDtZezl4+km3XA/1R5P9hbsRbZFinMAw1y3ngu8=;
 b=q3df3xJAaXrQcW2RPZL7Z0YQtbIho9ST2fXbMp8a+GhQiHfiPZyct2RHSwTxfwtesviS
 NW1Hjt+A8Iw7tF/XEjce5avJ/fcXCVNcyckrt9uzKFixA72YU/JaidCCzO20a2YzYnOOG
 +GsV7S6raKmJts5MxPgQ80gJcWeeyeJAHnJ8o04VY5b4xpNYq55yFqlhiDv1CKXWQ3xu5
 380YPncaL/OBHHNIN6YOZ9kDSPdFPslEk3EdmwV/Gydjsj80JQyF+T7sW8q3mX24q5JRq
 GAtc3inSuFgHv18Xgmz8M4W7unssDilFpXIQdOFXMhZyTC7ogBMpdaUr1HAmtwgWgCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LvS9AGp0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LvS9AGp0
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08CA08169A
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:15 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4a75171af39so553412fac.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836794; cv=none;
 d=google.com; s=arc-20260327;
 b=sJprEgePhEdTN01laG9poNJ4zr5evkjqawk5YuN1ZItYSPrEiHPvfiIcibCU/uPsPF
 2Dnl4841AUAD1zCz1Jx+0VKxEdrt2/fHiDrJ5cJUqnFuZo+OU88QyYeOnrhbZ0CZ8EpM
 JidnM22Y0I1yNuXx2+8BUI4sk2z0+ea5CYXVp1hpow1jtzyS1ib3yGe9BAdo543ergc1
 R6fGO+nkAi+lRlse/aXAtczrJ6lfvOQSO8O8Mv1p8rouoenWjgbse2fIzOBijU7sN7sp
 OZuIrpmsSDlLY1eGSKziT3V5Py7AZrpotztDxVuMrjld0VSQnbuBlxwPTnq6c54wGZH/
 GE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=QaFwjDtZezl4+km3XA/1R5P9hbsRbZFinMAw1y3ngu8=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=mot7/znJso6Uw5JaB/0bf5w06ZQNXUcVXlQSxjkRxTgVhyNVf1TajIkB5JRXcI9a3p
 5xsiktcxpI1qESCSAlXxKP9KqTKw/jVMHV8CQObbt5igkEoTeoNmzr/u4gH+uikS7XJE
 JoylYhKGM2SGsK+I3gOz6cwggWHjHdrh7CbXMkqOgWOIBb3Qm3KEoI0bL0rKrmUBQbmu
 Pcz8dQeY+pNhfdoout3fz0zjL5Q2v87gg4AhTKq9zA5wMK75h/9i5c3tt+jTlMZtDkqm
 pniNyI6ujSJP5humzds0xiJRaZBELcaNyV+eMLgCRjHwe9GmK9GQkb2xsm0xFn4YBB85
 8VGg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836794; x=1793441594;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QaFwjDtZezl4+km3XA/1R5P9hbsRbZFinMAw1y3ngu8=;
 b=LvS9AGp0F1wVf2IsTGj0xHA1+kLbfcUP0FGraaNQd+YQRbGQTyFdGsjT7YhIXSyFjT
 L8WHXEzRyQNjC8BSY8zLLEwsvuDbJSES/bXVttAKTyS5KlY7WOfA/FqjEoU4pVWWGt9v
 NMdmGTM0ghthajn4FPmYtZxQfJ6FPeirmdqSj7GwenlPC1arztEhD5ut8iSpF9kTsREh
 ezLk1M8zCHGFeJ3RsjV+PeviR9ZznPg44M6tPGEDKAYIwUuWZbpZQIEL7v0Tmh+Emg7r
 vxC/9bhnM3/VajCq84flbL4XGQdUFR/k/l/h1jRDaXKAgay8k3j42LqfIpl0PYvjXocI
 oS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836794; x=1793441594;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QaFwjDtZezl4+km3XA/1R5P9hbsRbZFinMAw1y3ngu8=;
 b=mjiAEFTwpjT+dG/MUys3xgO7namqhSfojHTgZy7YQgprGwX6Vnswafdeoxp4bfH39G
 Jq38QJM0xsVx3n7Z9DfHr4rmPbKLgGM1HM0ETcyc7pvitFAPCOIk7DaaGpobeBFNIjBS
 MeXC9Eo8uAxcBASwIlnznYZP3heFG+Qh6mpjUXjXatYED3MhZrjuL+uDDZ+iUSyU09zz
 Y7B0Zk34L6oOFOA0Xylr+n3VG11SYX0LyX7OfSQ84AnQyt6MhWpqTTsJrGam+eY4RWQ7
 FHKN5X9j4rBJ9zWWl1w9393qANnm5PyP8eHavVWKc9oU8KaaiZPG+t/wKUjMp+4oUkK6
 Y5hw==
X-Gm-Message-State: AFq9FYLJhqWn+eOkjC8ZahPHljjWrJODlTPAYcLQhUlvX2L7a2tzLq9V
 q9Doc2pTUuJRMfiShmIus25N+frOj+Q0y9lz9S4DuDbWz+kgY0osfLTgdep/g1Rl2k/ORq/5hXb
 c/33y1gkO4CK6MTP5EMi/Ut3WdjqRx+yByVqr
X-Gm-Gg: AYBFou1614784Lj9HrrZ+9AV1oxYausGGu0nWeKRBHzNbZimvIbcto3DJI+wJLJQPho
 3iKnIv1flHT88LiZFS3FKumB3isG+PK4WlxA/bzt9oTsJt2L20pLsKGCeer8mZhpwJudqJU+VM2
 J/WUwXnmV+Xk70IZD0M+OwV7iexJJ1Q4K9Cf49tAdB3pelRATy8fkDCwP/gcYYgiSJoWNhCBdGZ
 JydD0W3ystPkcWULv+3ugMY24GZA5TaUAmCRD7Z8Dwj6q/E49DnkarYCyhLxOb+NORVWUoYzzRI
 K0YAOVUeyrtHDI8MiOZpwOnpGn4G4HlTe+Z4PuDVrNW+UWoGH8O+u44LV6PC3hi0rNncFxwx5Nv
 qh4tSomkbD0mQsVi37IuoOSHazGCWfAofyYGXaA==
X-Received: by 2002:a05:6808:220a:b0:551:eea6:9397 with SMTP id
 5614622812f47-55c00342df9mr879252b6e.59.1792836794607; Sat, 24 Oct 2026
 03:13:14 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:13:13 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:13:13 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:13:13 -0700
X-Gm-Features: AclHuK8E_KxcNB4sMujayOjVpuL3XxcDj7BjbfHv-JP_-AB6W8Zi1GDZFWtfSMM
Message-ID: <CAJnxHsjU1WTazXtc3F=S4=ct9gmCiR1Qx_h=M=Ybp_hx0pXQyw@mail.gmail.com>
Subject: [PATCH 8/9] disk: part_dos: Make room for a three-digit partition
 number in the UUID
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000048920d065e93580e"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000048920d065e93580e
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000048920d065e93580e
Content-Type: text/plain; charset="utf-8"; name="0008.patch"
Content-Disposition: attachment; filename="0008.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 714c96901daa3e64_0.1

cGFydF9nZXRfaW5mb19leHRlbmRlZCgpIG1ha2VzIHVwIHRoZSBVVUlEIG9mIGEgRE9TIHBhcnRp
dGlvbiBhcwoiJTA4eC0lMDJ4IiBmcm9tIHRoZSBkaXNrIHNpZ25hdHVyZSBhbmQgdGhlIHBhcnRp
dGlvbiBudW1iZXIsIGludG8gYQpidWZmZXIgb2YgMTIgYnl0ZXMuIFRoYXQgaXMgZW5vdWdoIHVw
IHRvIHBhcnRpdGlvbiAyNTUsIGJ1dApNQVhfRVhUX1BBUlRTIGxldHMgdGhlIG51bWJlciByZWFj
aCAyNTYsIHdob3NlIHRocmVlIGRpZ2l0cyBtYWtlCnNwcmludGYoKSB3cml0ZSB0aGUgdGVybWlu
YXRpbmcgTlVMIHBhc3QgdGhlIGVuZCBvZiB0aGUgYnVmZmVyLgoKU2l6ZSB0aGUgYnVmZmVyIGxp
a2UgdGhlIFVVSUQgaXQgaXMgY29waWVkIGludG8sIGFuZCB1c2Ugc25wcmludGYoKS4KCkFkZCBh
IHRlc3Qgd2l0aCAyNTYgcGFydGl0aW9ucywgd2hpY2ggY2F0Y2hlcyB0aGUgb3ZlcmZsb3cgb24g
c2FuZGJveAp3aXRoIENPTkZJR19BU0FOLgoKU2lnbmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFu
YWJvYmlsbG8zQGdtYWlsLmNvbT4KLS0tCiBkaXNrL3BhcnRfZG9zLmMgfCAgNiArKysrLS0KIHRl
c3QvZG0vcGFydC5jICB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kaXNrL3BhcnRfZG9zLmMgYi9kaXNrL3BhcnRfZG9zLmMKaW5kZXgg
ZjQ1MWFlZjc2YTguLjA0YTY4Y2E2NDc4IDEwMDY0NAotLS0gYS9kaXNrL3BhcnRfZG9zLmMKKysr
IGIvZGlzay9wYXJ0X2Rvcy5jCkBAIC0yOTQsOSArMjk0LDExIEBAIG5leHRfdGFibGU6CiAJCQkJ
c25wcmludGYoaW5mby0+dHlwZSwgc2l6ZW9mKGluZm8tPnR5cGUpLCAiMHgleCIsIHB0LT5zeXNf
aW5kKTsKIAkJCQlpbmZvLT5ib290YWJsZSA9IGdldF9ib290YWJsZShwdCk7CiAJCQkJaWYgKENP
TkZJR19JU19FTkFCTEVEKFBBUlRJVElPTl9VVUlEUykpIHsKLQkJCQkJY2hhciBzdHJbMTJdOwor
CQkJCQkvKiBwYXJ0X251bSBtYXkgdGFrZSB0aHJlZSBkaWdpdHMgKi8KKwkJCQkJY2hhciBzdHJb
VVVJRF9TVFJfTEVOICsgMV07CiAKLQkJCQkJc3ByaW50ZihzdHIsICIlMDh4LSUwMngiLCBkaXNr
c2lnLCBwYXJ0X251bSk7CisJCQkJCXNucHJpbnRmKHN0ciwgc2l6ZW9mKHN0ciksICIlMDh4LSUw
MngiLAorCQkJCQkJIGRpc2tzaWcsIHBhcnRfbnVtKTsKIAkJCQkJZGlza19wYXJ0aXRpb25fc2V0
X3V1aWQoaW5mbywgc3RyKTsKIAkJCQl9CiAJCQkJaW5mby0+c3lzX2luZCA9IHB0LT5zeXNfaW5k
OwpkaWZmIC0tZ2l0IGEvdGVzdC9kbS9wYXJ0LmMgYi90ZXN0L2RtL3BhcnQuYwppbmRleCA0ZTMx
M2U1MDc1Mi4uZDQ0ZTk5NDFiYTcgMTAwNjQ0Ci0tLSBhL3Rlc3QvZG0vcGFydC5jCisrKyBiL3Rl
c3QvZG0vcGFydC5jCkBAIC0zNDgsMyArMzQ4LDQ5IEBAIHN0YXRpYyBpbnQgZG1fdGVzdF9wYXJ0
X2Rvc19leHRfbG9vcChzdHJ1Y3QgdW5pdF90ZXN0X3N0YXRlICp1dHMpCiAJcmV0dXJuIDA7CiB9
CiBETV9URVNUKGRtX3Rlc3RfcGFydF9kb3NfZXh0X2xvb3AsIFVURl9TQ0FOX1BEQVRBIHwgVVRG
X1NDQU5fRkRUIHwgVVRGX0NPTlNPTEUpOworCisvKgorICogUGFydGl0aW9uIG51bWJlcnMgYWJv
dmUgMjU1IHRha2UgdGhyZWUgZGlnaXRzIGluIHRoZSBVVUlEIG1hZGUgdXAgZm9yIGEKKyAqIERP
UyBwYXJ0aXRpb24sIGZyb20gdGhlIGRpc2sgc2lnbmF0dXJlIGFuZCB0aGUgcGFydGl0aW9uIG51
bWJlcgorICovCitzdGF0aWMgaW50IGRtX3Rlc3RfcGFydF9kb3NfdXVpZChzdHJ1Y3QgdW5pdF90
ZXN0X3N0YXRlICp1dHMpCit7CisJc3RydWN0IGRpc2tfcGFydGl0aW9uIGluZm87CisJZG9zX3Bh
cnRpdGlvbl90IHB0WzRdOworCXN0cnVjdCBibGtfZGVzYyAqZGVzYzsKKwlpbnQgcGFydDsKKwor
CWlmICghQ09ORklHX0lTX0VOQUJMRUQoUEFSVElUSU9OX1VVSURTKSkKKwkJcmV0dXJuIC1FQUdB
SU47CisKKwl1dF9hc3NlcnRlcSgyLCBibGtfZ2V0X2RldmljZV9ieV9zdHIoIm1tYyIsICIyIiwg
JmRlc2MpKTsKKwl1dF9hc3NlcnRlcSg1MTIsIGRlc2MtPmJsa3N6KTsKKworCS8qIGFuIGV4dGVu
ZGVkIHBhcnRpdGlvbiBmcm9tIHNlY3RvciAyICovCisJbWVtc2V0KHB0LCAnXDAnLCBzaXplb2Yo
cHQpKTsKKwlkb3Nfc2V0X2VudHJ5KCZwdFswXSwgRE9TX1BBUlRfVFlQRV9FWFRFTkRFRCwgMiwg
NTEyKTsKKwl1dF9hc3NlcnRvayhkb3Nfd3JpdGVfdGFibGUoZGVzYywgMCwgcHQpKTsKKworCS8q
CisJICogaG9sZGluZyBsb2dpY2FsIHBhcnRpdGlvbnMgNSB0byAyNTYsIGVhY2ggb2Ygb25lIHNl
Y3RvciBhZnRlciBpdHMKKwkgKiB0YWJsZSwgd2l0aCB0aGUgdGFibGVzIHR3byBzZWN0b3JzIGFw
YXJ0IGZyb20gc2VjdG9yIDIgb24KKwkgKi8KKwlmb3IgKHBhcnQgPSA1OyBwYXJ0IDw9IDI1Njsg
cGFydCsrKSB7CisJCW1lbXNldChwdCwgJ1wwJywgc2l6ZW9mKHB0KSk7CisJCWRvc19zZXRfZW50
cnkoJnB0WzBdLCAweDgzLCAxLCAxKTsKKwkJaWYgKHBhcnQgPCAyNTYpCisJCQlkb3Nfc2V0X2Vu
dHJ5KCZwdFsxXSwgRE9TX1BBUlRfVFlQRV9FWFRFTkRFRCwKKwkJCQkgICAgICAocGFydCAtIDQp
ICogMiwgMik7CisJCXV0X2Fzc2VydG9rKGRvc193cml0ZV90YWJsZShkZXNjLCAyICsgKHBhcnQg
LSA1KSAqIDIsIHB0KSk7CisJfQorCisJdXRfYXNzZXJ0b2socGFydF9nZXRfaW5mb19ieV90eXBl
KGRlc2MsIDI1NSwgUEFSVF9UWVBFX0RPUywgJmluZm8pKTsKKwl1dF9hc3NlcnRlcSgyICsgMjUw
ICogMiArIDEsIGluZm8uc3RhcnQpOworCXV0X2Fzc2VydGVxX3N0cigiMDAwMDAwMDAtZmYiLCBk
aXNrX3BhcnRpdGlvbl91dWlkKCZpbmZvKSk7CisJdXRfYXNzZXJ0b2socGFydF9nZXRfaW5mb19i
eV90eXBlKGRlc2MsIDI1NiwgUEFSVF9UWVBFX0RPUywgJmluZm8pKTsKKwl1dF9hc3NlcnRlcSgy
ICsgMjUxICogMiArIDEsIGluZm8uc3RhcnQpOworCXV0X2Fzc2VydGVxX3N0cigiMDAwMDAwMDAt
MTAwIiwgZGlza19wYXJ0aXRpb25fdXVpZCgmaW5mbykpOworCisJcmV0dXJuIDA7Cit9CitETV9U
RVNUKGRtX3Rlc3RfcGFydF9kb3NfdXVpZCwgVVRGX1NDQU5fUERBVEEgfCBVVEZfU0NBTl9GRFQp
Owo=
--00000000000048920d065e93580e--
