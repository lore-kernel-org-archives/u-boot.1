Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DB1CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 698AC6071B;
	Mon, 19 Oct 2026 10:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4j7Pp6jZlbZx; Mon, 19 Oct 2026 10:27:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F5C5606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405642;
	b=SXJZ3vYBS3QkdEaHdqmgpzREu/nDsD3/TmXPUHhR2XM2i82DIcoN5Irj4vFp2xdHN9g7
	 klxxVbQ6Vu7lUs9xXE7rKP6AAs32WQGlrYQae+4Qbe92Kn8ZgJDtdnmmhe/0112cwQKQ9
	 CMoCUuZmHGwPXXTmcjvALVKtR5o/q+BLiPDzJHsu/Ly4IxI+56HrUNJkfB73S8ldoymHg
	 Bd2NxQLCYT5YeMvqNeTJtPF/c2NEB4POwzMDlvONgxTUYlD/vWS5FHMYPUi6CAki5CJRk
	 u2Lbcpq7rpK6MO02UNiZjDbf/GeT5Pc7WnO0SYsRl4vjUsS+8yp7Rd4BAhnmDrrUWqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Ka/dwQ2/p4gXvk8rdVSpr5SmKZowlIhCfGjPc8WIAw=;
	b=Twrl4t44D/EEC0l6Sr0rszT+c1ob3jiqia/7VP0BiONDplOx6u8tS7yKcghut7t5YSBE
	 1znz7wZHbWtI15W56ktN9/rGmwi8NTlCOPGYfl1+gklaoTdYPc7wbBKg7Jfu0hsZpXnG/
	 OY+4ktavYk/sQCEXcEiQfzhYiEV/gmCMisoimN+15waBCLAUn83WkX+D8FFciJaCsNX87
	 plq9XdBpvkHI8zs2Sv5v62MS+r8yRdKnDmQRILxeTB4go+3klqmYGfJNH7hUGx0wRBPWy
	 qqqEDaeRFeAqzand1bkKFBSlJfI9PRnmiv3m0YYQ/1WefDPsQxZQ996xmis8nbI8TXw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405642;
	bh=6Ka/dwQ2/p4gXvk8rdVSpr5SmKZowlIhCfGjPc8WIAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1HtQWLu4sD8fnQFTnfqB2ZH+bihYt3yj9odKFC73HiEwd90ZL5jvcqgNrUOdyexqs
	 z4LHyRCjMbCyChQPxNnkV5864ctuV2eMfl9GeqRDzarM5iq6YYvRk1j7EvGMyZfFrc
	 YuK6LobrbIUmcYmgXaxoB5tCzYUFgyOd7B++ZEVcB+YDMisrm7uRylWdobqshVlki/
	 Cs/6wlwjNfpdd5k0ZsvquQe2uf1wlhMWGdJSeHoJQMq0Ck/pN0bWhd1K8z2vxX9vS7
	 kCA/Qx6ItV9jHuFy/dO6fs5jTUA44axp/lgMAsSSyjtXWoSSuFjkk2YTWJPvjzJ3yO
	 T6uDKIQ0x+5XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F5C5606CF;
	Mon, 19 Oct 2026 10:27:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38D60279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C2274008E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2Fy3uwu8TlU for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 17BA440079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405640;
 b=S3ORWrqAsOfKD2o6SIGtOwdxNwrVqWOFStcd1m67BwkRWOErtVA8khxb4SzFbNlrlMJ8
 OJev93are+5is/U/BnFZZ2wAFkIzAQbdWKM12pGCswuzM8XsxcAQCEgR1Hxg1rZP6VnMl
 lKKx1kjdZ2XUAhPuktHutlGV02lRiZkFdiAnTSJUjiJgqJw+lh1aX/Uu8Xo1bsykNSfZF
 htuX5Q+Itl8LUHUVgOGBQnNHzarzo/PLPE+mCNUjef8cmqq2LzzjIbbdllI8umXwC7XT5
 c4ZElm0a8v0Kxq81+mJoIL7mxKS1Ikn4dvDG4u5RTMgHQWHK89HO2/GhizLwyb7HTuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405640;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=6Ka/dwQ2/p4gXvk8rdVSpr5SmKZowlIhCfGjPc8WIAw=;
 b=FrRo+9mxKCtgEHDeLSgqLKzJ14Lp66DZ7MnBvvICpWdbzuEiazVTbQP86twrOEiZQyAW
 rxqXO2utoN7yVrywF4spkbwg5+AXeoWh+4o4gHuSiJEg4FjhuCjFdq6JR894Oy+D71eoz
 tkgO3cRR7liaMDvLT0Stu7UCupQOiTgQw87Gl32UWZxPWISorL76UyRv9cxn3UccACeOT
 2ifTJ0So2reZ6V6YlfMpN5+VzGmGRPtjrhobo4RNT0V7qCa8ksYdOyTcNC8LfDIrkGBtm
 zvq3WTTjjQeykVHKYioLjfQW3Bc2uYcjrj3UBDhxCvnHfDHkIxXV5cQRVCfDHBC86CA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HsVu6ndR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NELUvjUU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HsVu6ndR; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NELUvjUU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17BA440079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P2xZ3306589
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Ka/dwQ2/p4gXvk8rdVSpr5SmKZowlIhCfGjPc8WIAw=; b=HsVu6ndRdhXxrdDN
 zf8pncdK6PYX9z1fP/QQQDT+Rb/if7+WmC/M/lUu0Ja1CA+a8X8O5wyXCvohKZ0b
 /MShaW8LcHI48SKwVojPV6G1tOsTTsM9UjUmw37UJ0Bt8A7PEqVTHZs3cBKRtGj6
 26u4fQib27UxuG/OOijq2v5zNg3voXVh+hZ+uh/GLu+DtezFAA3vP0I3i/Btd73n
 0rlAxKOLl1d8hjSynYnOyVhjKXBqkODi17neYkdw7OpdE4pasNvvEh2F7AwB+NUl
 JR0BNvpAkVnZrNMmfTTF3JwFZwJHaXk0aLgRgfm+3pGQ5Px+R4Xc5ZCB/Ie8KJmw
 P+F4XQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47gm1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:18 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b0d9789e84so23352727b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405638; cv=none;
 d=google.com; s=arc-20260327;
 b=mv6bWFs9YvdquVLwjd9pA5SZjpxQz47zGCBJFz0WKo3rlZWmf5M7hCF6s+trj5zn20
 MVwmYBq1o0rc4ff0YbFvEMobgRExbNuQki8AKuB71uy8m+2eH9FSS9E8MtkTUd7HyZtW
 cX/unzBODOVkehp83/fU+bDSh8X53UFlv3CMzbW4dlgGn9C9sTNE4/9ESD4+AgYsQUPO
 sa4IARybhUzq/Et/Xwf6UuXg55xLGArWjO7SOyDyeNn3IBZmTRpNiijTVPgXVwADwz5u
 q7zdTVQwHdvJJ+oUWP/zsY0f7PyVxHcYh3ONnmc2ZVLBngUgMoKXs0lSpD6K6W0CVnqy
 LETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Ka/dwQ2/p4gXvk8rdVSpr5SmKZowlIhCfGjPc8WIAw=;
 fh=zkzlReIAwMqSEbh0pEy+EpQLkqJY9ht1M1DIGnDHOO0=;
 b=d5jQRb8SgMkLOTOigrhVYZVQqsWm3IObMdrApdog10GID3PYcTUeSDR/XfP5n6Q7i4
 hyulDqEW3ppBWZZ9dn0FX9h59HGcLZm68sBuhxpZ/G1Ad2zCLOziL8A8q1ecUvqDTYHY
 +KTSehJfCGLX/UdXQnPwPhtW1Wuci7svT9fBou+JqeNyNcn6L+qFvK6kej6o0tT9SvfH
 4l9Xzw5tuAl6fQNlgMrgOL8xWXtzkHkPbYs4wnkjWI/BS6cEOOxX0TRJ5ruSVckt7bPS
 wjnJafzHCUbuOws900O1am5MKAeU0eJ/YfP1fp7u4knEizELhq1dC+mfSVBynXXemX1n
 EFXQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405638; x=1793010438;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Ka/dwQ2/p4gXvk8rdVSpr5SmKZowlIhCfGjPc8WIAw=;
 b=NELUvjUUAsQeIiOwqOAZyb1Et6xZot2BEXWJvzPovCZFkjt4HA6ZzC1yv9cjnrSPqc
 2jjSkLYczZSR5OYGNooQNPkaiPeZIKCDpNrAiqG2m/i+ZtvwIzrrC/tJSnqFfY2NwU6u
 u3zzRruz0mewhTkDeigu3Re1aXN5VaG8z/PYE4KkdCceYC1mEKqc8VDSBpm1dEywbAcM
 kkUZaDvEOEB2bKGyU9iuSDL+nUOYz7zK3Jmhq8CmiV6lJdgnfKhU2lSlfw7q//e1YCRy
 oV3nOrzJJqE4SZMOQY5V0gnwF5zA58tPSbRULyPkhFxzD+JONKQxXdhyeZSzVGKa+pdB
 HpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405638; x=1793010438;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Ka/dwQ2/p4gXvk8rdVSpr5SmKZowlIhCfGjPc8WIAw=;
 b=Iqb1r+0XGNKn8BTSVsZVTYuln0d9KMNbS8rEIhRDrn6XIEx1Om9z8fFRZrmkTaJFVI
 NrgGWe8HlFnZ9Su9+TYVJNADjEjNNKD73zmDK9eNMeoWXfF+hkSZwHzN+k9yBhBkhYQ5
 +nX2YdFABT3vnLw9r+C3wmztrjckI5VW23vPPEMh+5TnoibYfk1oRx+vWAiWqfkoAi8q
 v3b8CqbKSLAxU9mC84/QPk1eZlAAkjwitwRbMyiKZ0BYh4vvjDUc9saK/+wMSs2G1AnV
 DJdB0rby5K/41fKTySZygt7vsEIClqlxhe90z1a1k130lLjhynXjdC6/SHMSbt/aZVpH
 IXvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtcYlIXZD7qN4tXn7MsB9ItRsSy94M6npD85qjaXiDH61AhF7Qu4AjLdCFlKQTvnXO4tuwWYo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLM2X/mh4j6spxJKq7o4NgHzQY9aRrD0FM60VB5S+mtG79KIZ5X
 p2q2bFcYNpf/6rKKk/5A0KtU3B66/wEtKP90M4a8LBOqDqnpue43q7cnKerlANYl3jiaSIkOoGu
 OWYmdsS5SzlADXfIqcnd1BL4uDf6PbFtFzwybqk4y4ZlD5FSZokK9cRb5sD35TOiLRVeOV5gCu0
 2e0fpcurYJopmifmtSeDvPhFTBBXpoLpjy9PZntEkchZdY2g==
X-Gm-Gg: AYBFou3Wq9MhbesX1pSUqLWmSxHpZKpJUifeXokutWfI7hLUC2kHkkyqV/jRFPgEyuW
 kVfR7EwjiL4i3h8lksqiTFVMuPHLRCr9es2NngTdVv7op93Fd5MIrqbhCn+DzZVtyI0ilf1Id5C
 rVpJWf0isQTevD7pYZG/HqSIqW5rOU4E1ypqGquWL4T2aTFkfuDEAk279jXg==
X-Received: by 2002:a05:690e:168b:b0:678:3418:8cf7 with SMTP id
 956f58d0204a3-679ca7c9b6bmr2349359d50.45.1792405637958; 
 Mon, 19 Oct 2026 03:27:17 -0700 (PDT)
X-Received: by 2002:a05:690e:168b:b0:678:3418:8cf7 with SMTP id
 956f58d0204a3-679ca7c9b6bmr2349350d50.45.1792405637465; Mon, 19 Oct 2026
 03:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-2-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-2-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:27:05 +0200
X-Gm-Features: AclHuK-VL6L_SudFz8kFOdrx5BTAvCOFiZ1U3cjXb_F7gHl3mr5HdfVmlZDUCq8
Message-ID: <CAPzfCAa4L_MkQUSausVB6WgR9X1EKa6JQ9WzYUHAs2bRTPGQyQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] test/py: android: Move android image creation to a
 dedicated file
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: CAaWm4tPIc0b5Zrodms7bHD9zWBWowJD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX9V2j6fooPSii
 Md3Gqsjxzy2uZBlp65x0BAH/CWaHZLSxLZW11Peh25NvhWrGeA41OVTUcBnYXtRelJvKtO/HROR
 w2GRkLkrYLTBVKijuXxPfOKQvzSQXGa0E+XpZ+Sjb22dqDgL2fuDo4ELRYUTHrWabHkjHDe8c1B
 pJWcKuLgBFoAkDgWV2ib2W+0XYaxyCkG482JuJ8F+pDRSK2jjS0mSiWYa/2LM1yOy2SWh3XlyEy
 NpJ1AuLXr+a8FsrZxTu+Pa9S/4U8oJBGrf0GkhhmG4lGeQQKLLojYjx2NLuSHNNCTkVwGKrIcbb
 r6yLzr/qch2hvdeqYwWus5KAUA6zpt+wNQLlMMYiXEBuiO0OKlAsSTCZfBRb3RzDvoZbxgBKQQl
 LLQAN8n50yxTdp1snexYOrANBYo93zVbJGq7+9yfGfyB7/L+DuPWJIV+jnGLtxeWQjhgm1+jH4r
 VioSuT1yRApGvpRlluQ==
X-Proofpoint-GUID: CAaWm4tPIc0b5Zrodms7bHD9zWBWowJD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfXzK5xOhokq1Pi
 XwNxBLn9FIq4bgESbbJoeSKwyBjo7khRMig+7+GP3Qihy90wGnDbsSUoE6n1sFIQ/N7/1+UQ9D8
 DO/a/zC/TPBKBzLNh66SVMXg9J678FU=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad5f087 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=nCj4xIw15fhI_VYpOXYA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190041
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

Hi Mattijs,

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> The image creation code in test_ut is huge and difficult to follow.
> The android part contain code duplications when making mmc7.img/mmc8.img.
>
> To prepare some code refactoring, move the Android specific bits into a
> dedicated file under test_android/.
>
> No functional change.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  test/py/tests/test_android/android_image.py | 135 ++++++++++++++++++++++=
++++++
>  test/py/tests/test_ut.py                    | 129 +---------------------=
----
>  2 files changed, 136 insertions(+), 128 deletions(-)
>
> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/=
test_android/android_image.py
> new file mode 100644
> index 000000000000..3bea311586bf
> --- /dev/null
> +++ b/test/py/tests/test_android/android_image.py
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: GPL-2.0
> +"""Helpers to create Android disk images for sandbox testing."""
> +
> +import collections
> +import os
> +
> +import utils
> +from test_android import test_abootimg
> +
> +def setup_android_image(ubman):
> +    """Create a 20MB disk image with Android partitions"""
> +    Partition =3D collections.namedtuple('part', 'start,size,name')
> +    parts =3D {}
> +    disk_data =3D None
> +
> +    def set_part_data(partnum, data):
> +        """Set the contents of a disk partition
> +
> +        This updates disk_data by putting data in the right place
> +
> +        Args:
> +            partnum (int): Partition number to set
> +            data (bytes): Data for that partition
> +        """
> +        nonlocal disk_data
> +
> +        start =3D parts[partnum].start * sect_size
> +        disk_data =3D disk_data[:start] + data + disk_data[start + len(d=
ata):]
> +
> +    mmc_dev =3D 7
> +    fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> +    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> +    utils.run_and_log(ubman, f'cgpt create {fname}')
> +
> +    ptr =3D 40
> +
> +    # Number of sectors in 1MB
> +    sect_size =3D 512
> +    sect_1mb =3D (1 << 20) // sect_size
> +
> +    required_parts =3D [
> +        {'num': 1, 'label':'misc', 'size': '1M'},
> +        {'num': 2, 'label':'boot_a', 'size': '4M'},
> +        {'num': 3, 'label':'boot_b', 'size': '4M'},
> +        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
> +        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
> +    ]
> +
> +    for part in required_parts:
> +        size_str =3D part['size']
> +        if 'M' in size_str:
> +            size =3D int(size_str[:-1]) * sect_1mb
> +        else:
> +            size =3D int(size_str)
> +        utils.run_and_log(
> +            ubman,
> +            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['lab=
el']} -t basicdata {fname}")
> +        ptr +=3D size
> +
> +    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
> +    out =3D utils.run_and_log(ubman, f'cgpt show -q {fname}')
> +
> +    # Create a dict (indexed by partition number) containing the above i=
nfo
> +    for line in out.splitlines():
> +        start, size, num, name =3D line.split(maxsplit=3D3)
> +        parts[int(num)] =3D Partition(int(start), int(size), name)
> +
> +    with open(fname, 'rb') as inf:
> +        disk_data =3D inf.read()
> +
> +    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abooti=
mg.boot_img_hex)
> +    boot_img =3D os.path.join(ubman.config.result_dir, 'bootv4.img')
> +    with open(boot_img, 'rb') as inf:
> +        set_part_data(2, inf.read())
> +
> +    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_a=
bootimg.vboot_img_hex)
> +    vendor_boot_img =3D os.path.join(ubman.config.result_dir, 'vendor_bo=
ot.img')
> +    with open(vendor_boot_img, 'rb') as inf:
> +        set_part_data(4, inf.read())
> +
> +    with open(fname, 'wb') as outf:
> +        outf.write(disk_data)
> +
> +    print(f'wrote to {fname}')
> +
> +    mmc_dev =3D 8
> +    fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> +    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> +    utils.run_and_log(ubman, f'cgpt create {fname}')
> +
> +    ptr =3D 40
> +
> +    # Number of sectors in 1MB
> +    sect_size =3D 512
> +    sect_1mb =3D (1 << 20) // sect_size
> +
> +    required_parts =3D [
> +        {'num': 1, 'label':'misc', 'size': '1M'},
> +        {'num': 2, 'label':'boot_a', 'size': '4M'},
> +        {'num': 3, 'label':'boot_b', 'size': '4M'},
> +    ]
> +
> +    for part in required_parts:
> +        size_str =3D part['size']
> +        if 'M' in size_str:
> +            size =3D int(size_str[:-1]) * sect_1mb
> +        else:
> +            size =3D int(size_str)
> +        utils.run_and_log(
> +            ubman,
> +            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['lab=
el']} -t basicdata {fname}")
> +        ptr +=3D size
> +
> +    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
> +    out =3D utils.run_and_log(ubman, f'cgpt show -q {fname}')
> +
> +    # Create a dict (indexed by partition number) containing the above i=
nfo
> +    for line in out.splitlines():
> +        start, size, num, name =3D line.split(maxsplit=3D3)
> +        parts[int(num)] =3D Partition(int(start), int(size), name)
> +
> +    with open(fname, 'rb') as inf:
> +        disk_data =3D inf.read()
> +
> +    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg=
.img_hex)
> +    boot_img =3D os.path.join(ubman.config.result_dir, 'boot.img')
> +    with open(boot_img, 'rb') as inf:
> +        set_part_data(2, inf.read())
> +
> +    with open(fname, 'wb') as outf:
> +        outf.write(disk_data)
> +
> +    print(f'wrote to {fname}')
> +
> +    return fname
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index 2a5acc18c612..c1b5bc056023 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -19,7 +19,7 @@ import utils
>  # pylint: disable=3DE0611
>  from tests import fs_helper
>  from fs_helper import DiskHelper, FsHelper
> -from test_android import test_abootimg
> +from test_android.android_image import setup_android_image
>
>  def mkdir_cond(dirname):
>      """Create a directory if it doesn't already exist
> @@ -506,133 +506,6 @@ def setup_cros_image(ubman):
>
>      return fname
>
> -def setup_android_image(ubman):
> -    """Create a 20MB disk image with Android partitions"""
> -    Partition =3D collections.namedtuple('part', 'start,size,name')
> -    parts =3D {}
> -    disk_data =3D None
> -
> -    def set_part_data(partnum, data):
> -        """Set the contents of a disk partition
> -
> -        This updates disk_data by putting data in the right place
> -
> -        Args:
> -            partnum (int): Partition number to set
> -            data (bytes): Data for that partition
> -        """
> -        nonlocal disk_data
> -
> -        start =3D parts[partnum].start * sect_size
> -        disk_data =3D disk_data[:start] + data + disk_data[start + len(d=
ata):]
> -
> -    mmc_dev =3D 7
> -    fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> -    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> -    utils.run_and_log(ubman, f'cgpt create {fname}')
> -
> -    ptr =3D 40
> -
> -    # Number of sectors in 1MB
> -    sect_size =3D 512
> -    sect_1mb =3D (1 << 20) // sect_size
> -
> -    required_parts =3D [
> -        {'num': 1, 'label':'misc', 'size': '1M'},
> -        {'num': 2, 'label':'boot_a', 'size': '4M'},
> -        {'num': 3, 'label':'boot_b', 'size': '4M'},
> -        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
> -        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
> -    ]
> -
> -    for part in required_parts:
> -        size_str =3D part['size']
> -        if 'M' in size_str:
> -            size =3D int(size_str[:-1]) * sect_1mb
> -        else:
> -            size =3D int(size_str)
> -        utils.run_and_log(
> -            ubman,
> -            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['lab=
el']} -t basicdata {fname}")
> -        ptr +=3D size
> -
> -    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
> -    out =3D utils.run_and_log(ubman, f'cgpt show -q {fname}')
> -
> -    # Create a dict (indexed by partition number) containing the above i=
nfo
> -    for line in out.splitlines():
> -        start, size, num, name =3D line.split(maxsplit=3D3)
> -        parts[int(num)] =3D Partition(int(start), int(size), name)
> -
> -    with open(fname, 'rb') as inf:
> -        disk_data =3D inf.read()
> -
> -    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abooti=
mg.boot_img_hex)
> -    boot_img =3D os.path.join(ubman.config.result_dir, 'bootv4.img')
> -    with open(boot_img, 'rb') as inf:
> -        set_part_data(2, inf.read())
> -
> -    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_a=
bootimg.vboot_img_hex)
> -    vendor_boot_img =3D os.path.join(ubman.config.result_dir, 'vendor_bo=
ot.img')
> -    with open(vendor_boot_img, 'rb') as inf:
> -        set_part_data(4, inf.read())
> -
> -    with open(fname, 'wb') as outf:
> -        outf.write(disk_data)
> -
> -    print(f'wrote to {fname}')
> -
> -    mmc_dev =3D 8
> -    fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> -    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> -    utils.run_and_log(ubman, f'cgpt create {fname}')
> -
> -    ptr =3D 40
> -
> -    # Number of sectors in 1MB
> -    sect_size =3D 512
> -    sect_1mb =3D (1 << 20) // sect_size
> -
> -    required_parts =3D [
> -        {'num': 1, 'label':'misc', 'size': '1M'},
> -        {'num': 2, 'label':'boot_a', 'size': '4M'},
> -        {'num': 3, 'label':'boot_b', 'size': '4M'},
> -    ]
> -
> -    for part in required_parts:
> -        size_str =3D part['size']
> -        if 'M' in size_str:
> -            size =3D int(size_str[:-1]) * sect_1mb
> -        else:
> -            size =3D int(size_str)
> -        utils.run_and_log(
> -            ubman,
> -            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['lab=
el']} -t basicdata {fname}")
> -        ptr +=3D size
> -
> -    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
> -    out =3D utils.run_and_log(ubman, f'cgpt show -q {fname}')
> -
> -    # Create a dict (indexed by partition number) containing the above i=
nfo
> -    for line in out.splitlines():
> -        start, size, num, name =3D line.split(maxsplit=3D3)
> -        parts[int(num)] =3D Partition(int(start), int(size), name)
> -
> -    with open(fname, 'rb') as inf:
> -        disk_data =3D inf.read()
> -
> -    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg=
.img_hex)
> -    boot_img =3D os.path.join(ubman.config.result_dir, 'boot.img')
> -    with open(boot_img, 'rb') as inf:
> -        set_part_data(2, inf.read())
> -
> -    with open(fname, 'wb') as outf:
> -        outf.write(disk_data)
> -
> -    print(f'wrote to {fname}')
> -
> -    return fname
> -
>  def setup_cedit_file(ubman):
>      """Set up a .dtb file for use with testing expo and configuration ed=
itor"""
>      infname =3D os.path.join(ubman.config.source_dir,
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
