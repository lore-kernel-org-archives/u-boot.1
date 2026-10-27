Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB26606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RjgG0P6Z;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pFHC0vOO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFA4C40597;
	Tue, 27 Oct 2026 23:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzltVr83Caz7; Tue, 27 Oct 2026 23:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E5DB4057D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793144211;
	b=P/IfeLxePL/kYsSNVRHenBZCPb7tyLU7f5FHf5yLsg7qadUPCcG/KixWyF2aqh2OMmuN
	 AXEXE/LnAgdKKpZeiiwKJFjm6Ehi/Ji1nVlMWSIKAtn7ciYsSCTrEllW4rvV70farHb1M
	 KpCzN10qMMrH1E0Cgf7AxuQFCKl+uYOoT/h+VMTqhXMRn8j+2eG2sLIkgooS3ScXFy32o
	 7T97qwPTfgf2RLNVHOQpOuZ/VWGNEjkJj8+8s62WgBkGeBbXJi4d379oL2/22+iYv+fdw
	 xVKjM7i8kpFbNTnnEGI+EXw3/b8eFFcQHSEbINHvR2yDcu+v7mQ3DepSISam5n2QEVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793144211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5BTShpLqx5sWcLF6x0r1wOMk2f398K+nmx8JviCnBEg=;
	b=VH0zYJHYIeyS90e8AaFsm29AxeGz7CdTnBcePlvjP/dyCrgwbC5sTWScOChOj0Xkk/yU
	 LCrJDNZioD5g4Gpdna+Gh2q+j9QFhM5nKgEBC4LqvE2trRJ+3d0QAV4Sqsr8w+0keBGNy
	 ejO6fNqHvXVb7xfj0iho+MW6/r3/CzvIZ7dhD8+K7bHqnQfOmWaKY4bbAf1OKApEAgMFK
	 jfTdpI9+w2eDubO0yg1/oatEP8Ok2K/fbbja9rbNT3WxwU3flayKUj+REcpmiJDkl1sA0
	 cAdNC5WmahjGyOs7MpoODB1eRfBl9wYq6Rc9xt6X990XLnKnHVWJmBj9ZtRjhbAajxg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793144211;
	bh=5BTShpLqx5sWcLF6x0r1wOMk2f398K+nmx8JviCnBEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RjgG0P6Za0WpUvN7f7Rvg1H/057NS6AJbdvSf7/syMZAvwh5SmxzBU5QJPuFosk2K
	 eQ8I0AQcSxmerHT2mR4MrN1F1s1vKxFkcJ/nnifDE1G3LKgjH0gFVj/TqtEMpNG5mk
	 Im8wbExhaSoimZno/+efa2eMMLTf1Qe8AT9AM4TqXCBsf8acPOI4S7TX9s9ptyzCc4
	 360ph/FrZ7o0tQfKGVeTU00N9yk/yjB5NAPMrsPf4HW3thY+YoT7tkTDYSYrLKrN44
	 yMPdtM8lsRreDAjJ1OkJi/fK8rksplNFygGUqoxXNo7VM0hOX1DUZxdqQ/i/QwFeet
	 Mq1NrMCXMw3Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E5DB4057D;
	Tue, 27 Oct 2026 23:36:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C177D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 520304006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AMu3CUaKWDDr for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 23:36:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 920DF401C7
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793144208;
 b=EZ8wQu6ihYZT5IRlmQBwT+eOoGqIt7aomdk9NkEO4KdWZREy1rArUAQXdqBWUHZR8g9d
 wmdHl/skaaeTle56Amn/6tcAnhHM85gEvk13zUsCIpyzT7ieFRjnkUMap2bgU2khfsjAD
 fn7z0/6t2D41qpY+Wn9L+BKgvRnzQ9cGsS2hH0UG0ZiCgQy3kw26PHav5mHLzsVpZb5HF
 V1rQmq8FqBlG5Q+Qb8R6gBmWgploxkN/Gogn0vmve/pmdPrJehXIZkphXQ6aihbVI+c3W
 O1uMXfvjWEq8H9klfnTb9493zAg6T7KuR6G6fWyTAyss1C8IPkWQ0prVzB2SDvtXc8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793144208;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=5BTShpLqx5sWcLF6x0r1wOMk2f398K+nmx8JviCnBEg=;
 b=KvF4fTBO/JCSzrxSmvlAyCrk3jnTLL87Z1X6yXlUIqF+HjXKBUqs8VkwEk83w9HFdDOJ
 0KDSp+p5pPWj/GU3hVnw00soMWfx0+PKB+vUpDJ0v8low907cWCwzhmmqCOgnPK1J5oiw
 KYAxB2eABHpLoy+8yF6dPB5r/lj/4RDRN5AHxtla8aDY+iDGRcattIM2C4tQfsDad7Nlt
 uf4IKK3Zj39sqZbBfnGwshlOc+6Q5UbVJY1mmqoS9QDiP6Bz5NsIqzUjF4kzM5sLIFHeH
 Xg2hfQV6ACFh2DrkldfOvkeZvuwTcYm6Ya6GJQSsK3z4BJ96YkPecXF/rkZLVtZet4g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=pFHC0vOO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=pFHC0vOO
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 920DF401C7
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:36:48 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ab37e44643so2633507b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793144207; cv=none;
 d=google.com; s=arc-20260327;
 b=KxsCnZNskL9vwFoRo2zS4UjGVoDed5hMXXWlfKM1KL/sV9aj1BcAoOLE+KY2ZR7riR
 HvTTRg4vu0Y0t2UrRc3zfgIG2LI6B+ELARDlF0MkGm9OW6NsiD1wBZl9nUlF36x1cVpf
 5U5YN90GZ2Lxy/CnZYo5c24aM59mCZa3KjzOVaRpvfA6RUQo/TaeH7Yli1BHIytanZFt
 6PsJcczOJIgS+h64pYERcM7IbcJzquQx2NZI2fh11g91+5JHDJI6hv3jNHviARHpuiqp
 w3KGUyogurpZX4Difm3LIfbpzs1IiXIutu9/vvhz6mPslL1xj/yseaAxYEyluoV3jvOf
 gTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5BTShpLqx5sWcLF6x0r1wOMk2f398K+nmx8JviCnBEg=;
 fh=c2XAJkz3pTgmMho7P6mFsU5xHZIxNn2k040DF5NJppk=;
 b=JC+YW9cUIGR98KmZJoMVVCQXJFVmFdk4sd0J+wrzXtj5k/rhodHq34s/gzJHNu7fiW
 7eR8RqfLtuAVdgP7T9ycCQ8ng9QzmkwGVugTGO4uC7IB9SnvOmWiB9xAULLESUXc8fS1
 JCCbPkxTj9jgDDKBZzaZblyHKBvCt51X1Z7HYqdBXkyjadD87bqLcyTcCVZpU0vJipJ6
 A6wTD5iZpB5W4zYQ6RonjYRpAu/9Gbhl6B5Bmx1CHEL7ck5yQFPA5LcJCAN8WIHLm0CX
 umsP0z6v60v5MBIZsr4b/bC7EOXc10YvKeHRpOBwEPGqxbYTblPkasp8sB4cvBRjElw9
 gfdA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793144207; x=1793749007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5BTShpLqx5sWcLF6x0r1wOMk2f398K+nmx8JviCnBEg=;
 b=pFHC0vOO0DHVyRQ3D82HbWJ6KEgL7yDK7XOHcfMI+ZvmnEKM13Xd3R9Li0zligCFSL
 y18cns0wC4rpvOsrVK5bJTI+tFghO/r5k8XzzsJ0xk0ROTln2EWeOoI9Ax9LR6jIGzBJ
 cHytoNajbccpl4jvS5P1n8KyHL7bV7mNOunh6s/ZaUwQqHSzraFM2OoCwrvvGwjTlV9x
 B584sqTExloweh+bsXHQ5ROb9O1jqOIsALoNO92Ofo9O5AP3D7KunusPJ0v3PkP9Z7mD
 OWTYJmnTKbnNk4cg1Z7mk9l/2ZE+kZZOuypTsRRgOZTRMHn0gpX9OVxGjjYFSdhKYCoB
 7CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793144207; x=1793749007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5BTShpLqx5sWcLF6x0r1wOMk2f398K+nmx8JviCnBEg=;
 b=BusaVB8gJmSfHSevGV1EIqHcuDqIJ78h1Y7ks84165FrJuEUPTpGil6VkaTxK0xEvm
 kZd7NNO+f0Ok7dRoQY07KOqrCYgIydV0xCWw9+d3vJSF+4zSMR/0PI9IcHV6U1h9ypAY
 q6A0kZKehlc0RVdp6u04bc0+e3dqZHtrkhgtc/QjA0ideF2v2BJbpwkEI/VjolxWhLNZ
 ySyXFG/mBY5JyaPnu5u5Cau0iEsY5RkcXh35EuKc/ZxL1S7HPt4XeQ1ayATufiLKqGyc
 Xp8vjs0PWhOyx8bbWTTYef735b/iSvVPxDDa7gqTRYgbsD8jFYbEcaTgEBz9KrbqwItG
 KPBg==
X-Gm-Message-State: AFq9FYIV2+/QlZM6/zHNLy15gYt1YriQCzJjvssm3AAXAX5i8t65JWSU
 GkamKz6vc+m3SVe8vsw/NcZ+yL95AqUOHA25GgP/9E51kLVHjWVaAFEusZnZFKdMT0PUtWmNRad
 wIjafOBkp1akxSdCpxgIWhaNWlcZFxHY=
X-Gm-Gg: AYBFou2CYcvFemBSaPumPEf9kgKHBja83ZIZ4lBQQerL42ZKtKDXR4yyO4slG75KAjG
 dy7q5wxIQvKXVUbjDbE9c7613EP/keIn5KvdIPWkyRXdpSNt+jsANXDX8zku2xaZbyMh2YT3nhz
 +TZtT/5zJvlveTm4Oi2fm8HSm6GbB1fRo1gKTnwROLehLoCoNjkTE3CggyAdnSTJb3qGkusdC6L
 CDNm7qsDBnnM2dc5LvHxo9gQt728x5OsnuNlNhn2UpeFPxOSUzfv1ZKGMtOita7JUU5rjPESnfS
 eqJEManBOIJymikDR7FxpvFFldXSY4dPzorHBMw3NpAa3VvG8VPNp4TO2N32cgC6FQgrnayH99B
 C7q4sitSIemt/M848yN0CYjW4/mm4GTEbUO3tlQwZMob2MURZqWndnenVK+nh0TpJhzy7aOcU
X-Received: by 2002:a05:690c:e043:20b0:8b0:e619:7047 with SMTP id
 00721157ae682-8b1b5cde28emr3114737b3.50.1793144206974; Tue, 27 Oct 2026
 16:36:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022155806.115031-1-dimorinny@google.com>
In-Reply-To: <20261022155806.115031-1-dimorinny@google.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 28 Oct 2026 07:36:33 +0800
X-Gm-Features: AclHuK9IcUwQ7f00TsqLZotDc9O4cLZ66vZ4IPF152UF4dnkXOl_VIPN3zM5k8M
Message-ID: <CAEUhbmWvrti6kurv0Nvj_6yxztH7O+hx=zQRCr80pNNnqTNVgA@mail.gmail.com>
Subject: Re: [PATCH] x86: tsc: Read the base frequency from CPUID leaf 0x16
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 22, 2026 at 11:58=E2=80=AFPM Dmitrii Merkurev <dimorinny@google=
.com> wrote:
>
> cpu_mhz_from_cpuid() should return the base frequency in MHz from CPUID
> leaf 0x16 EAX. Commit ecf31113f178 ("x86: Sync up tsc_timer with
> Linux") changed it to read leaf 0x15 instead, while still checking that
> leaf 0x16 exists. Leaf 0x15 EAX is the denominator of the TSC / crystal
> clock ratio, typically 2.
>
> The function is used when native_calibrate_tsc() fails on an Intel CPU
> that reports this ratio but not the crystal frequency:
>
> - in 32-bit U-Boot, for models missing from its table, e.g. Skylake-X,
>   Ice Lake-SP or Comet Lake
> - in 64-bit U-Boot proper, always, because gd->arch.x86_model is never
>   set there
>
> U-Boot then assumes a 2 MHz TSC, so delays and timeouts are about 1000
> times too short. For example, a Core i9-10900K reports 2 in leaf 0x15
> EAX and 3700 in leaf 0x16 EAX.
>
> Read leaf 0x16 again, as cpu_khz_from_cpuid() does in Linux.
>
> Fixes: ecf31113f178 ("x86: Sync up tsc_timer with Linux")
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> ---
> QEMU reports zero in both leaves, so I tested qemu-x86_64 with a debug
> change that makes the timer code see the leaf 0x15 and 0x16 values of
> the host, a Core i9-9900K: the TSC rate goes from 2 MHz to 3600 MHz and
> 'sleep 2' takes 2.0 s instead of 0.008 s.
>
>  drivers/timer/tsc_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>
