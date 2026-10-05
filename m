Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0723CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 06:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C33760614;
	Mon,  5 Oct 2026 06:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Ec_4R_PBkB5; Mon,  5 Oct 2026 06:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B7B2360606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791180493;
	b=Lo1l7XKWMg8INM1wTpDjG0uh0WkZFCve726bSaQH3ZQqgJlDpFD+gihBMsAon1dKMaBO
	 8iZJAc0sTkE3mtO9aXxBayEjHyUCjvPeg9C3SgAb+GPwbyXrzhz3itvPBl/A43xoqDnRN
	 7gqAd1gn4haPZH3G+sKJxAre1FauV7FjfVmqCn5ASleXdPreHvHY3Dno9uKO5lByWPunB
	 YZlUo3DqPd1SQiKCOQVo909AlElGc+kEeHxZ0D8hWQtMV730gV0Xc+sbBPvkd/rtzKFDs
	 4YJBrKQsQK1XFnXqIsbPW0+xFoelLb7uh0qc3x8KWEQAx61o7X8CvR0B2ktxSkaVBmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791180493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=roUp5enCr4d438pxjPYsgEvoCtFU+sfOjDL0RFqapyE=;
	b=mNYyjYkB8qLMvuo+D7F1/fAkYKkSTsyau3yLqzHJh3eBpjbqMJYcdcySK9QLfaQh+I9O
	 uR0gThlzkq5a8OGGUgjr+S99gxzNv6ocs5CEEBoOeGj+GuHWuYR4tSHim3tZvkrmPIik+
	 DEgRqGCWuQL2SAneXNTAiTK8XijKMKYlbFLqMwt3xN4iOZyrZzzUbmTrm/LXYeHKJL4Jb
	 iUJMXcDilB9+LdZ+vCNYZZRq7QSbgxhjUHWDFKz7fRbbc/eJOPphnOXzVHtrpnXYx8e9R
	 cxV/U2nzqzHIERQGqxHqow4WUtwnhSLijgKjZJPVqoGItb0tbL4hbni4JKzBlsK18BQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h5w4PnvE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OYgxJOx9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791180493;
	bh=roUp5enCr4d438pxjPYsgEvoCtFU+sfOjDL0RFqapyE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lt7dcXYcn7t77Xc1WqSK/qHaVnyl2T7oRfHBNTInSV4dkF89VwGxM+GK11SDWK4O6
	 SIDRtcr4fnxIE/25ke7l+f0p+k/4kXIHHbsvKoAF1CwGectcvta1uYMrSyibj/g8qd
	 flMFsAqr2PBT6D5D0A1QZDcp9Xdj9VEJ4nXhX5AKOFNAjzN+V4F9q+hbqThjurtZYd
	 SyDiFRWHGIxd8ErqGGCzLN2ebkOCHERedytRaUKC/+GOZt9bVy/XObAU46CDf/gUXp
	 PiW7Oalsmllh5oZ+dKCjy4uaDVh2Osex9u+zSaeziJgjGNY9W2GILxMzG4fpMfyn7m
	 kCT/8lFo/fiGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7B2360606;
	Mon,  5 Oct 2026 06:08:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49AA032F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B0CA60606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0HiRo9hBAeQ for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 06:06:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 18D86605F9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791180402;
 b=ISDiYXZdyt/UC+fvyhzoD2TSQjMxT/qhcgnrM4ENmcbCxAvvGdiPhDgJrznDKpkPQM2u
 iHx4iVdNP7CUvZledwJ4+AvNEEXv7ZoqA322CE0OQ+ULHH77MrH+rEwLTciFg1b8D44JX
 KBXuPr+21hF/2JDHMHl+I6UqjVMCCl1FbAM/YYeQnmoVoiNUWEdR3v9sn4PEHUbMGS6zX
 z3ub/kWBO1pOdSNBJFHf+EL1KBKZ6QM/zmMTT9pUDPhQZ5Kx+jwGOx8PcewS+oPwJ4fp1
 zYzuxL3BLE5E0lc0O+ZKLz0ZCsrOKkh+pvxDHqRvV4JA965nH7G3+o/tMwH+3dGUsUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791180402;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=roUp5enCr4d438pxjPYsgEvoCtFU+sfOjDL0RFqapyE=;
 b=ZB6vsu7mgVnqzHfgLgkojqXz9Mu2MCvOS+56yZI9I9/laDiaR+YduTexcahrrtipRQbL
 EIkZEo+93rxZdomtscpn69Tm46jeYTxQUc2PrP7A3/YPVy8cwiNBcYvyGUWBujluMzYpf
 KeGaEI/umzFFDANaOSiIr745XK2uTFpzEEieR19YzoxI5AYs+Rdf5aNhW8tCWa1/2xkU6
 1N+hZh5hZfsUe4HpbjDHneYoPfmsv5ZSQlzFVAbcWcAjQFFoQtaSxlH/5UFNZEkQFKAPP
 Bo1BmNam/xHzqaynslV4Q99GKVALoq0ittaY3nS7Q+ehAf74xqWeAmgjPuRzU7GO5eg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=h5w4PnvE; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OYgxJOx9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=h5w4PnvE; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OYgxJOx9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18D86605F9
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 06:06:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510BG2787341
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 06:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=roUp5enCr4d438pxjPYsgEvoCtFU+sfOjDL
 0RFqapyE=; b=h5w4PnvE7H74oswLPDtAzfJ2npG5UOsi/G8l4X0AEMZWgjTbYzn
 7efow9wmLkxEUqGikD1hDXnijwJ4yTaOuYwtpncbB21GRrjPp9UC02dBRHfiMC2h
 lR+aETSRjOV+XfRzMBlUHSf5X5lG0L8bbkDAoAgnqbXvJBQlveuFPNTujPh8xOY8
 sIIAYDagCFZHpaTSbThqhqq13CrqTb4EXOjIag3+g+joI92bjtJcf97P8yxEhLGa
 Be3VHJKjs3+L6KZ+x+v26PQkcuaW8X4IuIsQKAQGQ+vYcyQvc1tMbzrcZjeoAFEH
 yiTtM2+MCu801McUOc6JJ2G1b8C60DjifOA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa4py0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:06:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so3056498eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 04 Oct 2026 23:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791180399; x=1791785199;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=roUp5enCr4d438pxjPYsgEvoCtFU+sfOjDL0RFqapyE=;
 b=OYgxJOx94bsSfm0xK+HEb+hK2Vn/rwGim5UpXatRcrEysmNSLfLtju9PJzW+wJhgtY
 fW21I7KoPCOZRLRnfYUHmZP29AgeQ3acrgFJ+zLrCas7Qt/83f8sT6iYO7YRt34l3bD8
 Xtrz2clJRHBuogGgw6pueVmEuR7FEiaP9xARIvu2wIbZxMz6r7eVNhB+gBbUk22T07m2
 ortibpvhaOy+U13odGnZQLglvH53DAklYq9rw6+78KgUz9oQeebOpbPjwc4FhkyVY9Gd
 saSbpnNBIDG898rTYE1GhZtItaQIiubIuhpRpkhGIg2Yc86uELlbt4Hs6plw3cxKWnwO
 +5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791180399; x=1791785199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=roUp5enCr4d438pxjPYsgEvoCtFU+sfOjDL0RFqapyE=;
 b=HMaF05tsT9jtErdbthyvx++QNFPwwSumGPukI3OMJ4cuHjKqotLJ7KXfLMugifsN8T
 Bw7NMchUMOE85FKIPDIP8FQYkeBEcbkw9y4bDR9QA/YLBRYsgHQU+QwDc/DaCBXzejdn
 gtGRp9DunG0npuEpoFAFFvyGuvb+oPiYaGTu44BFNtpGJEbixDVHThD2d4y+WiF0jOnD
 T7bLj3Z2uUMDobifwIdEfpNZz6I7zBbX4DeogS3svxd0wem8NY4tt+7nAwomfFFIy4hR
 f0Cg//nLlNH4RW4FpzSjFUC0Sz8HcFbSXjcWo4wF9aegtmvuDPP66EjLvo5zm9Zis8EX
 WXGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/AL8pET+agMpkOYAf3EXiGDnccUU5Tr1bE3FNKag8x8lDwtYeD0IKq873hyyIXMXMeAuJ7zQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lYYjFPHqy86wu9hbIUv/g6LGLlMkq3ZwCRXjQL3dNpiBzC7hHt
 C5pm38NNl7p1Wsre/xiC0eSiamJKwGjvbeJkA34aYukEsJp0/XwFDwnyILhh248iVYIttaJ3Kvj
 ul0TUMiTSItZDMaQXeS0eRJp4QK6jy8XESC0FOM0IhzBZTw9YJ5724NO/HnPL+BaYPuXnPNQVDE
 6LAHo=
X-Gm-Gg: AYBFou1PBrn3ZgDM1uUamDzUNcZyBrF4PLsNd6PSBi/bsygKrgHZLoJp4bYuuMPExlb
 Ldc6fLbBIbQwy7B3k6EDBdbZ1gdtt/W13HUmCO6oxdbGrepx+YAReIvHQowSP6L4COxFrnMJWC3
 YUk0d2K5ZDT42cJIreDzPGSWdX7qXPQeyQ0DDSUYheJyrlUkXcBiAhDUtDlvBqnnrXIxKz64IUc
 DCXFxjnIGHWPV/Dyv4GeyTejXtIOmPxJyHRIsXaBq93CutBEuN3aE2R1akBSytFK0mARDmhey2d
 VRl17ygRabqoIAd2gBV8L/IYwGwypzwVXaI/D5+mvNkc4savrQwXn24gPATe7rnWdhhmB33sY8P
 c5NNzUPVFHQi/4LPQUDcqMYEgi+UVK67NsOrh3JVe1Y4tcK34Wvm4ySAou8Xi4pxj+VZMix/7s3
 a0x1OCfuvnk46YUE8Fjg==
X-Received: by 2002:a05:7300:d08f:b0:343:bc3c:6c38 with SMTP id
 5a478bee46e88-34f21985cccmr10591345eec.31.1791180399051; 
 Sun, 04 Oct 2026 23:06:39 -0700 (PDT)
X-Received: by 2002:a05:7300:d08f:b0:343:bc3c:6c38 with SMTP id
 5a478bee46e88-34f21985cccmr10591311eec.31.1791180398325; 
 Sun, 04 Oct 2026 23:06:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351270204e0sm11995039eec.1.2026.10.04.23.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 23:06:37 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1] mach-snapdragon: fix OP-TEE SPL link failure
Date: Mon,  5 Oct 2026 11:36:28 +0530
Message-Id: <20261005060628.595146-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfXzFmVAagwJ7o2
 WrgKRsckMVra5RmjdV1WzhkQ6PkDiLsJUbzqcHMPmhRDtTyGx6Wq2dcVRfaQ6Flt+kR+RoPi9LR
 TYOjUNMFXUs8ksUOhXIxeirg5sYwdB+elJxE7DAp2HGFQ5eQHnqXn2qHx8Jiawc6NOTNQXt0dBZ
 dOwg+DsvViwG5cjhYw09dt3EsqHal5PS36J//1nTPj06ImATKF7c5mpNDd0bVM6ua+iP3MYO83e
 5pnix3lsDNcmI39WVONqiy0qibSLIPOQNttD4nkG5vh1+YX4UU9XDSoTNrcTosR2VbSCzeVEdsu
 vRHUZBnQz1HnDTbt5siIl2XrSCI0ilqarooZY4IJMttbKi2X9vSTDSm+H1zXqb7rY82L4poO04A
 vR0lgLB75tV1Ink0ppxiUnak7c5VjeIbbin+NjbCzFBMI9BipDsewpXYJYWaGH0wxp/pHCI/rQo
 yS75oCEaKCdtSftwqIw==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac33e70 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=tguwG2M0BtZnxZJt7bEA:9 a=zZCYzV9kfG8A:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: HGGBntl1OTNw7o2bECLmknUbZUIlJCx2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfXw0o8zW2UxURj
 4IshT8Dfbe2/AHbiLGqJesy1NKg5iadSRHSetgr2BApiYKy0gvxGjg4abh8Qwab63vXPk6ARC4U
 KB7oFJMQKIDFwaWeL2UJotiPRu31dyY=
X-Proofpoint-GUID: HGGBntl1OTNw7o2bECLmknUbZUIlJCx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050024
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

Use CONFIG_IS_ENABLED(OPTEE) instead of IS_ENABLED(CONFIG_OPTEE)
to avoid calling OP-TEE APIs in SPL builds where the driver is
not available, fixing the SPL link error.

Fixes: undefined reference to `is_optee_smc_api' in spl/u-boot-spl

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/of_fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 374e6262db4..2d6446694d6 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -273,7 +273,7 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 
 	time_call(fixup_usb_nodes, root);
 
-	if (IS_ENABLED(CONFIG_OPTEE) && is_optee_smc_api())
+	if (CONFIG_IS_ENABLED(OPTEE) && is_optee_smc_api())
 		time_call(add_optee_node, root);
 
 	return 0;
-- 
2.34.1

