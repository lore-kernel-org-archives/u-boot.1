Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE6CC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEEAE810F1;
	Thu,  3 Sep 2026 14:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1N8QqPQsHoeS; Thu,  3 Sep 2026 14:33:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 81A8E80DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445981;
	b=n8Y88lzDBbCdMPu94XoP/MD/N2gj8FTWBFtUXaN4OLPzWrBm5VDjdWWmEnoqURN3j5Cy
	 ZjK8AGN+XsmFr6UL3af2+oWBAsyq8YgOn5t1EZm2MyEmUFB5G2MPh8oCeceYfirFx3Qwc
	 6lFj7oXULoU81aOdg165a7mA1bi3hZ97u4RBMEnMqxuxmeBxHWUPAQnZQP+zxAMCV4wwO
	 1Rb8Zboo0NQqtoMT/MEEWVEOuLpMlFbhVOx6pLCwdDWMXR18hG9euhSuqtgSq6OFkCtCh
	 S1TNGnqpT+mUbS6Zf3o0E7XctH6wRraqVg6QZB5/y1S/OVFKB+9rGahGlZeIe2Za1FA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788445981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=prVCGQMmFQIdkR1Wio7jYd8np8Yv8LIJ6kKbSs66zaA=;
	b=Mg5ylSB+GrOTOI/TkL742EkAHuO/a//CoOJOB6tlP863xLxcxIvywGumrYFD/TJtWXyN
	 rkfvBjDetMAwpUk+iNBxY90yW6M3DPvvyorm4/vj/Wt8XmqEGPuoi+mTp/4MKXxj/V2ib
	 vLPskdRq08iCcTS8W5Ye/vu2SPRfUVq9Ra1FDa7XwgQkLkB8Od+Ux8yMN36gBJH07HYxy
	 XOfvWJFaxhiYma0HtAJ5TJGThmlXJ5N2eZgXt3XR7iUYJlvKRn9V5kQEE36PJba2SpHQC
	 cPYnAx87Coq0C+vYeUSqwbfBEpFVJHBrPAPE3bSpTKI0CZCnEXyPP9UlU/GKVMl/eDQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788445981;
	bh=prVCGQMmFQIdkR1Wio7jYd8np8Yv8LIJ6kKbSs66zaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0XDnA5yz7Mzq+VwnVUQCBPqzxYSPPr+SDJu3IOXrTaJlc1+1a1Q+bdv3qqA6TyQW
	 eYgab/U6L3CaihtNQvgZN7d3m0H/+PzyOLyvfNQDdICm0jFFWVWGmEIFY1b0A/eEB6
	 mtcKkJTSAiqjcczzrabhZPs0NSJ1izq5M4abK6lQF4Qpn9XsyouLGcnqU/hKWTYWsN
	 xDCpguw7UeWYnFSg6J3+p6N+L1o0EHOdYryCzP6+aCeahI1iV7Oq1fHoVXUj0CVtzP
	 JrFsubycrqOZifWPZqm2m8i6GtkNXrqx+VMXn735V/3cFOvh2hhN0j/Kx9SCsZGwMw
	 C+8pAQuZXFJdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81A8E80DFA;
	Thu,  3 Sep 2026 14:33:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6347B34E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6044540462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id knDslZo79AWy for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0361D40454
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e2d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445976;
 b=PNlf5CEqGJvKoQgOC3+cRKd1Ok9oRgQ7+O2cITW+ZOOE5cqFD6jv5WzhpNvy69v6aPkM
 z46odrBGkGW5dstOqSCDftYQ9N7FEzOk+Bq8AGywmJkV1J/e3hFo/T4a7rMHEfNRt2b+t
 GVemqprJerZLD/d8ZqW8rVDt14S36H9zF4bXPM9pwpVOSYtNrrpBtcXWQ9dSwHDqJFV2E
 46RwAnQNy92QP6iLmlFIewmONtltcaDel/m9oufmdRwgL4hrjUzEjou7BRNZU53IaeHj+
 ZyWgCYwOncEhk8KDbHqIdi4ub6YFXGxQvXwDEsHI6YThbRPXWOd5Dr4JNZbktZUfeWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788445976;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=prVCGQMmFQIdkR1Wio7jYd8np8Yv8LIJ6kKbSs66zaA=;
 b=RcZKpbyLTC3rEmmBNlgGnGh1t2XyybRYTIaCE4lWb2/FN+MdwZKvNlVdr2rrAoK1UaMS
 5gDnDGbYStnccfvE4HBeuki0UGg/NXNfGvNnUfKnmAe2sWu5+v2y/CkYv19hH6QUlcC0F
 NAqyqFSVsz5veFoIQZV194MtCQrKRjvSwA15IdDA+NRhQqbFmzOw8I7Ek3mwaLOczItdW
 DmD2R4ujAe4cZdWaLkWcavq/pZApCY7FcdFVZNm6ttP4d2f6J6VBSyLc7d48wlN3hiE6E
 9zwFq1jFpsE0ZUZ3MftvGv+8gVvc6/U1fkyekbH/tImKEF8W3kvgNkA632KES26LX9A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=V8XEkKkN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::e2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=V8XEkKkN
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0361D40454
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:32:55 +0000 (UTC)
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-782e0fc1e55so961521137.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788445974; cv=none;
 d=google.com; s=arc-20260327;
 b=B9RXxj8m9Zw9ziDBom69pG8OltEMkZOTvw0wNEqAF8oAVzPzfnwI92wHb2L8NgyNK1
 ASHY9MTvlkEgi+XtkghmiRMECcnzUkUqzIZhiVAZF++2gnXgd1//OVMcHE30crxoy7uR
 315kRUhGoEOmKrJ4+HWZNMm5qqU9OQuQnyghdJ+62lIOiSAhrev6aGHS5cSUrnvBLTFC
 C6+TitpSxeb/YO+lXZDGfncMWVxfaqKgkAHLK5f+eyigoa9PZ7LE+5otMqsPi1Q6fLxP
 dWZbCt0dbN/n/EWuhU86jaKe4Mbr/2tCN16+dFKHeFOVUbl9Ad+6eoV79S1aTc7XodJS
 quyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=prVCGQMmFQIdkR1Wio7jYd8np8Yv8LIJ6kKbSs66zaA=;
 fh=n3e9LofUo98w14q5uByLvvjCHWRWrYVCOJfZ25KjRzU=;
 b=YKLtcodptedd9Kn+yoBAJFikXMRMPOjZ1Vkcc3EfsY/GmIFwTLZH121+FMoIcPTy/+
 sqCiXijW1IhlZtB/rp710d9JK2vWld3qGy5B267qcFKSq0EiDTPUXfbqtgJ7M+e/LVIe
 Z+ohs6mwWQ5yCMTn6PYgtoRc/TwE9ySXr9JhAu7VUekzGpF+CiTbxqJyyssPsz+7jeND
 Qmmsab1SO1/FEZbwQwyHwIHnooHaSKR7BDoGeoqKfKTIo2P0U8ZdQXjTXwTSbnxwROdX
 BsoH7RvJPo0W09EfDVgbWX0renXMfXQFrO5jt+J/QRNWYabWq2/jc3lmqIDdjekgshmE
 VzpA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788445974; x=1789050774;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=prVCGQMmFQIdkR1Wio7jYd8np8Yv8LIJ6kKbSs66zaA=;
 b=V8XEkKkN9Z+KTGZAkc+C7zL/tiRZlUwLZPpQe6F955vFykXL397sHsFk7507ySe9x6
 UDGLXzNArZmH0eMMr6QTOezlHIw4vHbv91I4S2gZF7tk1Sk0qYLQ4KaQ3eo3hLmfhamz
 iSW0ulDzJw82Ec4YLECBtC/pmS0JPLRpqYeU1nQ912o4Vzk/sv7V5hXvm6EdBzZz2E6w
 FlL+x0lpDCAwI6PR+ZKQoUyCiu/n3kxqIvzuzuaomR4kxIDD+cujkSaT2q96t1Da1ewt
 Im0DRlQCKkj6bnFGGE+2iu2OneDs/SxR5X9qCzt0ScCFvAjueeW+NvO8IROGPepjBTRm
 JhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445974; x=1789050774;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=prVCGQMmFQIdkR1Wio7jYd8np8Yv8LIJ6kKbSs66zaA=;
 b=PlX41XqW6aIulTpwzmKpD8XtdN+eMitPj0pc9rGnqV7xRwGjaaoHcN1LtdOlyLHPGZ
 R3ZkqI2OdgIkPEuAv1WVryf8NCdkJd6vkljiTE9SKuDWBJ1Kct57QdEE9xBlRpZOEfAI
 bXOjg/cQyq7nZLW2Z2xooII3Fgw9fze4Kb28o99HSoZuHxscWXfbbtZfD2qMyroiZ739
 MCogfV3GqhZBNnKlq+wGs1E5IRAbbGGBZRO9m77aGWRtr5Na70breHRQRZ6nKrtCJ564
 FQbn6QWeLATY+dVOcGSPHJM8afw18uwBqQZiaOzOF8JOcFQjo2wLZlyk5rKFHt/ATPYG
 pmjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxedvHq0egqnoJWDarDpvln5FLb5GiekJOx0vie8Ppq7nGIVcISP7u/SGXTwfz26/Wx+jWQNh4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lNz2nHRqUmUUKHo4GM0JKH8HPQPyuV3Z/0zIq7+125hhCDb/0Y
 cSMSVg8AlEYbAgcEBdcWdsickHIKGW445jsAVkyM3sq5m8nE5AvhTBglJrpgUnCsvYnH7lfwC5G
 aJgTE6bflKXoSeibPQN8U20yV/bMAReA=
X-Gm-Gg: AYBFou3xgHnh3vG+X42FU8iLxnGdLagPfuu3lkd4XVtUjdqHI1Fk94oq/fcX3an0daP
 CCTlBukHrN4/sCPjEOAHgN6hdDPx4VcNK/JCQhM5Qzk3LXbUIWK+bJQ8mwOvb/jvCdIKrUvSKKN
 qKkvK2fyJVm38A/8KuPSEAKMj6qQfxP0KhMj4sXtkP13ZRtxmFB0dXBaw9hBzqwIyVFIrvo16GJ
 D+0ZaMaK4WsdOEOC+oqdtKhC8VXqdr+9o1asQZ1E/G3aD83V/oWVDv7zSGEmqGeOUEjnWwSCZLY
 5OpWx0/7CxCAaCMm7D2MGM45ykPo7p6HY6gJnif9Qc2V/1DTuTmSPf35u4KxPiUinK0FUA==
X-Received: by 2002:a05:6102:6d2:b0:785:76cd:ce88 with SMTP id
 ada2fe7eead31-78a1f1576d3mr3973427137.3.1788445974081; Thu, 03 Sep 2026
 07:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-6-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:32:41 -0400
X-Gm-Features: AcwNN1W_bqJELe4ITsB4n9JcgX1fpe2vGCLR-APStlxpM-FDiXlQGfLDNC4eZMU
Message-ID: <CAMDkj5yhVhSZtV4z+=Vy1qdTO9zh5p66UyM0QsGNnFA7xOkxPw@mail.gmail.com>
Subject: Re: [PATCH v9 05/15] drivers: crypto: add software ecdsa support
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
> Add a software ecdsa driver so it is
> now possible to use ecdsa signature on
> board without ecdsa hardware support.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - no change
> v3:
> - add depends on ECDSA_VERIFY to ECDSA_SW
> - change sw_ecdsa_verify to ecdsa_hash_verify
> - v4
> - use ECDSA_MBEDTLS to build the driver
> - clean include (change order)
> v5:
> - use $(PHASE_) in the Makefile for the driver
> v6:
> - remove include u-boot/ecdsa.h from ecdsa-sw.c
> v7:
> - no change
> v8:
> - no change
> v9:
> - no change
>
>  drivers/crypto/Makefile         |  1 +
>  drivers/crypto/ecdsa/Makefile   |  6 ++++++
>  drivers/crypto/ecdsa/ecdsa-sw.c | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>  create mode 100644 drivers/crypto/ecdsa/Makefile
>  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index e4a4482b7f3..8170e4cae9c 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -4,6 +4,7 @@
>  #      http://www.samsung.com
>
>  obj-$(CONFIG_EXYNOS_ACE_SHA)   +=3D ace_sha.o
> +obj-$(CONFIG_ECDSA) +=3D ecdsa/
>  obj-y +=3D aes/
>  obj-y +=3D rsa_mod_exp/
>  obj-y +=3D fsl/
> diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefil=
e
> new file mode 100644
> index 00000000000..89be50824cb
> --- /dev/null
> +++ b/drivers/crypto/ecdsa/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> +#
> +
> +obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) +=3D ecdsa-sw.o
> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa=
-sw.c
> new file mode 100644
> index 00000000000..2af1405f73b
> --- /dev/null
> +++ b/drivers/crypto/ecdsa/ecdsa-sw.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +#include <crypto/ecdsa-uclass.h>
> +#include <crypto/internal/ecdsa.h>
> +#include <dm.h>
> +#include <linux/types.h>
> +
> +static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
> +                              const struct ecdsa_public_key *pubkey,
> +                              const void *hash, size_t hash_len,
> +                              const void *signature, size_t sig_len)
> +{
> +       return ecdsa_hash_verify(pubkey, hash, hash_len, signature, sig_l=
en);
> +}
> +
> +static const struct ecdsa_ops sw_ecdsa_ops =3D {
> +       .verify =3D ops_sw_ecdsa_verify,
> +};
> +
> +U_BOOT_DRIVER(sw_ecdsa) =3D {
> +       .name   =3D "sw_ecdsa",
> +       .id     =3D UCLASS_ECDSA,
> +       .ops    =3D &sw_ecdsa_ops,
> +       .flags  =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRVINFO(sw_ecdsa) =3D {
> +       .name =3D "sw_ecdsa",
> +};
> +
> --
> 2.43.0
>
