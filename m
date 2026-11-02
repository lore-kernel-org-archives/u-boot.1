Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4D606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ykvINz+J;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PZWohXD3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bde6goio
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1A3C405ED;
	Mon,  2 Nov 2026 05:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id co8tFO2NVkGf; Mon,  2 Nov 2026 05:48:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7DFCD405F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598533;
	b=fbKNe8MjwcBOgMlBjmIekd6lKlBpIukVcPTEUg0VPYImvFWjNWlRa5ORoKvKRog/wbqn
	 TVtWkc4JtElLpT+aDg8zqAZqQWclq5dFjrT3BL0+35rUDxLaWqgwfff53j45DyQvleQpb
	 65kOqw4nQmaWDuh+advqcYlqR/Af0YUVZyVixl0d3djBbuOmSi1LTVRE3LvlsYHSK8glZ
	 ebFuZbLXnwaEZYMgJDTm5st5PK0tKdkKLDCcquxmqS8oNs84CnqXs1DogVq3bKAljB0FE
	 lHhONTAz/ip8kpPTUkPMh2AVMcPEwleHPsEQy2P1cC9RzwSL3ov3uYL+mtYHK5lD7Jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
	b=KVxH3fl8Keg/tWNxVbpxVHrCOFBOj0AWTWneDlxWFZlLTv3Xe2r7DCYJ6k/d1pqgKSJh
	 Z6sB6n7iGUSuzNeCrYxSs/3riG4g9jxTmiwBN0olzzH/tbpqPeXwK3ntaMDA8i2im88kC
	 kZBZocoZ0lntEEJ03TX4tNj60lQo1IaURBXk20hR82zgyPzSowksoCqCVmbZiXEB6DbIi
	 McTFand3lrBLxhwfWPmBTgqlKZsMn9ahUmKY0LGaJo2Iey2NNKu5T9QnlebNfRoYflydU
	 v0I778MhxO67LVSxr7vjq5C7NooFcjEKU8Q74H7mdRfgPZX7JHiMvL7vdTfkuhVEykA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PZWohXD3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bde6goio;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598533;
	bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ykvINz+JBL+WWMlj1GksQWpffwQWM8vRV16nFWN9jOOW/Ba4M7DaPV7NBhvibYFd8
	 QKsMier33qYf6/DpAmNy3ozWtjf1b9sbCEtru/R2lwBoHDN7HuGe/OfAXO4FbI0GaE
	 68fg7lsJgbQQNOYjW2J9YbXyFImJ38Dv117faIoefx38b9VhqpklXu/svZ2fMI2BnX
	 vAvPDeqCphwuPw6bGnGxikT67kBJbHnoGFDHW6G+MCsBa4x+TgHYtkn49o3KPzfX97
	 750NqhCvjCcsprRlphfsuJyol+hpfN9KwxCn3J046B9gkx1lCNNBw3Sx3EPhh0Q+7/
	 /GR2JjRd3UljA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DFCD405F0;
	Mon,  2 Nov 2026 05:48:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6841B323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 595AD405F0
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5n2BqaAeqLiE for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74450405ED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598531;
 b=K60iffT2p6BNKzYm2YlHzGTGNXo9cJw3YiQrKOGn2nJ5djA5qY1S0EVrqaC8CoXvxTuS
 IRBljxL8PyGqc7wC6SfbllDngm3RBcGzj+lszI01t4+d/q0LCNJUNJp+kHz8m6C8Lv9F1
 jPEnY/VbafZfk0f0XmZ7lRSX0UNHaOUSSjfQsJ+UVbBY/xHaY3xNgTMvIU/WG5OrDIhIN
 vGmJyU/vqAjI3n8vKjCfJJ3OyB/Sp2TnpEa9SkMmCGQNh9htVuwlNb0Pq4DhCvg1X2fFW
 szi8hZqsaKPH82gSiesv+p05NY8jYjOeacWz/lJ+8t933IPgyXLo1bwCEZ/RRttQ73w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598531;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=VK6gcXZTjWs3AY/kKcQNfNDbppFChclqXZapuJOPSpzYE1YsSMXGGk2e69dsiIXqqYX4
 mZoqVaYZGZZBPuJHkW36vLqgEWRsIC8pc3xyyqacPOKf64CR5bM0tfj1Vii0d612kiIKf
 4/FCzjbKSY6GEr9qHIOdbOf4QRcrC1CHArH+soz2jUccaGxZZK+jsJs8Zvk/VxQdgTT+Y
 WPv3p5JKy/0rxZX6+PHCNaqFz+f7S7KVy/T5FkXVsEcwKhh3NeCdI85kZOvKKTtE4C4gq
 3TkJA6/hr8i23PIiOLvbJTtdfLXNneuvvf4G9rlXd8RwVYe7kw3o/XOblNtfxY0vg+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PZWohXD3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bde6goio; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=PZWohXD3; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bde6goio
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74450405ED
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:48:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A25Vs5e3924184
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=B3BAWWuwvVM+YbLBq+arqo
 UrzzSN9fGg1B2GeTos2qU=; b=PZWohXD33l7BpX9bCKq84bW2Rq33zB2JHLPa+q
 HjrRJ1PVjl3Up6KMVfKVnrzlwRkj9w2H2OtzUYzRdWInLcZcsLT8gLHLJE6/We7D
 15g35USyiwM5+jrrOYJRKkgAtYB6xqJ/EcDxuTURjNWiqzv47MvGmCOVgWan5Tzh
 PgbZMm41/hpJ4MgnDd3L7PSwyVp+rZH+t1qSGOnBum4xTV+UF8EZ9uST0uQWTjx0
 yTc4GTPjeZatUxo6XcKambZkL0T0LGLlxgVI+EwEFEDtmNldljcEp9WGmyA1oQgy
 KT4ohicouxRTAHqIg2UdtOxi4boE9ZZkbWtXUAwndKGfZ7Bg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1r1g5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:48:49 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so2525986c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598528; x=1794203328;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=bde6goioOpi889E4ZS4Xb9dk8h7zRWFPyYSYCHGOsg23kOCRuZmOA2SE+iBCzIf47N
 rZX63Z70GNpmuoVoPnkeA7k5Eb8XC4MzotEQNzy2MsiCXIQmSWkbmkfxXspoMb4nU6ZY
 juAsPkoTqxdaLd+WP/Cylut1B5ujBNr/QZY5a5kqjI7BxsTZEW5ORLxOLanbi8axM4lS
 2zNJBKMZ5em4QUxKlIUPw3Wttd9ToV4V307HnIThgiqpTufiYdJhAQLykNqk4FYi+Vsg
 889GhgxRUHwuaKhCrBXy6hUW1T0fGcKpNvX67MELYgCOXi3GiNgD/RZeGSgnPPsicnAf
 G2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598528; x=1794203328;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=18L4vn0xvc/JEI/bD4j2FMPaH76yulP1fjlNrADfTisnwt6o79FaCRNuOuQgTPgek4
 esmQPBwNmjgaWL/hzGTF52MOMC48L7OGGx7WGp900mtf5qORiDMecTKDyW/tU2Oou/gJ
 j1MM9SMS8txw2q5mEVqJC4cBsXmFwCOervCOaPOEhSEjGwAFo0FkqYZyqYqNweIxRMpW
 uxhQG7XBjNEu+Qw7299+qqTO98w51wcTanmaZoj0BzHQS8XJBIJOPb56A3HQle6SXoM9
 QniaUyhqNCyNrn92esmda4lF+UAIJCe8Ha6+VOjDuq3vnh7V0OBsH/SPiUL2Hkef6WTL
 yrcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQns/cCGmyRpTKArN5zJUcz66hZhENCqBPQK06QK6gNKcKmsN2LTrHL3WXriWLvVm+la0CJ70=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJq1RDVFid1nC3fB9y50cYRHUArYNsv1dS3ISXl9yZln8MgW3Nk
 pHoHimr7TeZg00G5Y/FoXFiJ1mErGfnvHC2viMk5ba7WAbKLl4m5GbxXPrNl2UWeJC6mMnGe7bR
 JTtPJysy0rgneB1iaRwZu01FnxtW2UQ1ZMmNelqX7Kl+FDNuVbDEXpioJ8GOqcqlPshbB0kY=
X-Gm-Gg: AYBFou0qGV1o+t5KZ+Acyzh9P6Nf4MJmbNhoNEAiVmjRIbUETtcBNq5KGFWDgasljfo
 6rC5ZMEs5PkQRfh2btQGko0tvujGsHQfsIa0eidUgpjed4Pa/GiqJjl5CwSuwksi82YRHaQ+e0+
 8KgTzLTNUrgtpI/97GnZiGVO7SPmSfEQTCc37WMGspZzJjgJULc+oDf9SM0CP+iBdaSQaYNP9/s
 5Yy+/rvFvAhZLmn1WBO95ixVrpNr4Feud3KDgnd/BCgl3uJFaYEmhBNiZAxljY3Ebfa4AsbbzT5
 8ZOv+ffk2OExKszKvE3VK124IqjZDra0dNl0vlsg5TJAS0TZFLJg1hbTQGQSXMGm2/3QWK63Kij
 NlffR/41QuxgxoGJYnig6dZbjrySP7ZCz3w43E1OGHIfB1jGI5ci68ttC5FQ6t7eT7ldd9k9VHC
 ykxAVGmD/wejFpSeV6VfVI+f8fySl4nRFc93aNmoFykb7yIgkHQM3LtZOUmuODM04u2RbeS3miC
 cTB0A==
X-Received: by 2002:a05:701b:4192:10b0:1a3:8d5f:6f93 with SMTP id
 a92af1059eb24-1ac5c8369cbmr13636197c88.17.1793598528283; 
 Sun, 01 Nov 2026 21:48:48 -0800 (PST)
X-Received: by 2002:a05:701b:4192:10b0:1a3:8d5f:6f93 with SMTP id
 a92af1059eb24-1ac5c8369cbmr13636130c88.17.1793598527495; 
 Sun, 01 Nov 2026 21:48:47 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:48:46 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH RESEND v10 00/15] Qualcomm IPQ5210 SoC bringup
Date: Mon, 02 Nov 2026 11:18:32 +0530
Message-Id: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 1J9WVujEwOeIJUFuHF17oaCrLv4iR6PM
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae82441 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=voM4FWlXAAAA:8 a=YfCOm-DyAAAA:8
 a=7l9ilokc8PBLwnsvYBYA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=IC2XNlieTeVoXbcui8wp:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX4wecFeWbGyWb
 zjFzmKBOQxehAkNURSMNM8GjUxXXra677qJgYJcGCmttShxxdzuh5cFunUrDz2aY6SvGMIDvzjT
 k90J7TUPd7/KsKuV0ri7o7yFQ2VV/ztdT5OiYRXnP85OE4j1YKg4b0WfJ6JxeEPsysWkqM7j2Xq
 YH9shKbk0pb1yrjpqzXJ0HFT9H+frJuBJHm9UsbePrIDY5nz+CCUzCnopPixPHAuXeqjBMHHmx8
 wJQgP28O1emcqhNPBJolbfMX0YgylPCHezUDPysIvDCTgmHbeqZmVGXmmPeNRHpN0GppYTrY/2/
 wL7mdt5mMJf7IVhzrO3M/G1AByvD1cwEHRSIcUsS/FlxbEyVmThVHT4rVUogNTAQUG4oSxYAOzh
 QDWiEO8BtkRipxwyovffZiNSLQp3GwqbeSgcQMLhZ3c1Y6HBYOUNbZ049GSYP/++7Wvx0HaP4kq
 POxPSVMjTxBIcxOu+Hw==
X-Proofpoint-GUID: 1J9WVujEwOeIJUFuHF17oaCrLv4iR6PM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX1Y6kOhn4C4F8
 UN8NItIUIXAjnzIrriURDO1S2+ow+YxoKNsZcKcofxG8aaHEJ+d5JtO1uxme6VqRdmnJWujBpbf
 rS13sPmlHKwGj1EdMMNwbfj0AsUjXV8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020022
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.

The relevant DT files are available in linux-next [1] & [2]

Working features, as tested on RDP504:
	* Serial console
	* UART
	* MMC
	* Boot sequence transitions from Boot ROM to U-Boot SPL, proprietary
	  binaries (a.k.a QCLib) load and execute as appropriate and eventual
	  jump to U-Boot.
	* The QCLib handles
		- DDR initialization
		- Clock setup

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq5210-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq5210-gcc.h
2 - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Changes in v10:
- Update board/qualcomm/config.mk to work with v3 of mkmbn series
  (https://lore.kernel.org/u-boot/20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com/)
- Fix mailing list e-mail id problem
- Since v9 was sent to old denx mailing list, lore URL is not available.
  Please use the patchwork link below. Apologies for the inconvenience.
- Link to v9: https://patchwork.ozlabs.org/project/uboot/list/?series=523494

v9:	- RESENd because sent to old denx mailing list
	- Address review feedback
	- Move qclib handling to separate file with some functionality as
	  'weak' functions to allow SoC implementations to override it
	- Link to v8: https://lore.kernel.org/u-boot/20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com/

v8:	- Rebased on https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
	- Address Casey's review comments on v6
	- Spin off GENI Minicore support and mkmbn support as separate patches
		[PATCH] misc: qcom_geni: Add minicore support - [a]
		[PATCH 0/3] tools: qcom: mkmbn: Updates to support ipq5210 - [b]
	- Re-organize the functions from spl.c into board_spl.c and fit-handler.c
	  and remove spl.c
	- Retained R-b tags since the code just moved
	- Removed references to MBN and multi-elf creation steps in rdp.rst since
	  mkmbn.py takes care of it
	- Add details about the interface table in doc/board/qualcomm/spl-qclib.rst
	- May need to update config.mk based on the final shape of mkmbn patches [b]

	a - https://patchwork.ozlabs.org/project/uboot/list/?series=514770
	b - https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

v7:	- Fix inadvertant typo in doc/board/qualcomm/rdp.rst
	- Pick multiple R-b tags
	- No code changes

v6:	- Move binman related changes to separate series, so that the
	  SPL changes can move forward.
	- Restore v3 build steps for now
	- https://lore.kernel.org/u-boot/20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com/

v5:	- Reorganize SPL related code into common and SoC specific functions
	  to allow SoCs to customize according to their boot flow
	- Fix documentation related build errors
	- Please see the patches for specific changes
	- https://lore.kernel.org/u-boot/20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com/

v4:	- Add binman based image creation support instead of special scripts
	- Identify boot media based on PBL shared info instead of CONFIG_xxx
	- Address v3 feedback (see individual patch for details)
	- https://lore.kernel.org/u-boot/20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com/

v3:	- Move stack range
	- Split spl.c patch
	- Move documentation towards the end of the series
	- Pick couple of R-b
	- https://lore.kernel.org/u-boot/20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com/

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
	- https://lore.kernel.org/u-boot/20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com/

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

---
Varadarajan Narayanan (15):
      misc: qcom_geni: Add minicore support
      mach-snapdragon: Kconfig: Auto select options based on configs
      mach-snapdragon: Add PBL shared data defines
      mach-snapdragon: spl: Update boot device information in SMEM
      mach-snapdragon: spl: Add support for MMC booting in SPL
      mach-snapdragon: Kconfig: Add rules to create SPL images
      mach-snapdragon: spl: Load next stage FIT image
      mach-snapdragon: spl: Add DDR initialization support
      mach-snapdragon: Add Qclib handling support
      dts: ipq5210-rdp504-u-boot: add override dtsi
      clk/qcom: add clock driver for ipq5210
      pinctrl: qcom: Add ipq5210 pinctrl driver
      mach-snapdragon: spl: ipq5210: Add SPL support
      configs: Add qcom_ipq5210_mmc_defconfig
      doc: board/qualcomm: Update RDP build instructions

 arch/arm/Kconfig                                |  12 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi         |  12 +
 arch/arm/mach-snapdragon/Kconfig                |   7 +
 arch/arm/mach-snapdragon/Makefile               |   3 +
 arch/arm/mach-snapdragon/board_spl.c            | 255 ++++++++++++++++-
 arch/arm/mach-snapdragon/fit-handler.c          | 131 +++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h   |  82 ++++++
 arch/arm/mach-snapdragon/include/mach/spl.h     |  13 +
 arch/arm/mach-snapdragon/pbl-shared-data.c      | 125 +++++++++
 arch/arm/mach-snapdragon/qclib.c                | 160 +++++++++++
 board/qualcomm/config.mk                        |  25 +-
 board/qualcomm/ipq5210/Makefile                 |   3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds |  18 ++
 board/qualcomm/ipq5210/spl-ipq5210.c            |  99 +++++++
 configs/qcom_ipq5210_mmc_defconfig              | 113 ++++++++
 doc/board/qualcomm/rdp.rst                      |  96 ++++++-
 drivers/clk/qcom/Kconfig                        |   8 +
 drivers/clk/qcom/Makefile                       |   1 +
 drivers/clk/qcom/clock-ipq5210.c                |  93 +++++++
 drivers/misc/Kconfig                            |   6 +
 drivers/misc/Makefile                           |   1 +
 drivers/misc/qcom_geni-minicore.c               | 103 +++++++
 drivers/misc/qcom_geni.c                        |  85 +++++-
 drivers/pinctrl/qcom/Kconfig                    |   8 +
 drivers/pinctrl/qcom/Makefile                   |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c          | 349 ++++++++++++++++++++++++
 include/configs/ipq5210.h                       |  11 +
 include/soc/qcom/geni-se.h                      |   5 +
 include/soc/qcom/minicore.h                     |  25 ++
 include/soc/qcom/qup-fw-load.h                  |   1 +
 30 files changed, 1824 insertions(+), 27 deletions(-)
---
base-commit: e0ef25054db31fee49d031ac337099b12c67e5b8
change-id: 20260825-spl-55fcb0c72ebd

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

