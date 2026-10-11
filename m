Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8411DCA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CEF7606C4;
	Sun, 11 Oct 2026 14:42:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYX18ZjH37LQ; Sun, 11 Oct 2026 14:42:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C4E460639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729743;
	b=USEl/e+NUXKhwfLYWSP8JZWdayzo9a97M9yMG2wOcR0n+7VBIN+2fX71lffrNlXcvqmx
	 pNLn21ZxkNXiv7hUZ9g/+N8R/5zKVDOy4qcDa6OPqs9uEbedJloB1qnSJ44qEq+cVqr7w
	 9+rZZPtAZvHUkTSYg3ArdjPVu/Gw8qoLoB7SzFPL/1JqM7xlae7RpAA8a/7JaMZsBjo3y
	 WYKjkbkKIeLpq+u1yjoUW9YRmbsAPStKx5EiVVc9YWohBi5LSXEpIktbFYgmFIiZbr/Sx
	 gbjOuhwIqa8TLtG51/ER4Z91eJRDffXIw+OUt8sPRHeLjgqtzxZk2XDGN1lyTvfutig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
	b=HmIEwYu3uOsQze3FFYcRM9bK/uwRPsv9bCplAjXq1xMvacjN49Z1OFWzDtVaZMmrgp6v
	 3YSdZI4vabIbE3tiME828fMDrFErx/nzND7qEK4ELdVIxHdZUbd2d/Ov9WeaD1UsoMBJC
	 UzPJuEuD9xrLaRQhmfYV+Elk0pYmw+IVUzCXcBmh8CtxqpZbya0wcCZ4EpY4wXyor4Lwc
	 QxqGbJ9aJbCBFiNfiFZjQHXVnNtUEkjgJkE05/bnjRkqUbAAlI9lMVbK50YY3NMaJNIPD
	 prVIxiKAZfhLJFGSYr0z5/nRYNePBDUjONsphcg+Jr40wClK6EABtaOF8LJvowlSAGw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729743;
	bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQSc4F7VAegDltfnzxifDF/2bJSyFL4KQ1I3Z1sADrEgdyPjFMbEjrkGQQizW5eV/
	 cfd3JTYgYEJka1qfMpVs1vDuEwAD1KGGss4YalWHUuFGlMbcU2AtyVjPgtglCsRTYs
	 tX5JoiDN2SDg5ji3KM0o0LvNBMJ8MqEdbM/J3UZ1bMWcyO+Vzz1xKRmtSmwDebEsrm
	 NhZMf8quIqpa8C3AcOlTaLE4UzVkk5bUTJy4o1Ik4TlTclIZsAixZq/uDTDpZmh2Do
	 krlxkfd5ox5XbSTMR/vA2wDPOudb07dahld6ch5BYWao4nsoaY68Vw5CdeMrX9PaN/
	 0ldYRzOZU1/AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C4E460639;
	Sun, 11 Oct 2026 14:42:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA434380
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBD4F40627
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hB_me1yXzjY for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 14:42:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0F1A40620
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791729739;
 b=GhUN2gnvfeCzIzzblIfo/Q4DIgQ08Nawu3oGUCn5QutoDXljnsT4nPN6+eTza2xvlkPF
 kC4WgllCgQRLR7QAJ9N5rYEBfEB4vYe4yTycJJCoCkL2lrgTOCuodulQ2+Dg427RJehBw
 3t2FeMHdVWgXUFMJxIygki6OungTtWfzLSpE9Ojk5jRP9iqJscqnburKOWJEsoMB/5XNh
 9nTX+j3RN13VpgzCOz7hbBbvwr0ACnvOXJ34gOPORsqfDrE4+cVkczLxD6EVNwMBYuSxp
 P9Uq8zvTfEOeCt7VsHuPzBKSY2A2xLbym7apl0scQEHQ1AGVppo4V94ShCZ98ngBPeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791729739;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
 b=RUtHohvlT3EqzHnjjQzJ9+CTlzsHOsimDfNdGyA2v81YENhI25jI6/yuMr5w6NPcNBUm
 dRbp5s2rxUtTR53eDj/+cDc6ttN3WPXDSRunziFKbsZr4hHJep7urcAFsR1End4IQRSI2
 a6LhgDOgkJSr4Ql09oJha+0bB9Ok2Ejk+ZjAOe3a3pPU+g3ZrQOyZvTVjW/eFrXQjPJrR
 ZLj1F9ofmbPMgREZlTz2qrvIk3wz591q8y9k4cGxOlOoBl4pHemPQzn3IC+aYkb1tuwor
 MzmZ5cYeT+Iq2hK875aC4sbnijMgduz4n+amKOpM/yL8Ao3A/gCBWZ/rQnJ79XHBL2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=C2DReVhQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XRhuyWML; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=C2DReVhQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XRhuyWML
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0F1A40620
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:19 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85H9s1512952
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=; b=C2DReVhQhGAMCKd2
 SaDt1plEwIqK9yEns7R/drzRofHVmTwz6KtgS8eGDA2w8Qj4MUoE6xCt2TdJmoV6
 2ATCA9Z2KFlKI1oTQwXjyaUdtuQYFojmwwofmX+Ge8Jctz88HryPMbOIA5sb5IYb
 vP2Hbrn0u9gjfe7T0N4S37kiEkYgbbOAX7LygZeC12DAQQDEuEBsdbgGOPxkiW/Y
 2YBHcuJ4IPbS45EOVr/YCQiFDwzj8MhikCA72PBYBfKbUNbVO4CJ/OlMktY0VfHQ
 NVyLSSLy4mdsQrmOpr9unRZQmAryNT6rer9ic0No8pz9s/ZOPJEKsMfGuyeWlHbg
 Y0DMoA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjk38n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b69ef6514so19922216d6.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791729738; x=1792334538;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
 b=XRhuyWMLmWPVlebZun8aXfwYmngxM0Z2bc91utLdCIeuBiG4r51RugKe9En+d+oOXA
 p6YbwhRJKrzAWrPn6Y/IkfoRigy4mD7m0VLLHOVJs8tx9ms/8pzG9ei8M/chqMO++9ly
 rCKSGU0gcW0XIHw0iRIMiXIAMxeZvgREe8Pg8FvEnE/AdUbe44XEQ6nh48/cmqMZWV+q
 ucGWptAiAi4EIK2GuOnX1a8YV2x8QILjwVA4AsnCPfVXOKJswxgbjyulBdeyXVFn6vEA
 1ixKG9C7aRPa18QfvNZYZOM6MOJpLveE1PvKmt7gRX+siXi56BNP62WYEIHq+H9q8vEQ
 vs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791729738; x=1792334538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
 b=EirA60DbWC7ZyHyfbN7nfiERwM0yUsrTR1L8NCZSaR0GuNm3hJ4HRpifT8///sWMdw
 7v5D3dNmNbt9VPHaMBhvyWi/ZBmMkano0bo2/oUKE8kcpuEyikUZCfP5C4ZvFOT5OrrZ
 J+Oh9FuLz2xt8PhE4uY+oVlw2ZGvwdgljGeEu1kwbvhk5mCMhf3uS4+gfEVZE9JKgWHR
 rcAd7UKUGvymN7spwcXHUwGAozDzUxQKe6AOAmYYxQBpIu+HzmCRbKsEdzsZ+vvdYI+8
 O/VXoyxMH3UBziGhRBQPxmJKjfjx51HjffgAasvdvNdbKfwIWwog9g/gYBM/A39huFkB
 +wUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCL31l6PAtMzx6RRHvkP4ji5fxGbUGrNU4+d0c5JkXzQik3czXn7sAErgmRn+TBbCSjpdy+dQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK22Ww/NXhmSHAXbHVcpb5op8gk8E6oQA0wurNaCUlP1vCNXh8v
 GuYoi+3yq+snDFif+gKNckFR6Hq3PgSaqRCsIQc8NGw+bxzZ03ztNLaeBA5hNi9LOwlpmoBXSzs
 a28imkbqYKVTtuD7FqVxtiR3CwLMWQPdfzQ0uSQjDekuz1Q2CX1KSA7r6ewAIX1NTSioJnyw=
X-Gm-Gg: AYBFou0gVIov7YTmAliGmHhknRMe9doHAUDc60KBbg1QjROkmoJsCUW0wNkVDgUAb7G
 XMS8GTrxmE3eZD76b0IULwWG+R85X8iORCZDXcx+AD0aPmAhoYO5IQ/txJba8wysSQhfKamIEo7
 0adcxUwvisDGydubH7lrI7fzqWMzCpXkF2ZfP6JyRh6oY6i2T8cUA1s7mcls+hnvZiaKVq00s04
 NqORGM4xojc+/8LqXco6kTrA/HL3brFGBLw6e0XBZmWeN6DMSgm2ndfel3UgHxjTTXcEAUEsp1T
 Y4phA6sogEtFZ3I7BINiY8XfIVZM0oWhYh/HUp6xjXma4XtDM4dBFpf9oZofxXch4d8O0jLmQVJ
 zTgP+74hCdKnCOcjHTP7RSsfe1kKoocWVJIQUhyrcn4zx
X-Received: by 2002:a05:620a:6007:b0:93e:a91d:6f94 with SMTP id
 af79cd13be357-93ebd224f61mr1105557585a.18.1791729737919; 
 Sun, 11 Oct 2026 07:42:17 -0700 (PDT)
X-Received: by 2002:a05:620a:6007:b0:93e:a91d:6f94 with SMTP id
 af79cd13be357-93ebd224f61mr1105555385a.18.1791729737418; 
 Sun, 11 Oct 2026 07:42:17 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dc0c8asm3854326a12.13.2026.10.11.07.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:42:15 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 16:41:58 +0200
Subject: [PATCH 3/5] avb: verify the boot images in the buffers they are
 booted from
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-avb_lock_unlock_b4-v1-3-a45aeca54016@oss.qualcomm.com>
References: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfXzWTnO6I9X85U
 mLXy33dcs1n57q00ZM2wY2/sRjdjSJBS+544rMMjLaMcnU9CkVh13/XF68vHqluN6GOsW09W2Cx
 63fXW0BmeoX4PYhuqn7+PnLXGGlKjjWziA8Z4vN6oXmnMVk+Tv5X87Y0QR/r1UuFivEdIxo9geq
 c+qT6dJIZK9t9h1waysBdv+iMva7VD/ZLpijoTtaogCY76/RbBjU2BrnY7hCVYd4CyzzJjdi4qm
 sXvbcOuxtd5fFAcjkCxmGsb3JuwxI8UY/zMe55j1ZRXVw1tYfx+jLebrOrLMg/lwnCT539sbuOw
 JTFF13jEoStlYiQPq8eQFzNr6madBtYPB35kbueJCN5GM9EjFKXaoSZnefj+/8ckef8QYqeHuLD
 eyTkGwxQbBUbePLkYa15P3aMaVoNpw8hMq8uI/HhtrZsP45m218n21dc0JxXHmVTqwgzjZKezVY
 iBkJ2l6VgkDPLCl3QqQ==
X-Proofpoint-ORIG-GUID: HKPQh9PlM_B2_7SrZCptfTbQ6CIZwRoX
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acba04b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yEqb_-nEaZmDm_Th2vkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: HKPQh9PlM_B2_7SrZCptfTbQ6CIZwRoX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfX/p14h5B80zaX
 mD7YqR4y2ZzY27pagl5Y3LfTwyXn3Vo65CguiSqTUWdzXH8uY02P/O2qr+4BYtCTprBfYMIE/+3
 K8eHSlSlCXjoEaKRNKzkdaG0AtjiPqg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110058
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

bootmeth_android let libavb read boot and vendor_boot into its own buffers,
hash them and free them, and then read both partitions again to boot them.
The bytes that were verified and the bytes that were booted were therefore
two separate reads of the storage device, which an attacker able to
interpose the device can tell apart (reported on the list as a TOCTOU
issue). It also read every image twice.

Load boot and vendor_boot first and hand the buffers to libavb through
AvbOps.get_preloaded_partition(), so the hashes are computed over the
memory that bootm consumes afterwards. If a hash descriptor covers more
bytes than the boot image header announced, the tail is read into the same
buffer, bounded by the partition size; a descriptor larger than the buffer
fails verification.

Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 boot/bootmeth_android.c | 73 ++++++++++++++++++++++++++++++++++++--------
 common/avb_verify.c     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/avb_verify.h    | 36 ++++++++++++++++++++++
 3 files changed, 177 insertions(+), 12 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 0db08d4f861..862d0d67a2f 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -48,6 +48,11 @@ struct android_priv {
 	u32 header_version;
 	u32 boot_img_size;
 	u32 vendor_boot_img_size;
+	/* Where boot and vendor_boot were loaded, and the partition sizes */
+	ulong boot_addr;
+	ulong boot_part_size;
+	ulong vendor_boot_addr;
+	ulong vendor_boot_part_size;
 };
 
 static int android_check(struct udevice *dev, struct bootflow_iter *iter)
@@ -353,7 +358,8 @@ static int android_read_file(struct udevice *dev, struct bootflow *bflow,
  * Return: 0 if OK, negative errno on failure.
  */
 static int read_slotted_partition(struct blk_desc *desc, const char *const name,
-				  const char slot[2], ulong image_size, ulong addr)
+				  const char slot[2], ulong image_size, ulong addr,
+				  ulong *part_size)
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
@@ -396,6 +402,9 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 	if (n < num_blks)
 		return log_msg_ret("part read", -EIO);
 
+	if (part_size)
+		*part_size = (ulong)partition.size * desc->blksz;
+
 	return 0;
 }
 
@@ -440,6 +449,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	enum avb_boot_state boot_state;
 	char *extra_args;
 	char slot_suffix[3] = "";
+	char partname[PART_NAME_LEN];
 	bool unlocked = false;
 	int ret;
 
@@ -450,6 +460,35 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (priv->slot)
 		sprintf(slot_suffix, "_%s", priv->slot);
 
+	/*
+	 * Hand libavb the buffers boot and vendor_boot were loaded into, so the
+	 * bytes it hashes are the bytes that get booted and the partitions are
+	 * read only once.
+	 */
+	if (priv->boot_addr) {
+		snprintf(partname, sizeof(partname), "boot%s", slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->boot_addr, 0),
+					    priv->boot_img_size,
+					    priv->boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload boot", ret);
+			goto out;
+		}
+	}
+	if (priv->vendor_boot_addr) {
+		snprintf(partname, sizeof(partname), "vendor_boot%s",
+			 slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->vendor_boot_addr, 0),
+					    priv->vendor_boot_img_size,
+					    priv->vendor_boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload vendor_boot", ret);
+			goto out;
+		}
+	}
+
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK) {
 		ret = log_msg_ret("avb lock", -EIO);
@@ -566,6 +605,26 @@ static int boot_android_normal(struct bootflow *bflow)
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
+	/*
+	 * Load the images first and verify them in place: libavb hashes these
+	 * buffers (see run_avb_verification()), so a storage device that
+	 * returns different data on a second read cannot slip past the check.
+	 */
+	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
+				     loadaddr, &priv->boot_part_size);
+	if (ret < 0)
+		return log_msg_ret("read boot", ret);
+	priv->boot_addr = loadaddr;
+
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
+					     priv->vendor_boot_img_size, vloadaddr,
+					     &priv->vendor_boot_part_size);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		priv->vendor_boot_addr = vloadaddr;
+	}
+
 	ret = run_avb_verification(bflow);
 	if (ret < 0)
 		return log_msg_ret("avb", ret);
@@ -575,18 +634,8 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read slot", ret);
 
-	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
-				     loadaddr);
-	if (ret < 0)
-		return log_msg_ret("read boot", ret);
-
-	if (priv->header_version >= 3) {
-		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
-					     priv->vendor_boot_img_size, vloadaddr);
-		if (ret < 0)
-			return log_msg_ret("read vendor_boot", ret);
+	if (priv->header_version >= 3)
 		set_avendor_bootimg_addr(vloadaddr);
-	}
 	set_abootimg_addr(loadaddr);
 
 	if (priv->slot)
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 9231366d5fa..e7685c29d65 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1079,6 +1079,85 @@ AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
 }
 #endif
 
+/**
+ * get_preloaded_partition() - hand libavb a partition the caller loaded
+ *
+ * Without this callback libavb reads every requested partition into its own
+ * buffer, hashes that copy and frees it, and the bootloader then reads the
+ * partition a second time to boot it: the verified bytes and the booted bytes
+ * are different reads of the storage device. Serving the caller's buffer makes
+ * libavb hash the memory that is booted afterwards.
+ *
+ * The boot image header may describe fewer bytes than the hash descriptor
+ * covers; the missing tail is then read into the same buffer, up to its
+ * capacity, before it is handed out.
+ */
+static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *partition,
+					   size_t num_bytes,
+					   uint8_t **out_pointer,
+					   size_t *out_num_bytes_preloaded)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p = NULL;
+	size_t num_read = 0;
+	AvbIOResult rc;
+	int i;
+
+	*out_pointer = NULL;
+	*out_num_bytes_preloaded = 0;
+
+	for (i = 0; i < ops_data->num_preloaded; i++) {
+		if (!strcmp(ops_data->preloaded[i].name, partition)) {
+			p = &ops_data->preloaded[i];
+			break;
+		}
+	}
+	if (!p)
+		return AVB_IO_RESULT_OK; /* not preloaded, libavb reads it */
+
+	if (num_bytes > p->max_size) {
+		printf("%s: %s: %zu bytes to verify, buffer holds %zu\n",
+		       __func__, partition, num_bytes, p->max_size);
+		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
+	}
+
+	if (num_bytes > p->size) {
+		rc = read_from_partition(ops, partition, p->size,
+					 num_bytes - p->size,
+					 (u8 *)p->addr + p->size, &num_read);
+		if (rc != AVB_IO_RESULT_OK)
+			return rc;
+		if (num_read != num_bytes - p->size)
+			return AVB_IO_RESULT_ERROR_IO;
+		p->size = num_bytes;
+	}
+
+	*out_pointer = p->addr;
+	*out_num_bytes_preloaded = num_bytes;
+
+	return AVB_IO_RESULT_OK;
+}
+
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p;
+
+	if (ops_data->num_preloaded >= AVB_MAX_PRELOADED)
+		return -ENOSPC;
+	if (strlen(partition) >= sizeof(p->name) || size > max_size)
+		return -EINVAL;
+
+	p = &ops_data->preloaded[ops_data->num_preloaded++];
+	strcpy(p->name, partition);
+	p->addr = addr;
+	p->size = size;
+	p->max_size = max_size;
+
+	return 0;
+}
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
@@ -1146,6 +1225,7 @@ AvbOps *avb_ops_alloc(int boot_device)
 	ops_data->ops.user_data = ops_data;
 
 	ops_data->ops.read_from_partition = read_from_partition;
+	ops_data->ops.get_preloaded_partition = get_preloaded_partition;
 	ops_data->ops.write_to_partition = write_to_partition;
 	ops_data->ops.validate_vbmeta_public_key = validate_vbmeta_public_key;
 	ops_data->ops.read_rollback_index = read_rollback_index;
diff --git a/include/avb_verify.h b/include/avb_verify.h
index d2136b2ce02..cac8b816c03 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -22,6 +22,26 @@ enum avb_boot_state {
 	AVB_RED,
 };
 
+#define AVB_MAX_PRELOADED	4
+
+/**
+ * struct avb_preloaded - a partition already loaded into memory by the caller
+ *
+ * libavb hashes the preloaded bytes instead of reading the partition again,
+ * so what gets verified is exactly what the bootloader goes on to boot.
+ *
+ * @name: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: start of the buffer holding the partition data
+ * @size: number of bytes loaded so far
+ * @max_size: capacity of the buffer (at most the partition size)
+ */
+struct avb_preloaded {
+	char name[32];
+	void *addr;
+	size_t size;
+	size_t max_size;
+};
+
 struct AvbOpsData {
 	struct AvbOps ops;
 	int mmc_dev;
@@ -30,6 +50,8 @@ struct AvbOpsData {
 	struct udevice *tee;
 	u32 session;
 #endif
+	struct avb_preloaded preloaded[AVB_MAX_PRELOADED];
+	int num_preloaded;
 };
 
 struct mmc_part {
@@ -45,6 +67,20 @@ enum mmc_io_type {
 };
 
 AvbOps *avb_ops_alloc(int boot_device);
+
+/**
+ * avb_ops_add_preloaded() - register a partition that is already in memory
+ *
+ * @ops: AvbOps from avb_ops_alloc()
+ * @partition: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: buffer holding the first @size bytes of the partition
+ * @size: bytes loaded in @addr
+ * @max_size: capacity of @addr; a hash descriptor covering more than this
+ *	fails verification instead of overflowing the buffer
+ * Return: 0 on success, -ENOSPC when no slot is left, -EINVAL on a bad name
+ */
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size);
 #ifdef CONFIG_OPTEE_TA_AVB
 AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
 #endif

-- 
2.53.0

