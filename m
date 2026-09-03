Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913A6C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EB9F60B73;
	Thu,  3 Sep 2026 14:38:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgxSLaLnaSx3; Thu,  3 Sep 2026 14:38:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D63F860B43
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446319;
	b=LR/cfQ8Qk5uHqwk4YdZYOZnuvdIwTz3XRsdY5q+YoGnLreA3nUJpjyRs3ZdzpRKxE0UY
	 5YU+8Sl7KeeJY22OrkqZQ3JmHmAE2C7j8z0p7Cqw6yEenElz6VV07SBXGMFP8ILblY2gp
	 EJUyP9b6p/SSVUO5NbOB4tdpJocevjM5Gqj7EJ/N4pD9qTBP0BX0gUFfwQ6xDJgjvrfWY
	 MXQbMhZ0WPhSvnRPTGua1KHwJ4UqBjUsG6LQcS3pDlkdQSHgJrvL/t1MS/pwiwWVOc37P
	 3HHAM4GcVR65V8F28rCaLa96WK9HIApfloRaSnB4fykAPt9xLs83Zo8GucTV5y7ZR+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/Tm7m0tDkSVc/SzgB5loNPweDdBi8/hIRRUVblRzu2k=;
	b=qXuBjh193b051MDDjvmQZyZIEyX+e7eMCsYT+h397UHlZpc9+I4E9dYcP9+JadKQ0pUG
	 SnjiOmZoMGonEC3FEvVRdyxq9yhBWeSM+UtJ8DBI2pDy946s3mo7jiyCSeyaEj9Fn0Fr8
	 dbCLnMiw3KFUidE9hyqmrnvuDFAbjVNcQIInHzxksnIntisPBJesqAoYRUhKOxK7FWt11
	 BDoTaBoEiMkdvPjtwDR74/W5ujAbk9CJGOD/d2Z5iOKFPzGS++AQkYFnvdvW9Ejlc1CSb
	 FJahHJ196MqXTdz9eY4RuVobmdrQLsJW5wdcoxnI98Xw1GgeG94sEuOaKZtYUL8RlZw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446319;
	bh=/Tm7m0tDkSVc/SzgB5loNPweDdBi8/hIRRUVblRzu2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyMkruhDN+qjyTwveZs+fkAqtZryQX0rYfpB/9adm5WWK3NqJB2P6CtfEc6TQbuoq
	 s6e9xICHW++jKUV0I3T8EDM1fq4P4Ck9YQCOc1AnqB6aqBPLbjiUqTpVAFmVlV7LJF
	 TBYFTBgFqVyNPq0ay6FrYJ8+mzgx6DkdiIrI5eIr+ujhBmaSGRjkwpPA4YrBb/fO8h
	 /BBPsVwKO6z7hw8gn+avZd82FZ6JGK4bi1Cr4+k800akC2DIe6LesJZWgBl4gJskP8
	 DwURmcbOKeKI5KqX1Vw3YpEQdDbOFq7TpjdxhhMLQflBlsPrkbaDHwWP+bZj2H0/d2
	 mf+u38LyTpH7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D63F860B43;
	Thu,  3 Sep 2026 14:38:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E8A2279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54BF180CCE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:38:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KL-b-MUWSI8C for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:38:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 71C3280EF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::92f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446310;
 b=TpMIiWT5WuEqgu1CyD5N+jMaSVmyWufTN8HXLQANaaUEzlQlHy43JDgQySg+Wf0uzcLQ
 mumjILAA05U0iJwyyAck0/Ufp1/ksQ/MuCEgfqRfuQMjWJHGqif+arxZn8yNclNfVMwxF
 Nd6FmnIfh8ZaCbFpW1Rig0Jl5xUyCsTM1JxYKV7BKS99gvZU0l010lvWx2hVeeFmHwFlG
 fanhYEy4uCTIvNMrTZYzcdO+wT2pMbllvDopVVuo2LC/V1SHbvthhJ2jvtWI6F57kJTfB
 8pStSzomJZveti5opyJ7gH2Dqh8vxDU7l+ySzLY9s2hhFZC2+9Yuu8TzBz1bYdHS4CQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446310;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=/Tm7m0tDkSVc/SzgB5loNPweDdBi8/hIRRUVblRzu2k=;
 b=eKFf2SOhxIw16H9QxHh/HXM1sawoHQBwT3p3UHvqqwHYKvmCfBNtFa1+zZmHg7EI9g75
 ypvGvW4o911ZWPMNQ7Nobrc3OjrqFPBhl4fqjkBirhv3Enn3vjkqupocSkVKB8BHcnVYy
 AYK/lcT9MQHhOegeYTn5ytThAtH7MrFyS4CTnKC9tjLLSj/WKRBV27lkbzDm/qsluOD6n
 tpGrf11eT1k/Y1E44DzbWoFl7ca3kJNcy1Yl971PRYKlZ143wMEa+27MZgZjocpx8BkSE
 Tip2lhDx8g4SEjKrra2tctyaPXC2T5QMDP5i942RUSd4SGc/nSYOk1wkwS+aSi6Pjog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F9HLdJr9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::92f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=F9HLdJr9
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71C3280EF0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:38:29 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-97ca72f2cd9so1212341241.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446309; cv=none;
 d=google.com; s=arc-20260327;
 b=Iom9Lhwvfz8RoaAF0l9wvLbwBy8UPvZ8p44iSsBkqOGTVgBzbykpIJgSDbaLyhWezQ
 nBBsn1MFEnj163BmpCtpC3kxMepvPLfrIpnD2SwKAZSjaDNmscuMqyOafOL3hPnA1tgC
 Xq2TRIVphvt1m5xOVzH+sfvJ6XU4n3yplfNc+U8uevz6VMTqgj8VyrlyD8pp2i8jfYGj
 yh95zX6Hu52mHZTc2Jv+nPAcGDJRYd3RrEyCEj8B+UbYfFeO6v+cYkG2J4gN929zVQf7
 BC5flC8CFTnZZpjklz1YTo6RSDMWujj/mCWuidMEMKtZfdyDMsVklBn6rGuByrp5AflO
 32fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/Tm7m0tDkSVc/SzgB5loNPweDdBi8/hIRRUVblRzu2k=;
 fh=FlzMlNxNHKSw8Zv4FH2lxGmuLigz9krl3KVAnzJQ6cs=;
 b=AtJ1UriZgZoC4UG71C12Zej3v32uR/2CFyeoYfuZOeEMj12DDmIXT9sa1Z/OOranEg
 19qm6M082VL/R5pd5fW8cyU5pxqzc+hU/Ku+0QOvW1+4BWxAS7OiLIvQ/c3nnPF6u8jf
 Tqg5taVJlTEtSJtjvWKvWUpJzmMUQpZ6cPnepQ9rcFXVZLqYoN0rDqtMaZjPKOFgTFVo
 7q3xk37wwGCcw7E3WXj+09RPDiRtGA7Y8EaSjnpbkmWCDACGMOso1FGN8OsJ0HjInQaI
 jtzQZ7Hc5j2phEUKOuchYXDgpVIfLv3TT3Routje2SNf6DzDlkTNacKm5QjYWgLZb1yC
 hoZw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446309; x=1789051109;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Tm7m0tDkSVc/SzgB5loNPweDdBi8/hIRRUVblRzu2k=;
 b=F9HLdJr9QpFXyCNpJfwbJTRS3lhRlQEBi9INvMf3P+0UqgCdAHjn5RahIM0Wof7fok
 DsHuKxlgnU64vu6lLy1WlXsryTaHu1O/EAsW5z7aBXAo5H9L6+ymIkZzx4T6q5RAhx/g
 uYxrMuGwD9eUCUyujeqcXhyiB/Sekp/CScsA4v4dMTG3vyghR0QDbRxqBob/oCX7wqKl
 ye2O4LZ1kq1Z9mod6n3VRKeltTlxocvF9XWgO1K39NysjDIQwfIJIJuTafsIVT6hY4OV
 EVfl+LOtwAGmGD9Fxe9sYLJEHgGgtRjt422ztY87Ld4fY6es4+6Q/LzUvpWTc8e6OmsR
 MEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446309; x=1789051109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Tm7m0tDkSVc/SzgB5loNPweDdBi8/hIRRUVblRzu2k=;
 b=nfgTSRnv/vY2QMyvEYmOWXTgE30geAzRL7vVanS+PyNxMvueCslcVfojtalcU4/Wab
 O/vMXKi7cotnxSTDugwx9Uo1TS09uyw9XjISANAuu+E+y1biG66zNfwqAjGHZ3R6QPgv
 5+IGaCuRsLXK5viYz4JFiajNboOrmDOQP2AHzh32djRNjWiG+MmwhNILZfAw2oauA8pJ
 FDXYnlU/P4cQ4tde0/OFhvR7zBuKb0g38ya0frwA9qV7x2jmDoJ/boOwGcNRolLYiQoU
 qy+CFAHTrw+fYOul4nlvkpNMXuj7TepSonlwP2U5nMtrf+yY8bBXH2hrzAQuQlSnP+O3
 hKzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByaQcR8VQ4nHHxFlLubfVFN3YlHv4HNZzkpP7x5socQ96cyI/GbiIM8/CMOFtQcOS1PJ7arDqM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kj8LdZKMw1JZaKITlR/gHoBFiWA+d6v3jXTOK3aFfxu6Us1atJ
 UO5pu0F9BNUIxSG18euRbcaRT9jk29WeMg3IydD/y3uHvSs/ZdgqwE7FB7qd6fr1AMzrFJ1ADmt
 +2dF9jWDjewvdh0SJ+UhanLv2SmnvI2o=
X-Gm-Gg: AYBFou1aSUTF/QegkZK0D/CB2mZ0ycOZegjubInOQUxRoUrtYqdGRDDVZ30dNtXmUlJ
 vltwVpTvr/rkuTDlkfLkJ5+kvEea5Ye3FC9XR+TLZN6BgfsIMd0np4Tp1/Y349uC71hW4ZOqK7g
 T7vOB8gLQOlbvsfYOK7qe4Q+YrpjGOTI561Oqco0IqBOdJ2Fv3yRWPtbOEBrH8Qhmj2sIg5K55+
 loQT8ZGQz8HK3AmEA8SulYvG/0ibb/Vwtq0WNQJc5ixtwjCNOqcRceSR1TRUwE4fdwMNa7I6CsP
 BdTtnio4TW1em0e9uY+trI1bgGOytEKLYndG9FWA7Im5hHk=
X-Received: by 2002:a05:6102:5247:b0:785:a48a:e3b9 with SMTP id
 ada2fe7eead31-78a1f21a6b7mr5457238137.4.1788446308680; Thu, 03 Sep 2026
 07:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-13-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-13-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:38:15 -0400
X-Gm-Features: AcwNN1WiLfu3qUFTI9Je2XKFgo1xSQUdRpplF46nNfozgduqpvnnJtzfAA1zgww
Message-ID: <CAMDkj5xhfm_PSS8SH7D3bFjxCQGx3_KDBJKJX8t=tJOnFiBKtw@mail.gmail.com>
Subject: Re: [PATCH v9 12/15] boot: pre-load: add support of ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Right now, u-boot can only boot image with a
> pre-load header with rsa. We add the support
> of ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - avoid calling image_get_crypto_algo several times
> v5:
> - simplify the function is_ecdsa
> - re-use already computed crypto in function image_pre_load_sig_setup
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - no change
>
>  boot/image-pre-load.c | 53 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 12 deletions(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
> index 2f851ebb28c..af72ea6d547 100644
> --- a/boot/image-pre-load.c
> +++ b/boot/image-pre-load.c
> @@ -70,6 +70,12 @@ static int image_pre_load_sig_setup(struct image_sig_i=
nfo *info)
>         return 0;
>  }
>  #else
> +
> +static int is_ecdsa(struct crypto_algo *crypto)
> +{
> +       return crypto && !strncmp(crypto->name, "ecdsa", 5);
> +}
> +
>  /*
>   * This function gathers information about the signature check
>   * that could be done before launching the image.
> @@ -86,6 +92,7 @@ static int image_pre_load_sig_setup(struct image_sig_in=
fo *info)
>         int key_len;
>         int node, ret =3D 0;
>         char *sig_info_path =3D NULL;
> +       struct crypto_algo *crypto;
>
>         if (!info) {
>                 log_err("ERROR: info is NULL for image pre-load sig check=
\n");
> @@ -114,11 +121,24 @@ static int image_pre_load_sig_setup(struct image_si=
g_info *info)
>                 goto out;
>         }
>
> -       padding_name =3D fdt_getprop(gd_fdt_blob(), node,
> -                                  IMAGE_PRE_LOAD_PROP_PADDING_NAME, NULL=
);
> -       if (!padding_name) {
> -               log_info("INFO: no padding_name provided, so using pkcs-1=
.5\n");
> -               padding_name =3D "pkcs-1.5";
> +       crypto =3D image_get_crypto_algo(algo_name);
> +       if (!crypto) {
> +               printf("ERROR: can't find a valid crypto algo from %s\n",
> +                      (char *)algo_name);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (is_ecdsa(crypto)) {
> +               padding_name =3D NULL;
> +       } else {
> +               padding_name =3D fdt_getprop(gd_fdt_blob(), node,
> +                                          IMAGE_PRE_LOAD_PROP_PADDING_NA=
ME,
> +                                          NULL);
> +               if (!padding_name) {
> +                       log_info("INFO: no padding_name provided, so usin=
g pkcs-1.5\n");
> +                       padding_name =3D "pkcs-1.5";
> +               }
>         }
>
>         sig_size =3D fdt_getprop(gd_fdt_blob(), node,
> @@ -129,12 +149,17 @@ static int image_pre_load_sig_setup(struct image_si=
g_info *info)
>                 goto out;
>         }
>
> -       key =3D fdt_getprop(gd_fdt_blob(), node,
> -                         IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
> -       if (!key) {
> -               log_err("ERROR: no key for image pre-load sig check\n");
> -               ret =3D -EINVAL;
> -               goto out;
> +       if (is_ecdsa(crypto)) {
> +               key =3D NULL;
> +               key_len =3D 0;
> +       } else {
> +               key =3D fdt_getprop(gd_fdt_blob(), node,
> +                                 IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_le=
n);
> +               if (!key) {
> +                       log_err("ERROR: no key for image pre-load sig che=
ck\n");
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
>         }
>
>         info->algo_name         =3D (char *)algo_name;
> @@ -152,9 +177,13 @@ static int image_pre_load_sig_setup(struct image_sig=
_info *info)
>         info->sig_info.name     =3D info->algo_name;
>         info->sig_info.padding  =3D image_get_padding_algo(info->padding_=
name);
>         info->sig_info.checksum =3D image_get_checksum_algo(info->sig_inf=
o.name);
> -       info->sig_info.crypto   =3D image_get_crypto_algo(info->sig_info.=
name);
> +       info->sig_info.crypto   =3D crypto;
>         info->sig_info.key      =3D info->key;
>         info->sig_info.keylen   =3D info->key_len;
> +       if (is_ecdsa(crypto)) {
> +               info->sig_info.required_keynode =3D node;
> +               info->sig_info.fdt_blob =3D gd_fdt_blob();
> +       }
>
>   out:
>         return ret;
> --
> 2.43.0
>
