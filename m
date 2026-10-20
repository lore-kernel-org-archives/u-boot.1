Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2354606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qVl0d0Ma;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N0Myu9Vs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GWoZzXQ9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5322E607EA;
	Tue, 20 Oct 2026 02:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id an9PZByu-PDy; Tue, 20 Oct 2026 02:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E892607F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792463869;
	b=OBTHZnX2ddUm2fshYI0usFqODQlZik2FJg4FNnWaNzAKbeseEqg15iaq15Ij/aD2Ek+O
	 XlaQ+xrtZtFvQIdpmYJ2KM1t/W5xSfhklJ5z5CcH9TbxRiC5CyCw3KpQxd1a4ciijoYMU
	 qhTaNJ4yI9b1idn7TG10nRDdEdx53Jx+NRXiu3BsBi8miREIn8lmoe7sUjvuKTcK19oHL
	 RXZEqr/XV7o+w8zdtxj6OcixBHnz9pd3dqetEkzgtc35tFWWyjS7OPhxW7h7/KSlXRfQI
	 kQGEIoR3rWwDQVWJVbbcME4VHx5ntsiU3kYa5JWD7ETMR8BCq0y03gq9SoXDj028RlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792463869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jJMqNkMOFKJYEW38i0fhkHWXCaPUUiu+EZhFE9DogB0=;
	b=BIwneKuD/2GH2x0QiZSQG2TH8MqdJDo1lUH11hxWHPEiJFNZkJKg/9+5/n1WHyn9+/da
	 S3H/Y0+slsfxkapDSZx1Kli37fhR0huWq9dScYNS/eEGRX0I0yGb39x22uys/LOcDvet3
	 FDWorrkfYP9CmQgpmuGLWUoGi9Cx6p3gY32bLzi0/7FOOwoD6fA6ZwM7atFffPwvqgv6H
	 kW4ZGXI1b1fnAQl/kjD74rn+akfo1uGWCFWtnEDbMMvpXxpoIdFhCoY78PFcLdxUTXUyD
	 aEHhTRO4Q2fvh0w+KDLiwb7xHmoXxhv+XBu+3AUWPLcWyEaw/ZiiLubupFPebG+DZuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N0Myu9Vs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GWoZzXQ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792463869;
	bh=jJMqNkMOFKJYEW38i0fhkHWXCaPUUiu+EZhFE9DogB0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qVl0d0MaodY6ICRQkCjFXZP33ATN+JgYbonzOYhEq1VBPhykkxpB7FCrQ8IvCznqJ
	 tJ+VIqxZNcc7QSkD5kh8uHvpb/FsBeatjVSA0Cp1LlNSdlR/PhS0NlY3D3dm3W8kfU
	 xJEMIiXRJD8UfIoBLGijsRqOMe/GpmNGWAPyScQNXebswSf0OrDLDLU//K4nluBvof
	 MnKv0vX0+4uDtuzBp/l1zJqxNrAI8vWxQ35MXKhQb4suFlHz+xr6jLkSahiyC+NIs3
	 yV9A3mhmXL0vgTJHHckM+Y1zvMwyOHVQuTPOh0Lduqcj27eD7dYgHnBryaXgVH0OP+
	 WqTsR1pL769Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E892607F3;
	Tue, 20 Oct 2026 02:37:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AFA423A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 954D7607F3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKsZ7q44HVdO for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 02:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33CD6607EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792463866;
 b=ou3+GVHV8U/f5TuxGTB1ChFJEeHq1ut4FOHwNppoziiB0YBQUl0XlH+84LmCdG28DsXo
 w4iOcg41xh4bwJ3/QXU6lpI+8l202rYNQybluK5w70Kc9JPEel7LKcWvXWpLFVmVxTj8/
 fXS363nXnWhLfiLol8+f6bFlO6TSTYUyPBZKOUcL8s4jgQblqE6Qo+z4R/16l8R63B70b
 HCUxdaRXF/Ggus4BkJB72AWkZksZEpdJR/uOfvr6IcHIkuWn4oLbRA+BP66q8kMwh+p5J
 Vs/k3dGdCni/dx+1V8V60ZMNhmskcOsEMmfXSXYWissaJAfqMmLtanIK6FADgegGF7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792463866;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=jJMqNkMOFKJYEW38i0fhkHWXCaPUUiu+EZhFE9DogB0=;
 b=oCCjIbHY2KJM8nYjsLcF4FSD9hjX/Cmgn3AFrtyWnDEzUFvx6+Neq5JM6TOOuxvzzed3
 yM4gZD10VvFE8AYDp15Ty9PNxcWmDmMVC9Q1Y5GbUtvTGfACrjcqdu/73sajDlaai0b+L
 2OQq1i1NL1w894sPcWrjhPoQDjkRdHF7quq+uFSyPrkWb62iUFIh1GgxK8Ovq7sdiITyn
 MfNkO7WizFZB4/wjLzR8tvnZsdfRU/zGUhVf4OdbjxZghY/OOmXj+6/SYzVM/U3tdryeY
 b2965JueRCgpgjdGqCNnPj1bAJK0aO5f5AVCSlRwokDnPpB4zgHd09nCFsFaNZHUDwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=N0Myu9Vs; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GWoZzXQ9; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=N0Myu9Vs; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GWoZzXQ9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33CD6607EA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:45 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tW9s1255247
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jJMqNkMOFKJYEW38i0fhkH
 WXCaPUUiu+EZhFE9DogB0=; b=N0Myu9VsowZFdC5A7d8CYq8E0cX8R8s+RPVqc9
 cCdNMeMva9s6mPFVNejHVlJs3kscjBMZUnv5RhasOcxWD56OV16goWo7Qo2pfCMA
 IriSluG9v5zocccoEz4kXu0J++XXLRr1frVpTEj+TsjARWHlD6AvyWRuqjnuDQ2a
 rw9RQ0zWqUwMLy1FQpn+LrYOI5QXFYqD0HLL3RpO7yIJv2GP6o4gsfwZ6eQhMIJh
 xrEbmj5gty0twSnlh6Rdr17TtqCX/FXuiBFK7UZhoGkYWrpkpr/p4SRw6ff3Ufvo
 AN432RIZDHP4pKdNU1FpTxrE3DzMFGIWAn42Mt4YrqQmUF5A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n8fyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so7664402eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 19:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792463864; x=1793068664;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jJMqNkMOFKJYEW38i0fhkHWXCaPUUiu+EZhFE9DogB0=;
 b=GWoZzXQ9ZKnS0oY9WY1iaT1NXMlYeVD9y7JWi779D0Yay+sp3s6YYw+/zQMrV7Xrpu
 69L6pISXCtkpMWk0Wymk5X0HhF6HZGQc5B8t5gmdWg0bsul2+N7oZ+tfBryV701vwKGO
 jWdrwEkpO562amxRPEmUHgzM4G1oWyN7oojwRVMuuflu+emAvHqf6LPKis2YNNF/wnr2
 /qQRoQPuxO5PRPNAMFySjt7Pt+nN3+0doXDPEOTnjlmFvQ3DplpRnNy6+YxxVjPGh1y4
 fF6ZF6r/1Au6VN8NVui51gNZr82pUbc0LNcK446Etcl+b0mS/+JKvyOZn/Mf1oI4xyK8
 fxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792463864; x=1793068664;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jJMqNkMOFKJYEW38i0fhkHWXCaPUUiu+EZhFE9DogB0=;
 b=p6wA7zoPDqj/H4tT/Vj5uAaLEoBlimklurNPCCggOpI9jkt3bTGNwPvja/ByuWs/+r
 4qbuQXqMNQnSHJzbVXzk7c7RnsmDwRi+I0fRLLT7lbkfUsBo4Hk8y3IDg5RhFFCSJ4Ej
 zedT5U5x2kQNeqTmxzUJS6OHjG9gDPXyjusHhsuw9wFmUad+2p+W/NO5BCV4ssp3sAGb
 cVnBI2sr2v2Qx74UWCfmMaElI6MoM2C/M6hYUvmd5VTHtRr6zPu2E4JTC/jtzrmx6wdu
 aTParhod8EYhR9zXoV3Dzmvk4eMviFPSgNZ5vanIKKRxoBpG8XnIZJXTXNazltFW6Qqq
 PEFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQLpYWYNTj0X7qETVmBFYlwuxd6/+fb5CCMT4exEGsVlGPP5nguGV/j6dsn/DnDbT24yImxDc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJycT7jJQocSPu8Z8lXTu5423hsGJWeWDTzjMtMPYSsjh4RB0cn
 8K9+8quKphw9yEihPjaAEPyKwlKLAYpncEinzupaLoaVNKlDR0rKw3z6SwMu/GoGyNOwsslp3sQ
 qUWY3yWa1HqUT+wb3SHCgz0PxrbnIxvLgPrSl649h/CV7gP+8eVkHYU2NwBLXAInMz5tu1OM=
X-Gm-Gg: AYBFou3MDby/KnX5cjX5Tml/NBp2qmuqMhkYcIBn/S3FWHmuxzXtKEFiDtp/lgL3z3S
 FCqQPFttlYuHDMWvKLBud/7LWvzGIEImIG0fNiiROC37V+BiNue8BtJwA5p9Ap+hrXWKpJ93DRs
 rBz6I1hJFlV1eo3C0JmKU3Xx/AnsPjdOYegqTEcfW8ceKahiV2cb2/MeS8Q8yMq/UBnRWjrKYCp
 C9/jjbuxAvDOHBggr3AKY9PyaV30jF9MRQN7AUEfgFrJoFU9KAbCKq3qQhbHwG33Y/JnGQ6Xi8I
 X+fQZ/H9MbkdQh6fRScZmDrB42YtAr3qIPupoCuplyEhGyP83OAta97Q88yIKUT3X9XoKC/QSdz
 aceAd/2lLPciRM10RE0uvSZXKVRyaGm4rw4Kb9eybCoMn4xQM8P3BiG/4APq65Q4/jw3oRDQcif
 r55Z340LYLeiksQ5hYR6PSP1LTrVJO
X-Received: by 2002:a05:693c:6311:b0:35d:3351:1f06 with SMTP id
 5a478bee46e88-361a185ddf2mr14533628eec.14.1792463864027; 
 Mon, 19 Oct 2026 19:37:44 -0700 (PDT)
X-Received: by 2002:a05:693c:6311:b0:35d:3351:1f06 with SMTP id
 5a478bee46e88-361a185ddf2mr14533581eec.14.1792463863137; 
 Mon, 19 Oct 2026 19:37:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082b8573dsm36349143eec.25.2026.10.19.19.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:37:42 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/3] configs: qualcomm: Enable Gunyah exit on QCS615,
 QCM6490 and QCS8300
Date: Tue, 20 Oct 2026 08:07:36 +0530
Message-Id: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDT1moC/x3MPQqAMAxA4auUzAbagD94FXFoNWqWKqmKIt7d4
 vgN7z2QWIUTtOYB5VOSrDHDFQaGxceZUcZsIEuVs2RxPuLtF+RLdgyr1zFhw3UTSrKhJoYcbsq
 TXP+069/3A14S7LhkAAAA
X-Change-ID: 20261020-gunyah-exit-boards-8e78b520b72e
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792463859; l=825;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=JFKn114FVNtCmNNgomnpvQHSR21IUuDN25HWkV+CX4U=;
 b=IxsKI5kYSnjGWA/lx+e8BlpoXUkMKKWnZRuW/mn1pvNmLn1aE1KQU4xScetkPTAS6XysVkNyd
 7Xtzs92ZWiVC99dDPoPBgrj7zJKKYfldFUk89xizWlL6YUmnim6vhdQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 2rZv9S_geLQOx4-9EOpOXi8DYv0CEUtM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfXyEarBu/tSzn0
 /RGxLOLPAQ6P+aen1YdJcvlz2gd0X8TPxrYBBJiLVTehpGBPrfELlPEovrw4AoV1/leLEYM7+S2
 cMC2kuWd2LfxSLnGWzXxix7yRu7qt2gMQTUUYJMn6Gvg2nTl1rWcZ4IHWsnHJEHvmPCsYhtiPJe
 bAk8nIqj32n8TtxkvllTeC2cADiCAExMXqYllY3GUo6GsFdsRXBChRedpf6Z+G6iXazTBOClvNR
 NjUr60Liz5s3+2u4DxL83/cM1F17NOcgiEbhn6Jj7pr4slnjKF+qo3FACRbMtMQWBUkXMXi144h
 HHeTrtp6TuYzFaMzHSl8PJLGScH4ZsLn6ktlSfj0Yksixrxm/m2dmMqacKQ1bHptUXj8gHZdLyr
 chlfXYMG+VihpilgmUOD2IC9pknvxEsxrfGLywfY0FRpBo6EUHD2v/5maRSdxpu3hph2pe6+erT
 gK7wVL/ALjYZXuFh0Ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfX0dgQbw2HOgy2
 QXOiBR34u0m4WkFCtD9brT4jAEy81WLGGPZfLUbvfoCWqEpPpv1WT6ErH6EeZ49GI2DjOoI7Kof
 vUi+vcJi4+1IqKlSqOMzRRIey076ncw=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad6d3f8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rFyRrdJy-8HgLWQr4_oA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 2rZv9S_geLQOx4-9EOpOXi8DYv0CEUtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200010
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Include the exit-gunyah.config fragment in the QCS615, QCM6490 and
QCS8300 defconfigs so U-Boot leaves the Gunyah hypervisor early and
runs at EL2 on these boards.

This series depends on https://lore.kernel.org/u-boot/20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com/

---
Balaji Selvanathan (3):
      configs: qcom_qcs615: Enable Gunyah exit support
      configs: qcm6490: Enable Gunyah exit support
      configs: qcom_qcs8300: Enable Gunyah exit support

 configs/qcm6490_defconfig      | 1 +
 configs/qcom_qcs615_defconfig  | 1 +
 configs/qcom_qcs8300_defconfig | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: f8443f2c16e020caabba45a2af39c4bf3354533a
change-id: 20261020-gunyah-exit-boards-8e78b520b72e

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

