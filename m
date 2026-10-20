Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25647606A323
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rJVAnprE;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jL1dZnnc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EdF+gO+y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00175608C8;
	Tue, 20 Oct 2026 15:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lc64o8GhBoFT; Tue, 20 Oct 2026 15:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B512A6085D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792510726;
	b=hg4+A6QazBPevV/OylYs4fOZN+UjK10cFNlVMRPTNj6S90kTqR3jqs7kQ9dKYaJvfS3M
	 e7aWM1XBHVrFR9y9P+5cRr/i9cwS4aUdfXYczYeuweaTWbuMPD1b7gVAFkvAfA+5YXzs4
	 GG/2xe3EOWgJJyOO4h9B/qhNibESMGXXXdgYWmpiGzSd6tJAaocaRFYKQO7v7NJpJlmeV
	 QE/nB0/WKgRgJzXfqDBI6qDaoCFDITFFpK8pC8+EkytAujpodf1uHF/4KqPCfWUEI1WSR
	 FCOO6FP8b/jGyfMjkbtPkZaN+cM4+kohL0T8QzLB15vwyEobbMhfiwQOeKok+Y3c6sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792510726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aakpRDaZgz5lInaprZjykvUJtnlrhCLu4FJXB7JP4oI=;
	b=Z1AE+JxLCgCkU6bSfQ7HEY9vCe7dZxgVwqlsATGk3WmmuaNRSso+aPkE2MLPOPpy098K
	 DC61WkJ/qVDN7cdfZ+QNXvcKwAuKjT96AkxU0il6J8xaSrNmi8wyY/Fpg/LWZSOQWZ6Kt
	 uBj+vFOIjd3DIQdHXEhpbdXrvp+gdG2EQFcIF2GYdu5i8XKX7byG7t3Tib85va278unGa
	 zQC95oKDVY+8/12W4KQG+l/wxOAfC8vJ8rDhJucDNYGeaLYD/Xi2pELq+0OinEZX3uW+z
	 ZnpTcv/c45cWt+1o9nK80pRLcIBZVFqehRqfadnaaC9gboeKI8dTKF8gG51Fxv3RWUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jL1dZnnc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EdF+gO+y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792510726;
	bh=aakpRDaZgz5lInaprZjykvUJtnlrhCLu4FJXB7JP4oI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rJVAnprEy4VmVrqw+EobScA/oOAmKUtQ/y4DPuqcLv0/zrGB/I5zI9z80Bu6g1jcK
	 dhRrpA4JZsiA197i0popm2xzg7mkjNwOxBPntD2AV9FCVXoTRvj0Y/Fvk6O2fYvoz4
	 g61mvggkkh19DCbfxlxzv2cqP0r3pqUJKDgvTL286RdOWlxZWPsSABi4uVfJnlmrAl
	 3tYrYjaUV4Ad+mUd4XA8TMDvDQbR0IzlpOEI/mzf7OhIJv2eeKu7nGWDizlUSMsGME
	 1BMMzNOQhczzhTOkdj8Zx5ACH3rABtkv5hCKcxLAmEr9k2J5eqShAEJtQW5YlYsdmB
	 wfyGlF7pIcYOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B512A6085D;
	Tue, 20 Oct 2026 15:38:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F72B1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3297A608AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJ5Ag6imbinu for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:38:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 348B26084C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792510720;
 b=YyzPXTICwg5PsXumch56ZZAMY9H/VM3b4qLsqhtevdiXfxS6yEbJZnRlS9vhyrx2eZtO
 IBGTZp+tW6/r9OqPQFOOP7h/1ydRq3Od7dPigeP9XoOSfw4v/bApuDTPSPiGlP0CKKbBI
 +NEnHKTB9ke5DtM9B6MeZNCtCvRKxf2xBmMYqeOIVE0Lcx+PrghOyQwY/989eMPLEB92X
 hsSXpRJmp8bY0UwPENe2cBjrxgiOEX1sM9DSqNQYZFEJadLveaXX3jWOxCN9iQalT6qaY
 k4UvvQBfEtFlipMC6FKTRWnvOS/A2LuTQdecqC+uzYOLbGqWcymMGxsw4vIzUF+esJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792510720;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=aakpRDaZgz5lInaprZjykvUJtnlrhCLu4FJXB7JP4oI=;
 b=S5LsGvqY9D662ngpC/EwfsIZSUeSSK0mTf1V9g42RmCiu9Klm8BWUWdtgKI7VDslaL3r
 7Tf58qoHZJr7i5fl/E9T+gcLbmNR9swSkwj9tVbiMiY+HRnnX6X2UZQz+GLfna9+ereQd
 ud9THnA8r36e2Z3jU9qZYFpuP9VikGKd3So2VhJIrP4dKW4dZdQ/nkCaQLqa0nsqG4in7
 86AGwVgA+IGzSMTsXDNLYtAkQm7tTcz52Jdy6iS79gwzD0rWHnKgpR28XfGLHvSK5A2B3
 vrNIfORZk6BaS/xynH7YTtbpKwLs2Xuz1rkIBpoA3twAYXVUgAM/vMm4wZkLQYrh5vA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jL1dZnnc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EdF+gO+y; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jL1dZnnc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EdF+gO+y
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 348B26084C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KFDlk92569313
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aakpRDaZgz5lInaprZjykvUJtnlrhCLu4FJXB7JP4oI=; b=jL1dZnncc8LiiOXV
 4mo5DkvWJJ4FeusATbwK4RVHGHhnI+RWSl/nw+nWua5/oQ9OUanVRMG1TnlkC6N/
 rKSi9j0c9jJio2Qfojp5ZLgxWxoUB2hx0IwD4iPzQpqukB2EkqZy3QDx15UOPunz
 E4Xu1DXpiVvFla73xNkfEh3sEDUiFCTTf0DgAgqDG+LozwOECtDcU25a/S5pGD5h
 NNLQoiRG+RHrDnhriYUNWdfdw2q5fc4Yeba67Z4B91EvKakbhhskZ4k3VdCVyyht
 G0NK/KPUxdECKVcETsh6OA6eeZatnBiT37x8WRv/WK9xF+juwH9ing3BzTHS6fqv
 sKfUSw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pk6v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f13c143c8so630212385a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510718; x=1793115518;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aakpRDaZgz5lInaprZjykvUJtnlrhCLu4FJXB7JP4oI=;
 b=EdF+gO+y3Wp7Kl7imBb3VYjNJvVTzO1H3fZ8bL6JuB+J1Otq4gHXORAeJr3LIVVRrl
 7RYAgV91aLv+AcmnEbB6XyARcdGm/lqZ8SVwnLE3/gwQaPkP+66a+9dpM2t0Q8H4FCOG
 FHVNH9vyVBh3MJdvGSWnlaZbt1Sy8D/1wvRKThjYkO9aV68qICC2qH5J8j0BMYHqP+NM
 l41gh/BHcFFNaUfQOW4SQ7tu5x7yXR0ajBjtxFNMUm4H5yzDgxlqtOfOBdBxNwGi/5oX
 CQVwVfBmv6INYBslXhmLUVhy6nBYJAEfZOsZ4r2n2chzxjyNSxcF679HBMbfDSYkxXiy
 UzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510718; x=1793115518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aakpRDaZgz5lInaprZjykvUJtnlrhCLu4FJXB7JP4oI=;
 b=S9c2dozukbsbpuCQuI3yzdWpRQ+4d5yri7fseUBzdiuGEHidVOGXQ5JFUq2cMNY6Sg
 lwd0MtCeLcEfc3Qm5S7lruUQP/ecMGXlGIKZqdZcdTcE0brQN7Y1jUpX+PqrUQDrOfG8
 1HbqXAcG5n33HdqPQE+K9uTcf0dJHnsIb1vRSST9zIZM0GaB3+bNC1rYvkMTJix6kJ+J
 TpJQmCLqDauaJncG5Muhcr6vnkz6vwTxtOrwe+dqGypVzNTwDgWtQ2nAtFN/6McXHddT
 u1YWC8+tZjzmzF81AbcKd6LuX9uhsmHlT7xzY0aqQ6ghijwKAcQMV8KIquyLbAQb+vEJ
 XpBA==
X-Forwarded-Encrypted: i=1;
 AKwUvByIn/u5a5OkVEUnDMzmIWdtdairmOTs+N7tBHW6LCEOsJUWUYOV5imL06N72b43M8wxdeRuC30=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ7RWaYWUQXfxD9wpt9W3DJCQ4FkMPhtvQkWyWiLtC6BRpjSI/h
 T8UNjTl97pD8lejKwTvPvYIv6Zsq2RInr5tjDIQJiiKgbun1u1vgfhQczKI2FZyDyNC0qo/M2OB
 uPNJJ6mBn897h3uq4hCP5SpmSAjsPkooysOGZG8U+akJgCgwXZZJhGK68YX22UXs3pXVFndM=
X-Gm-Gg: AYBFou3blT+CZBxBFvXCVFkRC1CuyPotXWeLgSGRhSV1Ecq1V/s/K1so6UsdrOrO6Fw
 AclkhRu4fonvs58GNe4yl3lT8H/eUGuWdabLyFmdT26uJ0mUp8vYAOwH1cHTr+cj/xMr0V01Gem
 uVriZW69LGx/yjbyyLvCZubu57ETDuZjLhjiTorzMXlI2E7HW2SejUVD4MdQblU+eozvUNK4JF7
 nbk/K/aRjlx8/xtrij01HmXr+GV6CSsVENak4ftSBqgQZLF48CrG0KvzxE8F6sMoIx58VcwpE+e
 0Vzy8r46MY4tpx66PxFszUge6j1wCvWAhu/CZys9serx6ClPpCB0mO4EkzD7FVmIHX45gbZnXSZ
 RrxG9ewBXqMW48M2U6Oybe5WE7p0SMeDIxFcu0v/XOyHi
X-Received: by 2002:a05:620a:d85:b0:93c:8544:6adc with SMTP id
 af79cd13be357-93f29cc926bmr1874959885a.18.1792510718120; 
 Tue, 20 Oct 2026 08:38:38 -0700 (PDT)
X-Received: by 2002:a05:620a:d85:b0:93c:8544:6adc with SMTP id
 af79cd13be357-93f29cc926bmr1874955785a.18.1792510717543; 
 Tue, 20 Oct 2026 08:38:37 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b140fsm5574963a12.9.2026.10.20.08.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:38:36 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 17:38:12 +0200
Subject: [PATCH v3 5/5] doc: android/avb2: document the root key
 provisioning and lock state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-upstream-avb_lock_unlock_b4-v3-5-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=a7WlZkSF c=1 sm=1 tr=0 ts=6ad78afe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=DnaZGjYjaaDC2aZnHNgA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: wxCM_HAjnFBppNpykaKNDi1cXO0BiTCn
X-Proofpoint-GUID: wxCM_HAjnFBppNpykaKNDi1cXO0BiTCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXxpfQ+2A+ycUk
 a1KX9fSnSUGcxqDZ8GQEu9LO7T9BQ136EhBrhbxt3OBwRkAgckWpUF+aXXEVjcDUv3wWarialI9
 fNyRnNzzGK+dtis7Wnod/9/Pvl7SBvx1vNhCJR3fhPBDifnYlak0uh4BLA+gro92x16MYiQ2CPq
 FyYX++Ko0kvaolfCTn4llVoBjP90+xaxbv9KgDYWkyFw5fGjF2ewmZ5D6U6Txgr/cS90+eBSEfU
 VMj3YpOndk8uAUXHcDC8B1P6ah7y81kPUR6NmF02D29GAWxriwl2xk3iiFXU+o9rF4VIjR1yHb/
 /e/+otxf1vJRj+au18Ir1FPQ7m4DsGoegZS2Jo+2stiZxjDuA4co3LmQRK0nG+/KYEa+DgGuspd
 j4+EwGRufa3HDRBhANWBLNe2sxmYkRkSGKNhzGhLeDCWVaTnyP7WmdpywFazyyG2YU5UJDIrBUP
 2V3o3o2dfAXlwulomig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX5qfoYY3mKbZI
 E2NQC3wNzGt0xHRKvnw7krsVS8Q+t4CrJ5wL4zuSvS6puxrNO+/BrStGwXOd3NS7HdoMt8HCePX
 xjgQibOGYm59cif7sLXaWuXaI29sTK0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200062
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
how to derive the SHA-256 digest of the vbmeta signing key with avbtool
and provision it into the TEE persistent value with "avb write_pvalue_hex",
the fail-closed behaviour when it is missing, and the device lock state as
seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
mandatory userdata erase).

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 doc/android/avb2.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 43d5600d2d7..e1eb5b15f11 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -85,6 +85,68 @@ Note that device lock state and rollback protection are only enforced when
 backed by OP-TEE (see `AVB using OP-TEE (optional)`_); without it,
 verification is advisory regardless of the root key source.
 
+Provisioning the root key digest in the TEE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+With ``AVB_ROOT_KEY_TEE`` the trusted digest is the SHA-256 of the public key
+in the AVB key format (the 1032-byte blob for a 4096-bit RSA key, the same
+encoding that vbmeta embeds), not of the PEM file. Compute it on the host from
+the private key used to sign vbmeta::
+
+   $ avbtool extract_public_key --key key.pem --output key.avbpubkey
+   $ sha256sum key.avbpubkey
+   7728e30f50bfa5cea165f473175a08803f6a8346642b5aa10913e9d9e6defef6  key.avbpubkey
+
+and store it from the U-Boot shell as the named persistent value, which the
+AVB TA keeps in RPMB-backed secure storage::
+
+   => avb init 0
+   => avb write_pvalue_hex avb.root_pub_digest 7728e30f...defef6
+   => avb read_pvalue_hex avb.root_pub_digest 32
+
+Until the value exists, ``avb verify`` and the Android bootmeth fail with
+"Public keys are not accepted"; a wrong digest is rejected the same way; the
+value persists across reboots. Provisioning is a one-time factory step and
+should happen before the device is locked; see the note above on protecting
+the value from normal-world writes.
+
+Device lock state
+-----------------
+
+The AVB TA stores the device lock state next to the rollback indexes. A
+locked device refuses to boot on any verification error and reports
+``androidboot.verifiedbootstate=green``; an unlocked device boots with
+verification errors tolerated (``orange``) and rollback protection off.
+Changing the state resets all rollback indexes in the TA.
+
+From the U-Boot shell::
+
+   => avb init 0
+   => avb lock
+   => avb unlock
+   => avb is_unlocked
+
+Over fastboot, with ``CONFIG_FASTBOOT_CMD_FLASHING``, using the standard
+Android commands::
+
+   $ fastboot flashing get_unlock_ability    # OKAY 1
+   $ fastboot flashing unlock                # erases userdata and metadata first
+   $ fastboot flashing lock                  # likewise
+   $ fastboot getvar unlocked                # yes / no
+
+As AVB requires, both transitions erase userdata (and metadata) before the
+state changes and are refused if userdata cannot be erased. On slow
+(emulated) storage the erase can take minutes; a TCP client may time out
+meanwhile, the device still completes the operation.
+
+While the device is locked, ``fastboot flash`` and ``fastboot erase`` are
+refused; ``flashing unlock`` is the only way to change its partitions.
+``get_unlock_ability`` reports the "OEM unlocking" developer setting Android
+keeps in the last byte of the frp partition on the fastboot flash device:
+``flashing unlock`` is refused unless that setting is enabled. A device
+without an frp partition (or a flash back end without a partition table) can
+always be unlocked.
+
 AVB 2.0 U-Boot shell commands
 -----------------------------
 
@@ -105,6 +167,13 @@ different testing purposes::
         <partname> by <offset> using data from <addr>
     avb read_pvalue <name> <bytes> - read a persistent value <name>
     avb write_pvalue <name> <value> - write a persistent value <name>
+    avb read_pvalue_hex <name> <bytes> - read a persistent value <name>
+        and print it as hex
+    avb write_pvalue_hex <name> <hex> - write the bytes given as a hex
+        string to persistent value <name>
+    avb lock - lock the device (verification errors stop the boot);
+        resets all rollback indexes
+    avb unlock - unlock the device; resets all rollback indexes
     avb verify [slot_suffix] - run verification process using hash data
         from vbmeta structure
         [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)
@@ -146,6 +215,12 @@ OP-TEE::
    CONFIG_OPTEE_TA_AVB=y
    CONFIG_SUPPORT_EMMC_RPMB=y
 
+and, to take the root key digest from the TEE and to lock/unlock over
+fastboot::
+
+   CONFIG_AVB_ROOT_KEY_TEE=y
+   CONFIG_FASTBOOT_CMD_FLASHING=y
+
 Then add ``avb verify`` invocation to your android boot sequence of commands,
 e.g.::
 

-- 
2.53.0

