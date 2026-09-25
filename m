Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89212C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 19:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D62740B6D;
	Fri, 25 Sep 2026 19:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xr3kLx8HoVix; Fri, 25 Sep 2026 19:18:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 64EF140B1B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790363932;
	b=PqCqjDxVTRcz7MFeQbt/P6ryUnR9DrKGS0QYS/jo/x5FVankAd+8RUjVww9XtB1zZN5y
	 EzTj2rDvVRkXWvLtiFhewdDhEYry5JLKfSQ/WyfzCE8Ni+bOkzFl0qIbC7M5deyxVzMmi
	 4NFbZB4gTYmmDQ8+GMPgIIsd6jDharJ5sv5dsPwPe5AMN2rH3JwzG4A/7BtK04j2ke5OC
	 N2+pli+Z1jJIVKYcDZCfHskfGCVceaHYdklhU/T5sojPtahYAoqY2fFyAgeLgo7P5INgK
	 KX6Y+VPrF2kBjbpcqwyA/TLtlP3c8tFYEpvV9a6GOMS1h7yzi5LHQM2HNF8FZs73l+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790363932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Bc8p/2eeqh1wrjH7wnGMBLnMwvgJOfWe48aP4AYO3n0=;
	b=ASjhC9aLzS1aFDfNS0Jtj4fyu/gI8T+8k7HqVyWsphHTDVvEYrrT3vCPU8oUQTZAM5f8
	 08nTeoPjsHojH9WF5KYdJjL125A92nP2yiR5igs8+WLj9ggBVHplK/W0ypeCF/1KPEvVR
	 Bah1WZw2gX2pBLSM+y1yHFkJ797Fan+YBY9bG+FFS2K/QjJeuwbJcYfT3BaFUGveIyOd1
	 Raw0N1Qpgh0TfMnutSp1GfVhunZ2ZtEITUh4mP/H5TuPQLTY3xPlLfoKtJjaqljKT23TN
	 /Sl1VT5PY6IG8Eq2Cgwq2hsRri01KW8QLUk4Nk1XOMwgTHb78kFaZJrkbsuBSzj/WpQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pkCdGEz3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790363932;
	bh=Bc8p/2eeqh1wrjH7wnGMBLnMwvgJOfWe48aP4AYO3n0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xEb/BZS15muhvnhMArZsq3dHwF7qmjC35wemFbQ4FffO8DufXCQd2KqwMY3momq0Y
	 tPwtuZZVGwT3sGPpTNW+MFNqfZAclnFnaoDHahfDV5anoDbUMU6OtDq41gyGxUq5IU
	 CxyOtHY9qjJp9Rvf7U8WBJ36o3W05fVSJZZ9m1ytfF5GgZYuugNJbVRWPhO6jEcrK/
	 OVx6Hsb1rBk6ohUC8WaalSSBtTQ+i/qZgUN4NrkDIBWzuyFfOzEj+8K6+j/juC9OOg
	 puesm51AtJe/PQEKJjdi2M5CsYUyzkbqR1+97tw7tahX6+bElYoO68pUvvPWpfbVXy
	 l85DjX/rJ5JtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64EF140B1B;
	Fri, 25 Sep 2026 19:18:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6668F32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 19:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 587E940B1B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 19:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJaBQ2HV5zEI for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 19:18:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D28740B18
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790363930;
 b=ihSRmIPd4Fgxw33mlftRcDnosPT8e+ApZfW8k3CAP2WbVM0VbdklRZn3+iEHNGf6Koxj
 knR8Y7EvVv5yIAnSp+Uiv6XZIQYiJBQTQ6BCBrjaIxmm6bjnsPRzpSNFCy2NsbJUYCLdu
 l1IgC9JCx74rl/hM+NbH76kznT+nGGwQQMExiXEYL+6MD8rb+T04eCUXE3+Lw5ACEe5rt
 Rdvk7lcY8DfBowe29ZKrrq7QdnO5CxwTroakjQ/OXvovlP060DzffLIQU69wgNXoT5aL+
 sLngMJPpTIISmKvodWoCIENPSOdWDaMbbMpeRCJNMKb1OofCirVWMwsO+GSACoJCkvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790363930;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=Bc8p/2eeqh1wrjH7wnGMBLnMwvgJOfWe48aP4AYO3n0=;
 b=UCpnL/Jm5mKHh3Q/wZwjmsNINhghROHYeLMfpo9pPo0+SQfpnLYlVW3+VnpHScjDjpch
 X+kHvCHrDPCIBo9FDsjy1L38BClsrKXUMoXChcheCF+ZHDipcrHNPFebprEUrfs1keMKw
 6Q05J75+hongsbHUjBXECWFNWG8vwArsNp2aTqlisyJ5Cdl5VXnaYk6AQKziqMJGF3s9o
 yd2MrsyXJqrrO5IR6vH7vKx/XdFf03pmfTCPPB1J8/ZrbSWk7ey8IbQF7Ig+CrXghneP0
 ibLdTf0WdlZxph2yP0e7CnQlau0gyjzu0udqJJpA1f7F4sY6PrbOEGcSvriEx7fl0+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pkCdGEz3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::d;
 helo=mail-pz2-x0d.google.com; envelope-from=nathbappai@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pkCdGEz3
Received: from mail-pz2-x0d.google.com (mail-pz2-x0d.google.com
 [IPv6:2607:f8b0:4864:3b::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D28740B18
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 19:18:48 +0000 (UTC)
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso698277b3a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363928; cv=none;
 d=google.com; s=arc-20260327;
 b=VwUnGkk7lx1PCfFIbs56jvmtMeXDx5SL8ivPFR9Wo1Kp+wClKU/qSFhldRgpf66qTA
 uL19hahHEVqGS/jgZ/XAe3u/XzgxvixjnQdYpUzO2Cni1+Eg6xPchc053TCDOABiD8Uu
 p8oNCq3FzDtNrT7TxV4dyy1jL6jeRdTbncuwmfcihRjG4Sv9I0xuYEEu5xEomJKerMCm
 Wr1Vci0Uxw/z6bX6MJv6+XalNf2Pf1KU7psRmA9orcY/6TY/YHzY1mTyhjI2S6laeAzj
 JfyCwzf1wnVgZQ4jtEjWp7t7zBJ90fdUxlKa8F+CFvkusUFlMo/8elMpS0cgXWyXTPCy
 VcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Bc8p/2eeqh1wrjH7wnGMBLnMwvgJOfWe48aP4AYO3n0=;
 fh=Azf99/5BR2/qFSNvThpDtxkog0VWeUzY6vSQXcij+ZM=;
 b=bxgMqVmmgx/oi6dVRmFLxT9w0Jk0DScvJhsd0QPTyysO/tecQDGK0jzsHNeD3Udu4C
 +PxCNKXN8yp7lsINSIEFUc9OZ/SavLVrNm0m4vGc74ivUqdGwHX3bWWK++N+KdhA/XwB
 FqFyU9WqDS2R4VrKcyiW6aqL3s5ElgKMZnhJ3UyvwhuY/mkRstufM9p+/15PWy5LZL+z
 W4fiLgp+IqOOZOUv1APTyh8997s2vkcGS/JL4ewsHyxVkOJnqjAtJh4aKIDzx0WP3Cw7
 X+p9OxsXoLSAGzxLj/63+EluOUR6IXYgYqN8jdpr1QrOeXrJCRuF9hfhLQmvZS5d+Xj7
 Pt7A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790363928; x=1790968728;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bc8p/2eeqh1wrjH7wnGMBLnMwvgJOfWe48aP4AYO3n0=;
 b=pkCdGEz3eLy8HZIJ+QjKEJQ9O89zyJB0uhZ1tS1pbtMWknCNFzwId22+WxkCkhXtxT
 eQeW4infL+ZWmrV5nQORHn+CbKvOMpBwwtpwrj62psNJ5H9/mRsef1yfjvpmefzmgSP7
 G8pES9wn0A8SQWwwD1n/nMSQXH14MHdCYaSwVc/e86EHDEzkzQtD673QOQdV9L4d8ev8
 akA/YTr1h5GBwIOYfbqEdZYNPQ0NMEM3memKJR+2ziyVVm99iJLyP1n+v5qxKKWR8ccl
 yeulVZkYPLZkQv3soTHWjz5myG477NihmnQb2LNnbyQD/CwuRgif0AwhO0Z43+gTnscn
 YWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790363928; x=1790968728;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bc8p/2eeqh1wrjH7wnGMBLnMwvgJOfWe48aP4AYO3n0=;
 b=x4fXa2JYMZdo70Tp3rayoEY9RSAecLxnsC6qIsWz1mc/BaY7jR7nv59PsBlix7BXJL
 IDq8XPihH6Wdqmnw/BEXxbQbYBPypvJ1qrBDzZO7nZDF1apo5g+oCEZorZdwPalrs8mF
 WbnZ+9z9UPlSUdidof4XwzUfKBSuCGLGECDAm+KEVszEXOEecC+/F8GiF2B7Wm1QXZd3
 4Ns9t3zsoGO08O7y7LdEYuHt6nGF84tFzCu3L2wx0rvzwSnjD56OuG5ejVwJDjyMfimt
 1LfhP7XWdvykZHltZz4ynZXlt/diLwhSczn3dq7YteD9PJGiyKIyDEFjoz/CeKQjNXKB
 1UkA==
X-Gm-Message-State: AFuF++mfR7dn6ySdUH3BCmL1i39QKwh0PE2Cz/lDJeKZijM714gaZPce
 9K6o7LvROLT3DQVeFHEEXDDuxMh+jUzbxaGzenm6zqPVAz+7zN9tkKVveCmeRZyLHIIQkBmpAZz
 8PzXJ8uIIKv15OfkEn22V+t7u3bFf0BMCoI47
X-Gm-Gg: AYBFou1yJO8Rm5QAYBhritu9j4ZIt+fCyqdablyzVQIq0FCbdgETiD6KOxKwTAfdkrQ
 r0bZX86lCy8ZVpaOGGOH5pXV6d9JKi77acR8HN9qFjzSNe2z65rep1s2bu7rSZB/ddn8VQ030Yj
 gTLIihi2dU34pOoH7vQM29E/RqpIX5oo5MQmwSsxrD3gndk7UINkQNi/tx2kTcNPLdDntjXHACd
 HGxEPeHrUc1jMFkXCxYAoucG6pO9oU3QkJxaXpufpzokDAkdTjgXq8GPEyVcxApd1RUmLH8TaNx
 yvfgf56UStU6wGGetpSTCDGEM2KI+0Yg61OFdciQeY4yb9DmOTEtscDRhKcGRNwgGTAY
X-Received: by 2002:a05:6a00:a90f:b0:87b:6b3:2cc4 with SMTP id
 d2e1a72fcca58-87e9acf09dbmr6072240b3a.29.1790363927570; Fri, 25 Sep 2026
 12:18:47 -0700 (PDT)
MIME-Version: 1.0
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Sat, 26 Sep 2026 00:48:11 +0530
X-Gm-Features: AclHuK9y4TlLq_kLWrIeK5R34RpwOIKPiIv83KQROcUdF4ufRSeQjXvgs83f_Hk
Message-ID: <CALK-3mJ++9wwPJ6yx-ufRTeYgg9tA1O5Z4kMyrRDia6s8SC4BQ@mail.gmail.com>
Subject: Incomplete FIT image documentation for qualcomm soc
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Content-Type: multipart/alternative; boundary="000000000000ebedc8065c5395d2"
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

--000000000000ebedc8065c5395d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In d9252fcde1218902ed4805acd951da0405ba7d1b
commit, doc/board/qualcomm/board.rst was added. It refers to a qcom.its
file as FIT source, but that file doesn=E2=80=99t appear to be included in =
the
commit. Would it be possible to add that file, please?

Also, it would be more comprehensible if the documentation mentions about
the files to be copied in qcom_imgs directory. I have tried to
use db845c.its as a reference for creating u-boot FIT image. Then, I booted
it in a qualcomm sm6125 phone but the device shows the menu
from qcom-phone.env.

Thank you.

--000000000000ebedc8065c5395d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>In=C2=A0d9252fcde1218902ed4805acd951da0405ba7d1b comm=
it,=C2=A0doc/board/qualcomm/board.rst was added. It refers to a=C2=A0qcom.i=
ts file as FIT source,=C2=A0but that file doesn=E2=80=99t appear to be incl=
uded in the commit. Would it be possible to add that file, please?</div><di=
v><br></div><div>Also, it would be more comprehensible if the documentation=
 mentions about the files to be copied in=C2=A0qcom_imgs directory. I have =
tried to use=C2=A0db845c.its as a reference for creating u-boot FIT image. =
Then, I booted it in a qualcomm sm6125 phone but the device shows the menu =
from=C2=A0qcom-phone.env.=C2=A0</div><div><br></div><div>Thank you.</div></=
div>

--000000000000ebedc8065c5395d2--
