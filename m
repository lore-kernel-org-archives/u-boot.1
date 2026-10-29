Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A3606A32D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kgluo7Zi;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nenQtx8R;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KPbtt3Hq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4E1B81008;
	Thu, 29 Oct 2026 10:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fJlNBz4ZsPo; Thu, 29 Oct 2026 10:58:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3F2E81061
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271495;
	b=beA3TksmC+CQ9xJOnTGLJ8DfXzRoX8EnblOagVKLIFp1CUDX+sssCXKGtTIdjyL4Byqh
	 ZU6cHu4Uvs/UoYE0xYSyb6mSBt4XM3eNrBZAEDZfRtbw3BW8UFtq79H+DV7dh6+WAfLiN
	 F5RrRzURoSqX1GkEIc7o8zNVGJvLF4M68FnUMBoIvu/KI2hDu5FJf4TJOWgwGVFvNroNt
	 LonNXCgKlVu2G2oImM91hOvKU9jimcrEWiY5+xtKNuoy1fLz1VgVClr14mFoiLNe38mL/
	 YVbpp2Spsuj+hEKt1+au7xei7F/npJlF3eyxKDqFPnGlvqR9hn8zx/UFSigjFdhHAEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	b=TiiV6agtnvS0pKbd4pRGE+zBw/pWpfJaxQTPDeXw15z3GFG3vqLFbhZlCtNIuCcsTus0
	 lG4v8Thp/+Uw+GT5l5HPgc3t8RVgK74Ty/YEnGMl1K2KpT6GYjMdXlhjOB4vyIEXafA9w
	 pgDG9CAHIh5mrdy0Vuujd5Q3RmYWmF2OVjSqE+DvkttU+v+L6pWManDAJdgsynhQa+EAe
	 oviEsdc6dWb6DPuGH6eEIJLSyiOEXCrw/WGoUR8MZaeSiGQUUZ8fC2DXFVZ8HK8UpROSm
	 lc3RDhBCSpBCY56XrWc1d5yQlaJxruT+uGz0lLeXFcn164Da4Nu6rnVb7+FNhj4aAvg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271495;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kgluo7ZiKduFskPfbtA+8eo6xL4i46N8yAFnBaNE859kjiwaXjM+0giy/loqqQbHd
	 HcRW5K7Y6wHTMU7G9nVMWZgbc4xHOV18PGLzc7Qf2VJULb0Bmi4NjwyH0psnpldEs6
	 Y/fkNkrO0Hw3JGf6uqbcM3r6KucOytMbShv9E6h1OrAeUhbJXwQ+6PKcNAT90J9Llq
	 ySLZobAwlmlZVlVD7sGl1Jf8NxIU7evlNYOtj7zzHN+w2yqbK22ciLEl/HmNdZKDNZ
	 Yz/MU49yybKYKiPs8ethnGZcLfSjFe3dcx9Ge3bC8NTqzBbd16RaYHABTy3BI4vOB7
	 yRL9fkPoP45iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3F2E81061;
	Thu, 29 Oct 2026 10:58:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FEAF1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 144134032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgFwUjTY6Joh for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6CB5140024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271482;
 b=fxIr9XS4rvMsXIDF4tpkr++ufpT88/QYD9nPSrZq6acqt1bIbHObxdTLqzU44Lf7rPlA
 6pmB7KL0XPGwPfVFbO4vvUcP77Yv5yzC5MMl6U8I+LsH6esyGIuymWkbr/IUj1dhf+1fC
 0x+BtS3zOWGWcuF7Lc5U60kJ6d3RemT8v0cOU0RUYDUjBGjkw/GIsfcmW25gXHgeJbW5A
 nw5ZnpvtbdoL0ZIO0XYzhsWuIVu/rKTjR/9elyS8qi7vAtRXp3OZpXwdVmhSUr6SY1+nI
 8lZWrdqQ71wZBne+oCQ2QbTZirlz65u3tA8Mz1ALswknuQRaDYBP7VNVMwDfMOafNkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271482;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=DIWDqpEZ8gbUx7Fne01OIsXSvoWu/JShiPPqdFmgoQiLBq4AkMpkxDMTxxUcuueDBtd2
 NeC76lP7JPuUrbj796wSr86KutFNroDF3p0mavdfV0l0SffBuIW1L5Kbg9Aw0C80K2nKk
 K7inm4HViuKM5Gnu2qTDTGdGxOIytZGsP5d0TljZND+LgY/e4B9dv1RlVrob4ESBVn951
 7RrCrNpWuaZBHpeDG2UtpjktigN85UjC0xN62FZ+ZA7fa8KhHdNfv6rrYgwHAVUWm8Hnd
 DSSNKoX4+Y4KzX78pFXaR0MFE9Tce1XYCcYqPPE4GgsoFn7Kcs88Wwsi3Q7Mg2qg0/g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nenQtx8R; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KPbtt3Hq; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nenQtx8R; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KPbtt3Hq
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CB5140024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TA8bXq821566
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MKOaeljaoXm
 S4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=; b=nenQtx8RhjDTV5z0J/9Zyl6+fq2
 wn/onzDMLu3glZA7LHOpHJxQt9bCE+hVRx4/4abPLkv5JxlBy+9H69tmdYlEpI1+
 QvULrH1wbeoxvio1f4ARWd/yrmfzdaDSzxJfD76eViIjLjzmwNXd93wLazRBS086
 6AzrleiH4UktrtHSeflKWBvCAzl24XB4NzINbGwhXxu2VrBDusRi1ghe2ZH3i4gA
 HQifAZWbrjMBoGas5s/eFMDBu8ew9ILSLh7iHR+EIo61gL1xTqOlklES5FsRrJbM
 FWp8iWhlx/rI7tQ+ekxyLpucV0a//adVRZVxN73900qrRHnZaHhSg+/T82Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q85gx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3710975eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271481; x=1793876281;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=KPbtt3Hqn9bwPf08ui2egWbR6LaVlQM8gtOimZEGAYd88NozvuOWT2yuxiDNNpUJFY
 9MhUb/QPxwpcFqBX0XiMWsoNqf5zJszLS2wOU85ew2Vq9JvcI2A0xygQlMFBKdClIHlc
 N5PAFxHxzXIMBK+YzCjUWpt+S65A+90qzHPKYH9hpcz439VAEZVVL3aUoLwZ2x6WRuuv
 Bn20u7OcbRkBa0agb0e+Ep8JGa3gLZOpin5Ki1QJRPJf2woDQ1fyTdilQ+D88WXuPvaP
 9c4H7XTcIEE1cZubVTgVvhayfBgWUgVuhlJ3H0Tgm4tjwS4q+WQI+DUpn/oYTuLCSWXS
 SOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271481; x=1793876281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=b1zBgHm0RLCWwauLWwG49tvGvCKiI7/b2mjxKtlGkhgs/psSkgd/gv9puic36LrcMN
 DpLcDhwRT0MywJVZa4CrgtkcKGXs2Wys4rO8sd2cylNrgiEh1mT3uusnU6CP9a1nzS1h
 eR85a/nDX2xP+MXaLvuP3a0jj/6od5p3NlnDcrUE6wVkL1kjh7HDy4xHZ9Qqt3XFCo9N
 35d9m0HrZcq0YhCK+dQSmj/QpZT2tyApLVoGsIIpyb52oy3bqKrcmKHSBm5ysm6Itl71
 KL/9HVxfiB6yWVsIaMHQGEtxf8Cj+H8CVKvAMaXwVrdqR3gNsWOJIzde1v+y9ceFhrg/
 hdoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkYbRqxJ/40e//Hpr8laDy3LTW1Sk1Bb8SuPqbZuutuI4NLzm5gCQ3vy88gDTvfjVUImiF3C0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYII0GliVUjkmfhIFQNi8BuJh2WqSP4S7bNCdx0s53ahu2vGXozt
 Mvg1QTH7jj23WaDFadq7yruJchMicYM/sHQb21SKzSDwtPbVv3wxAJNcXxaaCFbdXakaBL3FZrN
 8ZaWIK8oVQo4mkZ7Se4XZrCWvI0Ehj1YlBZwHAO+w01sCziU8jSrSghvNooEcBjydtRG0MDw=
X-Gm-Gg: AYBFou0Q8Drdb4oop6pq58GYJnejuW7o8ZbPpKuyrWGC7PlNg7PvSs4dok/C+VzyoAj
 nrNxib2Kj+/SDgia5clQd0qqjgyuhHZIgjoGoQ3+hekXTtJQWKrT+vvlgn4f3UomG+QgJRfrNED
 rxZX5OcLdwzFULAe6MCGMuQszOslmmwyxPzEjsYLv7oZg7n4Kd4ujqdhnNEn7EjB12J/VBJb2mX
 Q8v69ySB3NNoBRutJSmE2C5swYM4O1xAjac0qWMBy9OG6qKbKKRAQAfClw5vVOyzL2Hviasj7x/
 qGm/aOvfxg/CwtSxsfiwVmp8Xsk3Fk9WGRafrwzrldYIbAncvrCsboDe5pq3uLyzQEeYM66Nmzu
 Ewzza6dy87sV0H/PMv5TC9NIoUgoX4UfmdABnd7rYTnd89XnmdkCv8nUNhauw2/6VQinShzsSUM
 VtidY9xP3iyD93pZJgxb8BgQ==
X-Received: by 2002:a05:7022:126:b0:164:4e36:f956 with SMTP id
 a92af1059eb24-1a6cd499060mr7899345c88.16.1793271480547; 
 Thu, 29 Oct 2026 03:58:00 -0700 (PDT)
X-Received: by 2002:a05:7022:126:b0:164:4e36:f956 with SMTP id
 a92af1059eb24-1a6cd499060mr7899298c88.16.1793271479914; 
 Thu, 29 Oct 2026 03:57:59 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:59 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 08/13] mmc: msm_sdhci: make tuning callbacks optional
Date: Thu, 29 Oct 2026 03:57:41 -0700
Message-Id: <20261029105746.3487456-9-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX9bHWICQ5yJFL
 bw8ez+yth0C04Gzd+DOWzjMm9LvIKwwg+Yo+2FNUbk5h7AF8M/YWiVeQr6yaLrmRUMT9paaWPZk
 xYGvYiNqT0SVNUGBRSdbrqbceUcwSUM=
X-Proofpoint-ORIG-GUID: wWNTF__54YaXde_cNAj6sQmEbzVtRvpQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX3aYxe5iwwnfi
 qH0uNlDB3kt9LeaEN6EjEEzqQtxHFcYrJjif2Y7dG4QRZx+vHAfui0UoEZMLxbn1QimOBOrqnnH
 wSNa1iLYp8eYjLTuRT+uorI5GdurfpnTEQKsp5zryPm6zgYZbU8OgQRUImcwMAa+/6FMiOS7uAr
 u1h+gn4b6OUG1PIKcFnsZM5tFdtX2+YKsxkjoI96lbugrNWZbBm8OQcldWPAfeu9NMPvDFOo87P
 +dkKeDonTaOKBz3Tn4O2J4pIymvaKL7CdCCFLFNHHncKTzl2/puH9pYSn39kMGX6fd3qVewJLJ2
 ycAxUo7xq2KbDXU2iOm5nGZKwZ/4IKFF2LoBCMmEK0Qsc2C+9kSqmixIw9f7ejx2hgQXifauiAP
 f0BqiySu3QwAtcCa2YlD9sc8NAUIiwhwV8KxeNdk0EOqOihFg7e6wwPlA0J3B4UloeGVL0KJEBX
 QSt6MNgTZ5M3dcPl52Q==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae326b9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ybWPJh-q2Zyr6sHLyusA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: wWNTF__54YaXde_cNAj6sQmEbzVtRvpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the tuning implementation and callback only when the
active configuration supports MMC tuning. This lets Shikra
SPL use MSM SDHCI without unused tuning support.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 503ebf0c5ee..40e2ee15801 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -558,6 +558,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return sdhci_msm_cm_dll_sdc4_calibration(host);
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 					   u8 *phase_table,
 					   u8 total_phases)
@@ -711,6 +712,7 @@ retry:
 
 	return rc;
 }
+#endif
 
 /*
  * Configure HC mode selection. Runs from set_control_reg(), which the
@@ -907,7 +909,9 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
 	.set_control_reg = &sdhci_msm_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
-- 
2.34.1

