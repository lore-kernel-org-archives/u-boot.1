Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC9FC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64FB860B71;
	Thu,  3 Sep 2026 14:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W89qcZ43aZNE; Thu,  3 Sep 2026 14:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8619F60B72
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446114;
	b=hUz34AEt02H+41zEvWWlSQ2GgpIMrOENB6k9AGHptxiINjTd2dRNvr4uxMwy/rzQiPGX
	 39hqIsRkOyXK2TyXNi3Mr78oXwQ4OwW7+G9QyDxda13IGrug9R/THQ5km8a975YO/cFYA
	 hXyFf+aIf2DdSV1G2HSatm1e+LxAIDMu/eGFqf+AVwT497v8BkvqmIsOt7ogcZ45c4Xft
	 jRO1i4Ht8L8NyRkIW9pRPWjKauEpD6WZjDqIQPbMkNNrV83wO7MEH4sxDufJ/oUoFliZ3
	 5yXGF5DXrompAABZxfStuxj3AxjNMaGekUcFBvSteTzYXLVWDfJtAbUwZJaklwB0CuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+6MobPiVsPyXRpYoY0SJRsazNr7fOANNfUlfKtuDmxE=;
	b=I7GLaWKp2vU1b1NprjJzy/MtmrluLyBQ9Q80Qfucub47Uh1eCPAo0ksSCqLuD7L2VX1Z
	 LZOen735CLbw8hUI0HN8uMJEsU3nzwOpGcoHX44Ij1IMHtKXDPO5gGFOmRTSnjvtUgEBB
	 f9taiLWZtAjH4rVoUDr9gK4tZpDzqkokNqtdsp0zSOAkswKCWRRdXlRkUkV7GkDkNq8f0
	 R/1JOKNayhhfB/Sjzgjl3GdOhx2pR03EdBYSu2iSHNaRFDsodj+biAEiFDkVbjQi8AYkA
	 BM9oC84lZS0uvvrGniZJ01TsFMRRVFpMi5a6SkKoCQevE8wAc4AmkAxf6mZNAk4G/pg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446114;
	bh=+6MobPiVsPyXRpYoY0SJRsazNr7fOANNfUlfKtuDmxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pdctcOJfC5elpR1fFrIdvCPGIU8ya0HNn068yDWPxA6Y60T+MeXp8SUnSa460eIs2
	 /SjzzC8S5r5r+1FzZ6s+Hlt5QHD83m9ZZmVcsbfQ8XMMr931+Bce5H89V5HGveouib
	 pKihG5II1m+E3Wy3OmjhaZAydyStigmOzKb3YimjpGzsCh6ol7fgWX0IlD9UzrwPNZ
	 gGxSifZUgRQfgDKpqyVYbVMdLjy8yyk+dk+Of9J8t0mmSMmq3cB61bptKeBC+89Xgx
	 YKWmJShN9emUUXdumr9S/EE8hJ5yQaHhjdXto+RArBXUCmf1vc2BXRlCVpTzJ5Sq1v
	 35eb6KXt04LPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8619F60B72;
	Thu,  3 Sep 2026 14:35:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF513279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5B9F4046C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Md3IM3dvZHBG for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DF47740462
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e35"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446113;
 b=UqxVp85eBpJnGhvwuOU/lWqLkMQ05BcAmu8W/P85/wT8EU2EyRn7QafEtjry0eyZA8zb
 RHJT+ehk05r5XBqTOQ3sUijbHVCeDziLpqahxigpBs7Vq/roBFynJJODN/l2EzkmSEg+d
 C1aFsL48HUO3/8GGtAf+H4IN1KcQ31ToBCwZrVbkk87pJCiOtEhX89Liq/jbYVRXc+T8g
 EMMrXa87pDCzaqE9biKPplTMWAHkMpcWEDKSS2GHlY/PuVfPmHG86OqryqAZXPzNxme1z
 HMWNTvy/pIgYEkmikB0mXMwrz5XwNzLBTMWfH2d5yjf/Fd3Epti1qqiJKasJM4s14lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446113;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=+6MobPiVsPyXRpYoY0SJRsazNr7fOANNfUlfKtuDmxE=;
 b=g140zuxn7FQ5anXU0Jk1t3rfAswuBKkwak7uijKl4aw866Qz0DUJlJe9ClE/bceX8iBD
 lUAakj3Ec0estuZJNRowgakfLkOKir0/xJQ7Thedh1Cn69fHfgSrMfjtRttM39aDb7owp
 YYWelU3KTsfhhwYKvE2M/Bgm6orJ1F0/INDw+w8NwPjQnMIaqV6LFF6r5K91mclBZiuGR
 mm5k11+P7g5TN4XoZf3nSbwEmvK/FA0mbu5yvX/rm5I9ywFF7RX0D/I0gVpwMKGgmW6HO
 x67Cdu4kolrc/sdP4ehP6lEGdmiblteCTLmEOlvLGBvr4UHAYWFP475UjlCvoAmiR8A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="M5/5MfFc"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::e35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e35; helo=mail-vs1-xe35.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=M5/5MfFc
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF47740462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:35:11 +0000 (UTC)
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-777ae5e5caeso940624137.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446110; cv=none;
 d=google.com; s=arc-20260327;
 b=Lox84q1iQQCJeyGl9OSIfmS19kVNp7p1tD43T4n2OPAm55qNdkBvhJ0pI46jlVY4FV
 dbqKOMIs4pFyS/SsulLFZkM4ihC+w4ZB0rLMr9n9MkCmPUdwiuVQk6iAkAVEF+I+uPHr
 XBKb3/D7Q6MfqdpmzYYYotBn1STO54fF1tAUJEhGtmOOLNJvnEK2ynw11kGdMOyHgAh6
 dEAfBdwaDFC7dFjOezjvyI07iVw5C+/lZy1wSM7cEBR8sHrmW8rO61WilPYhJ/2bnMd+
 6QgHIN/HpZXkE6gw7oGshNMgw7Z54/AuBh8qKmwpApgUsRbKouQHHJr9WtFF4TBRpRHh
 ihwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+6MobPiVsPyXRpYoY0SJRsazNr7fOANNfUlfKtuDmxE=;
 fh=vImoYxjZUCT8Nj1u4JGQ/DLb755Y2O9acgftop+zSps=;
 b=qNCa3Xcbj5M5rJx2s42FwBnpzkJn5T9hTnS1m2yJFWD5ANZZ0+tUI0TSBjStvtQ/up
 R/foRQy6MAOllgpd/+XfIl5jmxXLQk7Xt7NG+Y9eKPijLuWanhL6ulI02r76wcAxq5ES
 /BC7jx2FohKNNOZbkXssTwkm21brDbvw1bAUbn4Hx6IsQSlkKmJo5xoaLnLEmu1GTJui
 Yhgl2h5eAm+BmGnn1KT7KC5KIrMbAjmLh57GqHYEwaPb3soiyonhACrg6FYAJxU5QH78
 +jjT2MYhzBL2p3v/bwym7Ss14xBaeDN8ViASlK5+hSDOujdIKDvtckyOoS7tcc62ynd6
 0ZOQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446110; x=1789050910;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+6MobPiVsPyXRpYoY0SJRsazNr7fOANNfUlfKtuDmxE=;
 b=M5/5MfFcAf0XI0YaF8bi+T3tlGCFhcM3SzI877Wduks/j4+rZGdERrM5cf0jAUl29G
 dEzw1Tp38V6h78poUrcEM8JNHmblcfpraXNTw8XvBoYtMmB1VMeVnC++dwmaHeLSaaqR
 FlKIPbMsPiNF4b21qeGdauJLJr14JPyHVrUcjWdbLJasGetCikuvd0EsQDKokhgJ2fCU
 MwtDEeKWwoXj+GV8OuIGf0Db4pbkhaAn4tsfSPONFenYbCWMEcjvxnf2cpgBTKPnx9Dd
 NI4N8cp/QE2MNvv3OdAFT/7d/d4O2bVZ8FSWsRwJ/jMhehH65I4kiN0lhli0NGBN6sJD
 Fvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446110; x=1789050910;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+6MobPiVsPyXRpYoY0SJRsazNr7fOANNfUlfKtuDmxE=;
 b=Ij0FwPu/C9Y7EbbydVCJFqBbeMJdNV4Gzj89X5pp72CnqEY1T72Q4Ys/zqpw2ySlFp
 vX8JX3XENbBMe5avEK5ZQPp1JXkmR6iRc62U/vKuW7iGxYCz4duskqg3hEf7dvVNrkPE
 wf/chz7/1LenaKfKb9DGn1bplzZGfg3+ZROY59YUO16SI1naRXLHeYZ5pWyj/pcM+ay2
 KbvYH/ZfGveNr4YzJRNq0krGkjz72RnIRwnDIBk5RTyPUv3LmLy/XsENW/rQuXbaRtw1
 mbo5ovBDwxn3DSqSnBrfvWQ/fwAuMhCFQwQFdYY3Owo16Faf/6HlpjRMA8FRYlVnCh2I
 C8uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxazwbL5ZBKe84ga+EPhRKzya2wd490ihQm0lgU6b8BGTH2GEASF5CBDkTZSQi/J3P28XALL+Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mpBufSVOmSyNtbwsppmYVUjl1L+UhyMWgLdVSPmZp5AeWVULlT
 7Xe8pz10B3yE1ohlABnSzpkR0smtpYunO3MqxfVMD8rbEy026pgKswQDDd85KZSPXUnKgfSbs3y
 j0+0Ymb2Am7lWoEtEJ3Hzpqenkz5B0So=
X-Gm-Gg: AYBFou2CY/NL2gdhhcBpBNLqlSSfrCq/N+xaYm2ojlsVlZxNw6IDiGRRQ+waJ24cRt7
 aLSj5eSWnBAFv6RFxURmOIa6ub+mRQLYW7o1MF4F1DRSeEry3o7ZFf2kNN2yD5KH3jCm/9/fGwN
 GEYXxczI8diGjdwJa1MB+fuj9K9Ijyk8+4nGfpR0md8/XcgOm8uc1eFk2+B7oORzCXZqlJa1gQA
 6yMbyEgt4TEL1vPkvRNJpORwExjmyYBq05VWs8DkuN5kRavB5AmzGIN0tEYk5SgCaZn9mGEPQN5
 E/z0K+TN6YIe4xoqB5T/gjth/ziHpM+4jS+PoolboDl7QRLugsxkIP2tjA==
X-Received: by 2002:a05:6102:948:b0:778:71e5:45d3 with SMTP id
 ada2fe7eead31-78a1f34b329mr3549461137.9.1788446110303; Thu, 03 Sep 2026
 07:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-10-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-10-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:34:57 -0400
X-Gm-Features: AcwNN1X9OWU44KlgGVl6mlIw8d7d9zXCu3DJZgUJwN6lQQ9b1-dRMVzNP8pwf78
Message-ID: <CAMDkj5w=wEakR8nQhKLAdxqg3Jdceamc4w9-RkM-8RUivU3pDw@mail.gmail.com>
Subject: Re: [PATCH v9 09/15] tools: fit_image_setup_sig: set required_keynode
 to -1
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
> When initializing info about a signature, set required_keynode
> to -1 instead of 0, as 0 is a valid keynode offset.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v5:
> - initial version
> v6:
> - no change
> v7:
> - change info->required_keynode > 0 to info->required_keynode >=3D 0
>   in ecdsa_verify_hash
> v8:
> - no change
> v9:
> - no change
>
>  lib/ecdsa/ecdsa-verify.c | 2 +-
>  tools/image-host.c       | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 494b60b4ab0..341486de2d3 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -117,7 +117,7 @@ static int ecdsa_verify_hash(struct udevice *dev,
>         if (!ops || !ops->verify)
>                 return -ENODEV;
>
> -       if (info->required_keynode > 0) {
> +       if (info->required_keynode >=3D 0) {
>                 ret =3D fdt_get_key(&key, info->fdt_blob, info->required_=
keynode);
>                 if (ret < 0)
>                         return ret;
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 46036673050..9a85a3dda2f 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -202,6 +202,7 @@ static int fit_image_setup_sig(struct image_sign_info=
 *info,
>         info->checksum =3D image_get_checksum_algo(algo_name);
>         info->crypto =3D image_get_crypto_algo(algo_name);
>         info->padding =3D image_get_padding_algo(padding_name);
> +       info->required_keynode =3D -1;
>         info->require_keys =3D require_keys;
>         info->engine_id =3D engine_id;
>         if (!info->checksum || !info->crypto) {
> --
> 2.43.0
>
