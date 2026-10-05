Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BCBCA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 15:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DC7C6072B;
	Mon,  5 Oct 2026 15:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_GuN4sNMCQc; Mon,  5 Oct 2026 15:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 07D9960711
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791214500;
	b=D+do3q+nf3lFhVxDpIS2V5m7TPQTRgFB27eLrxqFG3NdEKqNNYhnq2KxRx+UnA/u74+m
	 dKLhj7Rba/B8v7r+6VOs8yBVvIHNJ4JQChtTQqrzSC89Q+55VO88XxJjX7XHVh3x/doK9
	 62NUWSKRcbmbrz168NRdgnj1IKOMNO4NTqyJu3RbNkc2iVFXS1Jep2el8fi79VHGT4zne
	 E0HBFXtit62dHQEsroRbQXXM4bOru87qBpebMBCllzNdqkVquM8f52KianLy1ACFxcEdT
	 1iXlaFshNaiEJs7Y3tGgtTdZFhRMnNm2f+qcASOYHXXs3VqeZy+h9CJ67K9g6QrfgWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791214500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EKxnc1KnT2XZc1EwnZIBGHUarLRzqM494/M9d6L8rwM=;
	b=pXhBBEltQ0LCzeNr5dqvORn3Pp7v5DZ6rma8lozXOKwbxgYHkkVwEZcQdgNqtJHlKgbP
	 MDMfXiSovzYKmiDTDFld4nNZcPG8r5kTXFIjSEmOxmNiVYKMmQUCxiA3XM0IF+zGEwmel
	 59D2ZSHGdP+y7z/DKy6G9V7vKa/aLeNrJJXFHZUVbZNTWudTNhvC82wxMwDP+9FvlUYnZ
	 r5ZT//hSQj5OTUHLuEqCOOcQkTgfglSsvcReSSvKTUUKgx1gw2Dva8+6TcD4VwMt5xAbY
	 FrwtF+YvRcOP71soT3q9DblRJZusdN/qAnlIKIqtwY7q3rsIv9/RwXn4DAhIkGwHaqg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791214500;
	bh=EKxnc1KnT2XZc1EwnZIBGHUarLRzqM494/M9d6L8rwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gV0lr4pV6bLuWOAJbMLmhdpIBf1JU4dEN8WS4YX7da2qpxc1IETH4G+BYZ4DVh3f/
	 QAcCwJNIzK81bvhXJRWs7OfOpPQ2EgNYbqV01gi69+SpU4CKOw71522/sNbFu6bUxx
	 svJHMXsqT1JbaVZmShjCulomAO8MsWz2uieRNjSBdXOYfjgiqCchkk2SG1HDRyrw5y
	 TrNS6NeJn6EtE8YwH26+kqS1J/eWm6VY3IKzqT8fhoANCP0LoW3apEODTVmDien1jT
	 sMQxlm9WOBbgtpS4h01UrQQHBWV00r+jOHM33BjM21/WN43IvfTBzXX3EiKDegorMT
	 UuihRxCk0mTtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07D9960711;
	Mon,  5 Oct 2026 15:35:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B4E4338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 15:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7106F401ED
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 15:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-MgmxDJKP7C for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 15:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D36C8401DE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791214470;
 b=LtA/ESlD8wOK5zaFqMCInI/N/Y8+IACgpn9SgYqHT8XwlVNfogHsjq+TKTUyuuCm95iA
 eb7xYDNgWaQbU80LV29jvJ2RwFmUb9JdzxMLzGnoJFSiXpg5nN4FaFHclTEsqep+cJnxe
 YcdB7NMgk+ktDoueebL7aRoCrUWqgsmNIe1IEaa0B8WFisDZcikTD06X4+GjP6M2Iuf2j
 kcu38NO/7cIGmX0jPNFC475AsH/8ik5ZxcOFmZFF2+bgaiYbl9957W2JPq9naiP3Ff9/5
 dCdQ5uEHFydtYyW67k0o8yCeWdN1j2PYr280UoGINtyAckCdpK/XOnbuo4EvUKG+J3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791214470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=EKxnc1KnT2XZc1EwnZIBGHUarLRzqM494/M9d6L8rwM=;
 b=j688qIdJY8uAhxbOpty+KsngLywYIKLwhxtK89LmXmfZ+QkpZoAXKVoxRezTAlucVcK8
 /sdNl2/uvrU32b4nyUfha8Mi0ilDj8PsAKSeoH+a3uoaVZ2KfavQggU4UHvCzj+vy2cG2
 1ek1oDIFKbemTrKBkfjGCXdBPlezC07yn3SSLO9jdYCHk5Z98mZWmZXAqiuYGSlJAM2Dp
 fduaA3uViSarixNujuf4kpl7TipNXwnP2yEowTyxH48NQptB9bJKN8jr5jbXZr2MMfbMY
 Pbg2THm0TrA++Xgr91q8PEBrJ8Z3YSHnNoQ2CdcFndH4EZQJbW7urLd0Np23qjo6aGQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=UhSDyXnM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=UhSDyXnM
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D36C8401DE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 15:34:29 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3a98f260f85so5534601fa.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 08:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791214467; cv=none;
 d=google.com; s=arc-20260327;
 b=NSpV8ifXcwGk+FqKmqnsuRhE8bQlm9+0KNeVOrfEQyXfdFqpdLVEgYuCPgcmHDI1NQ
 Gy5OpnOvR2tjQr5VAoSQeBDxSM3UsT4z34O/2QJPfO9on16/2ZwapG8TMOB6D9n0/QaM
 Ai3V7ucEKNCb3/FO3CqCuXShbvbEbbpU08RDbmtejuXXFDpKjYf0gfC/TmqMpsagLn/h
 J+ZWc7Ts8I1q0nVpjX4mq5MnG7LQEcOm9C9eu9zNvhXQwxSt0mNAHwA3xi3+3eg18MMe
 5+ogrYwkVoJFFm81dWIpULaRD7zGQj/xZ4hXch45W/9kcPHH4pLbcgKPYzB5tUOpt/u0
 X13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EKxnc1KnT2XZc1EwnZIBGHUarLRzqM494/M9d6L8rwM=;
 fh=ZaRyYmJQl3T0duIqN7KOjtGBwWanBeYnngva+h0bLQw=;
 b=YPwj1w103baFn+MZ7kpgMCj5PSf36uTW84CiLXnUsRx264JbeVE1Ll4igWY3YLgd73
 l0YPYTqfzmr8188gp8LkkK85uKhUmmoaQVmd7rZA9kax9YGhnDltDFzckHEvkGUFZvct
 BrtjOmH1n1afGBBcdKj8Q9uEGQXSopO57/2JMrJihCgln99tfwdzeajy6APMZyhOGf13
 s7x4MOd1f9tuegTgdDes8zZ1UxqFjiIK0qmR03EyEsxFwiLrSKlq3NwdEBd+ZAZ6umnl
 tSG+B37rb5ZLNOwOObPqrRJ0p/QD4l28dCKJNiea5hDTJJv287FvZ26xgwAzF/OZ6CZN
 Wz8g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791214467; x=1791819267;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EKxnc1KnT2XZc1EwnZIBGHUarLRzqM494/M9d6L8rwM=;
 b=UhSDyXnMZHs3E/8efhPkGtUIPksWt3KvMXOWuhfUZ6CRtVeCL1/esuFtin0iNlS54q
 o84YjhItYHqk1YPMIIkWRpkT3CzbNECVCzQZIrrRQkWXFchRDdRO5caZMV5ljjzFgfWB
 fzr4BkQ1cQ4yIlw3d3/08G+sF6x7inuxtqrf1r734goh+Sw5KMXQ1vHPWNYa6dPNFxnL
 qWeoV/ZlLSOPFSoaqBrHSasandYPhnKavquCyXPFB3koDSydPQE4d+SB62u2o4OeAYPn
 bzd85Xj2jgItkO9+3wHOCFqQPrwRs5ytGXhYUAoyeBZClGwYlCl6mtGjV/LO/Sx8vxyA
 74Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791214467; x=1791819267;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EKxnc1KnT2XZc1EwnZIBGHUarLRzqM494/M9d6L8rwM=;
 b=B0x6ILPq4dCX6tIKJvDz3FSPud//9acPEUsQvICDdFuMNf0VmsiFXCyWdF2CFjrol+
 eJF4NyRRo6KNv6ch4z6gFrn0abQ6Cv8uqpjV2Ey8glr9p+2zKeq3T3+fzJMF40+mCST9
 sEWFr7k4F3BzYt0uYGL/0l6xqSZUZLc+KzlXudT0eyDq5arZKyLlsTVAxGArsYY19zhY
 wnxlmTGsdUuCvwRXKsKHUHWH6/wkrSbRXKq13UksvrzyEA+44j4YggVL8JK+tyCJQTI7
 jxpw5KHdEaMQAL9eO9O8+Rfdm/Z1qDdoNFPKgBnfkajt6gAtk/6y5iyoi6/vqIyuZsXk
 GjJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2mxjnWbb1gs+RgLqOMuU2dVvmlUU1gMtIPowVa+2fB6lF+9WrLk6M3ktYekylvIuhAq8kIsg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJN9SPQc7Ock3CABMwdUxeE+oZZKABNF3olq4L+Fi/zgaM7Lbrv
 z7fQv0UNmwKWCjJEq6/CZ/VdtA9mH/AufATz346ssQK42w6LT0SkmEqvBfLeEUeCXasMEjyBIyp
 210reTqX/NK3DIQHncC/tipZ9Xoyp5KMBgxuk/E5LpQ==
X-Gm-Gg: AYBFou0H7fDt5mcruYtxoiCLMNpIBnYj9kNIBz/VLtZeV+o2W5dLXE5WgDABTF0s3iL
 X74MaYUiFkZKMN5TGDmCiKdPOOvS45b5B6/GHn7tANiu9X/sRYHLUrShmXSC1Sg9QXLAwzAkxiF
 vAdBsjXZMjLnqxUiMrPvwQJCH1p9IvoO9ocg/kdc/eCZCXEGdPzA1ycrXlY5AicNUp12hheO+Ql
 KJaS7iL8D5MUuFq3ldGDHTtabFXhM1DDxEz9WMXat3RY2k0fuY5BTssYEXWo8oIUV2zIOT8uEQf
 lf6slBoJxvWzJLt3fBLsgymLEDKAeIcUdcAuexeBorS/EovIi2eeXNSYOEgg0fvfJePfAYA7DqJ
 1ogDbJa5Ns6RBNXiaBYI90aLX3wuHGE3CkyFI0mdtTleWM7RrFy4rj6zfAT28YZxnihz9tpL6O6
 +z/qHP1Nbi+T8p
X-Received: by 2002:a2e:be1d:0:b0:3a3:314d:1169 with SMTP id
 38308e7fff4ca-3a974e89932mr19233241fa.1.1791214466867; Mon, 05 Oct 2026
 08:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
 <20260912-m4-v13-7-71043b29630f@riscstar.com>
 <d1a8bab8-4d88-48f2-9ddb-89e8c0e323b8@gmail.com>
 <CAH22mJw3MfVyEva=CGgaEp4y_V2cCv-=n3vz9oKpHtkjsScAPQ@mail.gmail.com>
 <2575486d-429d-4044-9b78-bf9b13bb0aa9@gmail.com>
In-Reply-To: <2575486d-429d-4044-9b78-bf9b13bb0aa9@gmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 5 Oct 2026 23:34:14 +0800
X-Gm-Features: AclHuK_bVvPEjjHRMoWduwBKh5UVua5kxZ57Sifz_wmRce45WHxnSGUXDjBB42w
Message-ID: <CAH22mJy=Ea-QG3uEY2pTJCPSrxyymOmcLdRCXm6zmbe7HYSVtA@mail.gmail.com>
Subject: Re: [PATCH v13 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
To: Andre Heider <a.heider@gmail.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 5, 2026 at 3:23=E2=80=AFPM Andre Heider <a.heider@gmail.com> wr=
ote:
>
> On 05.10.26 6:01 AM, Eric Chung wrote:
> > On Fri, Oct 2, 2026 at 8:58=E2=80=AFPM Andre Heider <a.heider@gmail.com=
> wrote:
> >>
> >> Hi,
> >>
> >> just a general question related to this patch, not about the patch its=
elf, see below:
> >>
> >> On 12.09.26 2:37 PM, Eric Chung wrote:
> >>> +static const struct {
> >>> +     const char *eeprom_name;
> >>> +     const char *fit_name;
> >>> +} k1_board_map[] =3D {
> >>> +     { "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
> >>> +     { "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
> >>> +     { "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
> >>> +};
> >> This maps the EEPROMs product_name to the dtb, just like the vendor fo=
rk, nice.
> >>
> >> But does the BPI F3 really have "k1-x_deb1" in there?
> >> I know that's the fallback dtb of the vendor's fork [0][1], in case th=
ere's nothing there, and I thought that was the case for the F3?
> >>
> >
> > k1-x_deb1 means the internal development board. And it could work
> > smoothly on the Banana Pi F3.
>
> Yes, but maybe someone with a F3 board can verify via `tlv_eeprom` if tha=
t string is actually in there?
>
> >
> >
> >> Because it seems it's not set for BPI-CM6 IO board either [2], which t=
hen makes it impossible to distinguish, at least based on the EEPROM value =
:\
> >>
> >
> > What's BPI-CM6 IO board? Is the BPI-CM6 IO board similar to the Banana
> > Pi F3? Is it supported by linux kernel now?
>
> This one:
> https://docs.banana-pi.org/en/BPI-CM6/BananaPi_BPI-CM6
>
> Supported by mainline via:
> arch/riscv/boot/dts/spacemit/k1-bananapi-cm6-io.dts
>
> Apparently sinovoip *edited* k1-x_deb1.dts for CM6 and even ship that hac=
k in their OS images (visible in the logs on that OpenWrt PR):
> https://github.com/BPI-SINOVOIP/pi-linux/commit/333b99e8cd9b18e98bf718215=
18548df345dbb61
> /o\
>
> >
> >> Are there any ideas how to handle that, yet?
> >>
> >> Can we distinguish between those boards in the SPL based on something =
different?
> >>
> >> Or can we make up our own strings and let users write that to EEPROM? =
Mainline and vendor technically allows it via e.g.:
> >>     tlv_eeprom set 0x21 "k1-x_BPI-CM6-IO"
> >>     tlv_eeprom write
> >> But that's assuming the EEPROM is writable, which I haven't checked.
> >> (And I neither have a F3 nor a CM6).
> >>
> >
> > tlv_eeprom should support to write EEPROM. If it fails, we could
> > enable ENV in SPL. I have a patch in the mailing list to enable ENV.
> > But that patch was abandoned. You could review the mailing list to
> > reuse it.
>
> In the meantime a board owner verified the EEPROM write as working:
> https://github.com/openwrt/openwrt/pull/23231#issuecomment-5972395785
>
> For the record, I made up "k1-x_BPI-CM6-IO" as product name with a matchi=
ng vendor fork device-tree file name, which makes u-boot as well as the ker=
nel pick up their matching device-trees via CONFIG_FIT_BEST_MATCH.
>
> In case mainline u-boot goes the same way (let CM6 owners add a value to =
EEPROM) to properly make multi-dtb fit images boot, can we agree on a value=
? Or maybe someone here has connections to sinovoip and ask them to put tha=
t/anything in there?
>

Yes, adding "k1-x_BPI-CM6-IO" to the EEPROM sounds good to me. Feel
free to format a patch and send it to the mailing list.
