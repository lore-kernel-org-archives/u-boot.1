Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB0606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XT2lLUNI;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G2tic164;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kj0hQQyt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E62C607B8;
	Sun, 15 Nov 2026 06:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wH1hYot7SFk4; Sun, 15 Nov 2026 06:27:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69782607C9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794724035;
	b=l93961ZdtvifP30KjYzpqd8H2Ckyq75GaWKCBnTNiJ2PSFSRUKYNpdiGUpm1rwYLH56h
	 fKxTAeY2dZW8FWFwBO+q8TDEzqP1wJRS3nbak3vLAfd4uoBIb1iSg/QtWkS45gC+u5GFD
	 ++I2YkO8D/OH5P4QxEBh5huUSNgfVhH5xleAewPJhc46PbiuFr0samkC/xz3zO/qcSYfS
	 t7GG9a/U1C8rWftETtWW8dvrKX9c29ynmu81KHT15a0B22O+Ifae6CPoMq0LmQQ6YmsQ2
	 sI2bby3ydu4nZ8zeQdmG4RYSgI545mkA1uYtyB1qdbRuh1NkMrs6o0etvE3AqzW4Pcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794724035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S4kVPTVzCfvjcPvRW9aXCqe2vjRK4ILWZHsElfgBu2c=;
	b=Sy7RA5pXrP1wrU8KX2vlpESf9LV0TNRfMRqIVoj0Os8OHH9LPrv9SoJuG2jBtCqWGrqf
	 g3xGehbJtxQq2hckV3lybld7E0OlzhsYdUBcY8+p4efwn2BSalkEeV8CGHWVExeicXhS9
	 zshCzPU6aphMvlPCgNDC6T52LpzGURp6iA8bO5gISg9v/RkajoGHn6LezdE7GHi9aWAOV
	 Z1I4NAAJMMS2+ROPU7LaDN0g3491dLl3HjB4JyrVrIHURxjDV8O1YVpvYu26vrVZAFm2p
	 FMZN3bImnAgmWvZg94g0eaM3MpTdwgH2UbL6x4tgXHcMMR5dNDBR4kSyGO9yNJh6Myg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794724035;
	bh=S4kVPTVzCfvjcPvRW9aXCqe2vjRK4ILWZHsElfgBu2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XT2lLUNInVsYXIrcvaeleiqFidz1gjyEdv/vZw8uWHyRHgDW5iTziqx6hMNyawi1G
	 iRlgm9NykV2zDTiwKLscvlLA3FEtQk1DvXTDCOOAgIiNOVM6EhRgiuSx2eX3Q9y3CM
	 cnPZc2s3awKH1HKuSJ2SmclLbmxJtRq43/tWmwhKcw4XcKf3iscdwb6pnVQnN2Qq7i
	 X5FwmrbNpgNsqhEMWPUnmVnQHbIWI5N26Ww9t1GRMujCtqnCCIa0kM20OkAs/SjZmk
	 IRj7XyHGqWzi3MJabN+bW0Uyno/k0c0zbjACCjdsNf8fnLNIvdqwC6P6Oxpz8Mo17f
	 5ZlJMGVlyGOLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69782607C9;
	Sun, 15 Nov 2026 06:27:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 077992E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE34A406D9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6QByJZ-xiRV1 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:27:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 49700406DA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=G2tic164; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kj0hQQyt
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49700406DA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:11 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4THqg1234881
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S4kVPTVzCfvjcPvRW9aXCqe2vjRK4ILWZHsElfgBu2c=; b=G2tic164fCdiW2Bt
 qF7MzL5iyIZMltiXWrFiRhOKcxLc0VRzdxIQuVzP+ErbIgsdqkUQ1NY5rWsZXU9R
 BtjQvbK0bGAo4HEXX9c0OzsCtTK62YuQaRAtfiQyD9R4TjcERacvrNPlE4gTXAN/
 FQMQA6WNGUmShOGHY5K4qLENH/kWpfRpjMljae5mJJzjWiUUHl7CPBEcLTCYyIXo
 JPqjLSF5dCo9FmnLQXRKWux8TFtwMi1nfrlJYPsj3NC8ippfS1sT0wfX4om7D0hd
 uvZi2pkiVokjmmvrQdSDv3gSM5LSDpEaAKufx8b0QZBBlinlbT0h5xtTXgG/lsTZ
 z9j0WQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwabju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso2677215eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794724031; x=1795328831;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S4kVPTVzCfvjcPvRW9aXCqe2vjRK4ILWZHsElfgBu2c=;
 b=kj0hQQytVXs3qJKaGZylCbZ24xmr5iL6vXoFK+qvOWr0LWnKQTqoetn5ZZrCxXMUUN
 G1tg7Ga6LDP2bcoiDidSBTjjl/7T/vjgwCql6z4OSMpiXAbJ7DUogOZ9DDUhuXnY4WnF
 XiZjYh+3DIOxKJ0NHEHWIuxq8mKCrUbyTcgkErOiXV5kGOZl7KhJok9HrY7TUkfjZfeM
 hxzxAObHwaO+IxImD8R1HFw7Vd7CC1s+/M6J/UoJ+NyG9FgPj1ftO7oXW5OsPkbpg7TC
 7jyyMLRBHfgSAtAWrGhqAttOX4hAxTPgZTeqXEH5yv2YDJn3C7GQfZ4nGmWuhtHpcuj4
 OZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794724031; x=1795328831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S4kVPTVzCfvjcPvRW9aXCqe2vjRK4ILWZHsElfgBu2c=;
 b=Lmvex2eLoEjtnN++b+uw1cFd9ZRjJF0ZS53G9iyO5QtYFcAsVEZcSYMILT1/xnOtfw
 gmxIevVJiC/udJ0oS7lc7OetO78VCJMmFvpgJGqUbebN6QwP+67jWhRLud8k/IsRPK43
 d7VRO6J2elr7V0npXkIqTUn9cjR0P0mlbgfjuOG6B/i1N3RnKFF0WXg52PaOcDopqYUh
 91QclKiTa4a6KD5ZuSFDuDU0Qc+jk8lrqwihByhh8i+dOSqkC+W+nfUxS6p/hBKq4NNm
 QCbszFvyxt9JaMNbozkqX4jFxcBgflPIVsbkmP5+qBg6EPyB5dFCoftpDY5eIFVbF4WM
 hSsw==
X-Gm-Message-State: APuU4Z9a35jJYQwTQWmTa69IGZuUc51WMxRKG0WuXfj+f+p68UNWwjfD
 gptOu7vInbRb//Wwa+EquyFLBzGivRU2G47H+yKQM0o3tDVWCfAq+gdxp+pF5/aGx31nDpSzA2c
 6eCMXYrmZ2NUpRM3xV8rOFMakyFTe/P8yZibSD4x5V+CK0RFvhgBPEMePO+VDs6X6TeImQnU=
X-Gm-Gg: AYBFou0jw41vY9TlOW2J3KhiAcqnG+8MTLIW05hTeq1ksIOoW284lfxckVNtptmCwWU
 zOyZssxRWmTqxYVbvx7UYVlmime+gI4VLKYML2Fd3H8uDVJZSBOZzKu4MARTJARui5wcGVwWVEK
 uEJF7OTHU01sJXUJXbxHfS2VD7IC3xfffWSpVQTcLFjnzmgB3zZwFudKjLjsHlI0aYjOSeuanQd
 ASXEHEWkyFI+SZpZp9L+UlGuu+dmcXjcjIc4TReXqbqa24BDjLluwfoVK9mmecGPJfmLWNdTltd
 86xWAAkvrLO3iCJ5kUiWhK3iRMF9sZBbYiil5sQBlKi6+9suZ73QJgFN+PNG9vzpK9vlJAsizUp
 qYpUtG9GexavnYBErzRqz5VstrRlWBoAfXeurhoGnqezhFAWuztIgvHqIsH5Pjp2l6ad3m1/lbJ
 cocfkiTwf10mKZlZas3Paa1/VCmsTSh52Dw65Q/QW1S5vgdhhSuwbVz2N/jsW36KuTWk/VzFzv/
 KlD
X-Received: by 2002:a05:7022:1088:b0:1b2:581d:5dc7 with SMTP id
 a92af1059eb24-1b4f5f82c02mr8590980c88.25.1794724030507; 
 Sat, 14 Nov 2026 22:27:10 -0800 (PST)
X-Received: by 2002:a05:7022:1088:b0:1b2:581d:5dc7 with SMTP id
 a92af1059eb24-1b4f5f82c02mr8590965c88.25.1794724029951; 
 Sat, 14 Nov 2026 22:27:09 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:27:09 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:10 +0530
Subject: [PATCH v5 8/8] test: dm: Add partition type GUID lookup test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-8-79e76209457b@oss.qualcomm.com>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
In-Reply-To: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Denis Mukhin <dmukhin@ford.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=3054;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uxDS/Cg1ImqyxaTPvGMtkbZ10/tMrQrZAqRb1pyKG2g=;
 b=kVgKeodH4m/EoYYS3bRYWQXLfWM4/1xzXAMiqnn5gB9Xra/YE9EYgCIj1VqjXjOS+vixOptlR
 eI7Y30B9s8PBxIvFqrLTLf/NatxguUHcf2aZmlyZcGfhYGA3lV4AUk2
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX3W3Ipz2TsANK
 iBLS7T6pNI2i2uo1IDvQk899hm81OPKsAx06T7/diMf1YKGr7eSZQwzByupXJ+u/RU6ksci6xzT
 Fw4XPUSNatkP268LsCvP1/01QGX466J6jHLdwR0UVAUQMlXbfDXnxEBg+6XwAaDADZ3kT6ov1n0
 6yt/nfBmXPiKT2gtYvHylH4h4eOwCuWgQT6ChetJeGTl98wBD7Aswi3uW5VrqxUbBTRyMyetyLE
 cT9m5K7xG9NPDJh5r+UEENk4JhOzwycuT0L+FgLng3l8OHyl74ob+U+AkvCVUZH/fkHmGjf6h88
 ewUenA5uFBsw1tn5zOY4E+Q0yPlEhXm2PioN/MJhrujISG883OW8DEGTKXrWp3VQMyHasCQ9N6g
 DqjFm5ROKvYN1nrwuYJ2GDr+SEyDd9WjSvYFVpK64Gdh+UlgVPIKekOXWY55zKGyw0K7JbwEr73
 7BJbhZpGJrWq9L8GTpg==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af950bf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=QOCIwyBpk6KF-oVkDwMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: tVc-1lBoOYTtYclpEm_IUcIWxJvu2CqP
X-Proofpoint-ORIG-GUID: tVc-1lBoOYTtYclpEm_IUcIWxJvu2CqP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX/g6lGlRoLYtK
 C2MC5TyG98Vg70s+dNdtZ8odsdxgln94czLC6HPn00+w8pS6i+kX+d+WRRMWHnUdDiNihBaYL10
 xr/G1UC/HU6ZV2ZOMbuJV4qN2aAayNg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150025
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a unit test for the partition type GUID lookup functionality. The
test verifies that partitions can be correctly identified by their type
GUID, specifically testing the ChromeOS kernel partition lookup.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Check the type GUID and size of the matched partition instead of
  its name, as the test image has no partition labels

Changes in v4:
- Return -EAGAIN instead of EOPNOTSUPP
- Add extra asserts for kernel partition

Changes in v3:
- Add unit test for the partition type GUID lookup functionality
---
 test/dm/part.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/test/dm/part.c b/test/dm/part.c
index ad37d7f406f..11c3d72f09b 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -8,9 +8,13 @@
 #include <mmc.h>
 #include <part.h>
 #include <part_efi.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
 #include <dm/test.h>
 #include <test/ut.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static int do_test(struct unit_test_state *uts, int expected,
 		   const char *part_str, bool whole)
 {
@@ -248,3 +252,51 @@ static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_get_info_by_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_part_get_info_by_type_guid(struct unit_test_state *uts)
+{
+	struct udevice *dev, *blk_dev;
+	struct blk_desc *desc;
+	struct disk_partition info;
+	ofnode root, node;
+	int partnum;
+
+	if (!IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
+		return -EAGAIN;
+
+	/* Bind the mmc5 node (ChromeOS image with type GUIDs) */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, "mmc5");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	/* Get the MMC device (probes it), then walk MMC -> BLK parent link */
+	ut_assertok(uclass_get_device_by_seq(UCLASS_MMC, 5, &dev));
+	ut_assertok(blk_get_from_parent(dev, &blk_dev));
+	desc = dev_get_uclass_plat(blk_dev);
+	ut_assert(desc);
+
+	/*
+	 * Test: look up the first ChromeOS kernel partition by type GUID.
+	 * In the ChromeOS image KERN_A is the first partition carrying the
+	 * ChromeOS kernel type GUID (fe3a2a5d-...). This is partition 2.
+	 */
+	partnum = part_get_info_by_type_guid(desc,
+					     "FE3A2A5D-4F32-41A7-B725-ACCC3285A309",
+					     &info);
+	ut_asserteq(2, partnum);
+	ut_assert(!strcasecmp("fe3a2a5d-4f32-41a7-b725-accc3285a309",
+			      disk_partition_type_guid(&info)));
+	/* KERN_A is 1MiB */
+	ut_asserteq(2048, info.size);
+
+	/* Test: non-existent GUID must return -ENOENT */
+	ut_asserteq(-ENOENT,
+		    part_get_info_by_type_guid(desc,
+					       "00000000-0000-0000-0000-000000000000",
+					       &info));
+
+	return 0;
+}
+
+DM_TEST(dm_test_part_get_info_by_type_guid, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.34.1

