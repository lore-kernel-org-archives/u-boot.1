Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD4606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kyXDrF6K;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=np482ToF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RZfNP1Th
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A35281316;
	Thu, 22 Oct 2026 21:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JbYXcZzXGPCX; Thu, 22 Oct 2026 21:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA293812EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704885;
	b=az1lcpCfat1a+PomX/QzcFvfUhoFErhQjcH0lz534R2m2cy0bzlmZ7qFNqkEINDTb41Y
	 QKYYZcnNxb2d70vEy64HKaTyCZ1axijWVFg6OFoDojvzZZwTPmGXCtvEFZzQ4ghidZVRz
	 1qaZjgli+Cqapq/2cH/QdFUJQdEQOnohNp0suSrtsuZcvjh5Z7hNlg37M7IBmd2SvOrN+
	 1HJM4jaQKk6KWVKK5t9S2nIEKhBkS0mpCW43QTjRUX/VcZQGZSm77u+AIPGFJh+rE4GPj
	 I6lfIagnuj5+cIyBaaEqVCNqCOkeeFZnapiVxBvkiKI4AeYh+DV35IYIlwPGXEmaarg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nryn5o/b8w7tpyu2vjCIuEz3TF0pWK0nVB32ALi2zFY=;
	b=NA+cU572tSjhNEi4CLADs7aNKtl0UaHMGsRowaAop4AhM8tUyYOj3WL7yd2aezvftZrr
	 2Iru8XDyWPvT9WN5LV1r0J32RUBH/Y1p0Uo8YU2PfZ9BuwhPJsi+kngC8YeuaKZFKOac3
	 JbmPcbVUuNC45xAYXhE3irjyjurIWbx1oI8QZ+QeDoz6CZXuqyTMjHkITpBVD/Cuim4+H
	 ZZmW0z0xZrhO0NUTka6oBRs4NdB5VoIXEWdE6DuJ2ioae8yLbX5Uet926pqajJCCXnn2/
	 ovfElXxrEQ9OKUxq6B8dmV9fPI3wHoiZvh/Z4kicdG/WWhZXB59xf54wJUrdhht7n+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704884;
	bh=nryn5o/b8w7tpyu2vjCIuEz3TF0pWK0nVB32ALi2zFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kyXDrF6KOYiipbhu+qU/e+C3232RBlcrZeyS7PKDLOp7xEJnnT1Cf0i3S55i7sCEl
	 aVdIZnu6FyhKy9IcaIhyMrzOP4JXw/zu4rOp1Ko08TmMCbb/WD1EBLDCICz0VPpJ/P
	 zdoYOXBpwvKbEzDC2spi701PibmDSxvxAov75yBD3fkjKlC0ZfPPCKLLnYlI4kpK6w
	 VckY4jO3oH0V71Veg7AbftJPuZ+eM9oryJPFRMXT5ZQEfpuzaKX1B3a0DzpORs+9xs
	 GOFtArkbKv4E3TqJwH4r6Ugyfzkz3d+GdnsXJ1LeyqkpmGFxihUU9t42aymIUMNQmC
	 ea/kTPysWur+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA293812EE;
	Thu, 22 Oct 2026 21:34:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E8804BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 501F560A47
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZaUXuBZDdgC for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0B42B608F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704882;
 b=mjv0xposrpC60YY2R+Owak/7VwrBiPZRTq6f7/PXf8gWZhoHZRxZuZ5HCMHav0yUTVNC
 uRiUwEK1kLHzk2XJraS4tpNzaOzhXmVzQMgvuljtuADOwsk+l50rJEKurfptkoBTqpBVP
 mlsZB3It4LlEQQ/k6JHxCkbTGdmciAw9zvzGubdS5yRQb+M/fbjdPTmY1aLsvwmRYzaW0
 mu9F8RmQ/GoenFl4ajrfrbzK+axbMREZnnnG8rUqsI+fhiC0PtzQAx/7dBN2OT3K1g7mV
 78ywFiVG6MJ+fC/puorPenP+g2lFLYa1Aop3KRxw7sfKmYFyNw0csiabpqeT7jI9NdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704882;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=nryn5o/b8w7tpyu2vjCIuEz3TF0pWK0nVB32ALi2zFY=;
 b=sN6KCpwha91Jk7buf+lc7pC7A+BsS9Cetg+tMUxDC4Fneu3lbLi519zM/Iv4Oi/wi50T
 DSv4ldWYCdeOC7kDq8N7IxL5TO2Ab/Hm4SWoefCpY7d6r/OLvvj9FeVxsrEWvceZRl9B4
 SZHGZ7VFGWGzO7YttrVCOtyRSI/M4Smb8BRCK56U35wzGfpkcX45viALBSdLbviweCwKx
 uhL1q5DTaICU+zZqqlsH9SqTeGS4uZRT39KQ+Q7TEFE921Rry4iixcIVNv2bqX5mPUdfg
 rctrtBlBBh/vpRWObGRSx5RTh59vP+ZdQLgJhMp2sfXL6VXTQ9sn/VYfaSWkIve8lFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=np482ToF; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RZfNP1Th; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=np482ToF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RZfNP1Th
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B42B608F5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:41 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHd111495654
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nryn5o/b8w7tpyu2vjCIuEz3TF0pWK0nVB32ALi2zFY=; b=np482ToFdMBaSCA7
 9Q6FWOEOTYGr+v6228MapxMfU5OUtJ2wcC6ShermfHRa57FnT6BLV7ilYbA2VPzr
 teUzNxc8XDcpPIA+CQG4c3o0wp8mUUR9bglcFwDvMwgqg/gEFmnhi5XQO2Tkpq3+
 Y2VYFK1HM51Yhsd+b5HIEuF9/JZfa7njAouzv2SfIeWrqDMpc2eBxHhP6aGNfCx6
 DkCq7vZzq7eRN3RCsVnzOk0xFnOUc2UdrkQV28h9l6aIc9YyYolMQ1UhqkyjSnPh
 XsMSQQVPKwXy0MFDdBvHjSSBH4ZQ7ScetyTQDlZuvbRRhvKC++ZOf4Zs1uPHs6fd
 wgSNWQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8mvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:41 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-679a3664e1fso533828d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704880; x=1793309680;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nryn5o/b8w7tpyu2vjCIuEz3TF0pWK0nVB32ALi2zFY=;
 b=RZfNP1ThHn4h40EzfI593Q8tVpQtj2qZiRdoIDw21Y/vA5jmilZuk8F4J3ZxQbfdRb
 N+Eq2fZTUQmPK9JFKK+oRRRtLVyvYmNH47zHo7S+U/r/8eP7lZI6YCV7iI/lhAyGn1uW
 UuY6v/cNX6vRh41GrldV41xgCKxnsJRCdWi6oiJ1C0/TlwOS623JuXGmboEUyKyCN9r5
 sB5xUT+rzcJ+Erj3WC7LWBut6Id5BDhYq81h4Psy+PmCBQdGYChJFFjDU4ftQ41eRuGC
 41/2Pt23EJp/8jhjLm8D+CDPHr2OmZOTSuVqpAWjPzYmaa5yzvuK62nYSY7qIScXa4xW
 MYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704880; x=1793309680;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nryn5o/b8w7tpyu2vjCIuEz3TF0pWK0nVB32ALi2zFY=;
 b=1OQ/MdUm7AtCJ6K0VJUCezzQF9RZqkUODyguHuNQcRtmtsANZa2K+B9mKxbOhmmuTq
 yiHbYHkSZ1iqkXuY0lNRvyLfuEzmI531mgR2NuoVLsZbHM09zXLAzzGbV0PGnOlHVOEQ
 CTWwUHYjtdr6Rf5PivNs0TXXSLmdHjtZwfLoCHb07DPdkJ2/mWWKqwYgB7YRZPyqVZHd
 ziZiTD1aneQEHBA42z9E/50CQ5NoRU6NuFhf+t72nvRIKVTk1WNS3uNZxeygUW4SqfEQ
 1UpE556kJSAfA/fJTEdSenOA63ot6vFnwjm8qHU3cAG4h9CjfLAVIJW7u3Vl7ipLlKII
 pOlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCmpjrTIKc/sra9mLMBfwEPmGBLDM/gReNm/y9oCgU+cPCc5904RhGfX1PVeNx/Kxc/PjwoD0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLhKyEl7kDtrNGdlxHiYKOZBeMcnpg87wktd7yqBwks1s6PPbVX
 BMX/2NFbju9HAmA77zWgaM2VWBnzN3aZO/B+4QQL/23WT3hUka6Ywh7Vu+y7JPg91pU9DOiXRIL
 wbiYyqNhI+5IA+5pG9I8WKaKU9aQQa80g5B+KbZaQWosiOjY01tYgH3SqXly6T6kG/4dbM5A=
X-Gm-Gg: AYBFou3Vt7Wdv5FeSlkUi5MWC1P0jjY/CWxXZfTcJgpqR7VfZsqXFdL3SfcdRxgoR+4
 6XgLZg+VA2pZRPh4YAO+oV1r75o40HIdus564yEAD87Vu7/Ou3sWc28f3UEa/I6skICFrsUFP3u
 DMMV1j17s0zQO+RrY4Y3mt4SWyR5JECXL7dquYM9n09rHc2V99c9MllR8ZQOFaSoQnVPYLEPF6t
 88rvyfYd/UGeuQes6vU2D/7THszYYYLa9tWiZ5+qkiQs6+S7X2ichoi2E6SAztCtJzSdggRacre
 hpzp2eEo8RmkVlNbZcxa71oYb1JNmQacbjmIDdo/edch9Df8SkgndQuk12psIvEE+eurGtZ8mk1
 2273IrfFMud25rgYCN1qpAGGik8bNNAtBTwB2gGB2guoZs538C2FU1e7MWZdE
X-Received: by 2002:a05:690e:d08:b0:675:5e46:36cc with SMTP id
 956f58d0204a3-67a35bf4e4emr210588d50.82.1792704880104; 
 Thu, 22 Oct 2026 14:34:40 -0700 (PDT)
X-Received: by 2002:a05:690e:d08:b0:675:5e46:36cc with SMTP id
 956f58d0204a3-67a35bf4e4emr210558d50.82.1792704879498; 
 Thu, 22 Oct 2026 14:34:39 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a340528fasm341473d50.22.2026.10.22.14.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:39 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 7/8] pinctrl: qcom: add TLMM driver for nord
Date: Thu, 22 Oct 2026 17:34:35 -0400
Message-ID: <20261022213435.765978-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-8-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-8-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4OasY4zKX383qD2TuSrUJAUNQnJQgAtV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX6BcnFE0+Q0bt
 TWD8qkn+BjbcpCDyyZllxAgUvNlzoymuV3OU/gJH0X0z2iMAa1G6HZ8D+rUqK1IXY0wL3y/aXcs
 Y6LhGYNzZ1VUzPDxAAW1y3GJUsB6hGQ=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada8171 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=sOnDfXEmMANyBQqeG2kA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX7q9wTz0lEXm8
 MDcoe+SNOo+AOeq+Lgurkup5DN/WMlVWZWhyEvgqXO+X//tMqKmAhcvbFbBS9Gq6XivsBdn9E5D
 SeeBkjCZSnnqMe8D/ye3yUX0lSmdVvlAPLI4QZlcluB20k4XxTRDvMYlLCcndOx3vKdH0OG6tzi
 rDjGQd9t2BqI63G2sQb8aowIxYTlGoy1sVPobLnpa78sVG10DBa2tVaP9peej+OslDl/Apt6CWB
 r2kBpCO13zFYFttC/9XyjD42msHQLbaBWU5wS98FVit45pTLO8W3gHeTuopIDC+huxN+kLhj9rH
 p2HHkWD+qRLg3eA4mYOFVVhyEXAbSpoVDK0y6O7dSBpwqT7Lmz8xZxGMx8ix7K/up5n/+06YnNt
 0vKXeMTOl18lmVCzxrQ6n3V45SNB5EEpuTyYYTYsTKZsjfEPqF9spDV+ZBHQALNdiQI88ZnWUJA
 2Z5UqyrX8BATrMjyLmQ==
X-Proofpoint-ORIG-GUID: 4OasY4zKX383qD2TuSrUJAUNQnJQgAtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220086
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
