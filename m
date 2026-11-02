Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99150606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MEL3rPrG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=df3B5+VX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i0UF26qt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F78E40645;
	Mon,  2 Nov 2026 05:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adTxyO23ZF1u; Mon,  2 Nov 2026 05:49:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB714405FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598560;
	b=ebuc3L7d+ZYK16aqRBg0tIHBryr9+3tLiKoG1k6hVo2BNsqKeatLLNAWbzz/AnEOsO+h
	 guwCbtQkNV276L0ioh5BLSVGxF25mJjzZDCt9V0HlDnRJIiuJj/TGZ+mal7rE3rruFDMf
	 miJOZUEYLL7G5pNYu0K0S8KMnA29FTKUH/Y23Bt53IuUVKzN8rO+J8i8yfu95McQEWmbs
	 77QR8jDWPh41KAG7U4J91tl8pC/z6SvAHUExrBy18MjYUVNkuAq7pzLJdy4Brep4yQVKT
	 rOLgEgaEMHMHA5HgeF1ix8n/o6ZAIniwj6gFOQx93KVhk4TTibjBl8GuwKix1frF+GA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598560;
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
	bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
	b=MU4T7a9H6R85SvT/UGxKw+89f3f2Pn3fkIGetMTXGna1yC6bdBcd07WJRX5htDUKz569
	 ikH9bKm7o0FLYo/1ZiNYk9sfZdFI2ViwmJWqIpwt3XRlYbEgRLadRD1fsF1oDuT81uhRH
	 WyaFgbZo3ULeXM1j/GU+ATGqW1N5LJOcs2K99vUenh/t84Pzpevm6WtKiYrCZ0OYqaUBm
	 MCaJiC6ArtutvSz5zUmWBS0iBhZfVYw5CENoByjKpV5im+PRTTLnDJAAPfSlmX7VeG0op
	 VSWkTc/pQDKWYVX86dNlJ0skfAtSQkIkdorrM28yxMd0Wu3laQcf/EtmFpxyen0vTGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598560;
	bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEL3rPrGQgW5iXjdl66jayg/5Lgo71U7jwmlKT4QRuhaZ1iFthpoeAvmmZTIPg1P5
	 ispUua+b715wCj4BM3fqUVwOmmpvC90h4oAnF+DGfBBNiW8GjEJ7HFckVTN/GxqTxd
	 aC/een1z7mJVXj83XXwLVKejkJoV1Pp+MIV79rjWXNKeNpIrRAqqG6glucQBy+WOF/
	 7vI/vyIos3bd5Wyok6aXLHpKlPIzSPJG2GZ75CHEVVY10K9YvwqkX0cAhHlsXLcD+R
	 u6XlnPFQEGKHN4pd95j5nYcR1Q/2XyRSEN3f7CLF0T+Hy1/TaRoNRyTZSX57Faje9e
	 yWF66zzhN+Amg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB714405FF;
	Mon,  2 Nov 2026 05:49:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A1B0435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5041A400D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26yLLNJodMPx for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:49:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5EE2C400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598558;
 b=Bv9qKevO2y3pZcW3hVDgLAiYLsUAN6kB6K7j5egFj/P0ymAQ1b32BxH7Fc2YTtICSu0o
 z21qXFh4iRuFA9QSRLZVaM3wlfy9mFj7pORj0WDTsmIeC/1h2u0ms65NVahddf+qsxTqp
 S7z/GE+1DuvEaOB7Cghfq5+0ZTBwNb8ZURKdkYfwKb3kT1Se+28naBRN/jgiQzmBBz5xB
 /bCMG4q1EX+FJ5NfhTfUP083Ib0Nl2wkm6UJ7ujDe3FGcfkABQxAn3yxn+OFrLr6q5g9O
 X41tKxSt0Z+NqtB4onqPo+b/q3MY85y622Cn40IjD/S0RtR1dvclM+YY9bYyAqvGppw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598558;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=Sq0gOQNzDR1WP+uQ9TlQ99uK/ycWQOicb/eX869t6wKljf5+FXl/UR9j/O0tJSFZlWoE
 FivePSOkwuTUUAXDt13jVfuuWVQzge2GPjc5sgCLbd2Hc/CHeYHvbZeb062B2vglsxQRM
 AFDhDM0g6X9PEh8UvddyhwEs9DwRLHFtjYh3ObY2dgB1PpP0BpSI1FHSBUselIh/xJU9h
 nMidauunvEW3q7R7zv7uwZ97PxGbUuDZ8KiwUQhJz7/iy1wmXOtx115/lI1AMPInerJrN
 dD/NeMq6fxlMhn7F3J5iyaDjlQwqk3oKf9rchwnMbsFewRDvnI8MyYA9K0BAiA7XeBg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=df3B5+VX; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i0UF26qt; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=df3B5+VX; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i0UF26qt
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EE2C400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vNUq2745518
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=; b=df3B5+VXAbhicNkx
 +GN0P+9aZL2MEngzhEd6Kto85sjzKtBHo9MTFhc1IkTnZqE2RzR5bFFjBGnnDvzM
 68ZjVaxFZphUyKSWg+rTEgJsDlXfHgZq7QQYTiJabb4dKB3z/JJ6cejN+NHheRzk
 LGeGf8Gb+ycKcWKBBgXkGUQ3PkHAysSFaZRDrNpv/zkl1RZ8tSv6uF0lYdaucz45
 KypOvBqfpI/hlfyMRjeOraqQfgoF2HZYW7zP03zTHnqjaVoQ5mKT7kCunQWSE7q9
 XMnGQ1AkMY7IXMAkkVyFOHzBroZDoM7P1b1g8m8z77XbR1aikhcFrDsG3cOQxCAr
 uu23gQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8dudatc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:49:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so6526806eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598556; x=1794203356;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=i0UF26qtWEB4EiFMdGEGtEcZZCcFbJbGwiUgbZ0Ua/gA07vuPngte47IFZnGq9IB79
 U+iyLhLI09BkCPLMU4UFrQNUfXnF0H8lRRzdVwouF0A5C7Uy2CNYWFEZ7v3Vz6oCc8HP
 yLVkdWLnolBC0rkW9fqfiPEha/k0AwKi9gvrrXzHma1gL2B1/pYeCulgXFF3xML9khxg
 jPjI77sJnocMyYGHJKVeKBT8Kpwon/tTdd0IYJirT5OONw3ne1OEi5Kyw+6/HAC48fuo
 WFlnph5kt+cWFrfTDVqnGtkWx0H50skW5iXdqLbHaOcYQtXh+ZiIxgnCI0D3FQc/BGWP
 xRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598556; x=1794203356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=U++Zvgr8V46FPZ67+qKUcbaA/cRsTA3osA1+d/kX1FDm4ABoYpsxMiv0dO2JR28xJS
 XFBrAFsAGoozSNU0+V0xnZ2lq4KEGg0d9omQ6HDkxZV4dhToI59KMVwvHpJTFAmJjsK+
 uUCqth+iw/DlIcnCYZJ3MqqxzYanVj64y+HAZarYOQM7B1rh9ZWQZf+3R8KT5vliy3QR
 0dBfLwSNKh2qeuJ/+LEiG2WnNnGHkAfbhHjlqzNY8br9zIe01jgrVX+lkN8CWTC1JdlR
 7I5SEV1dER/VxqD+8X0Yof9QfyAyNknbJm3RLt7+AvYJGT/UHKaBEBkqz8ET+lnGROC4
 IsoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBynRJA99PCajRqvJGgLSSdhcu+hEb2FcGvMeTgJpiAWLn0ZxXPctIl1rX6ACDkDHDjBcfvVl+U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYINMRD+3u4GUW7NjXbX+xFme1NisZ+8De3AlDNEgymVezZ8/YJo
 ZfE6a1TmWj6UEM8rssUlZ7wrSstzFDJj7zCc4rqoqYXgFH0SgAH56J8PB5Ti8Z3wRiqLLvFOWy/
 7L/hS8wRBGfNI5bJBgs19C+Hh/Daa4JoGcWBDS6GjTU7BrYaQIxELgfovXf2j600d/YGKG2M=
X-Gm-Gg: AYBFou1KXUlH0NIJMEov9y6OZWgsHpcQP/HyaGFXjDBH1srh4bDmvp/hUAYJ1Cm0He2
 kqB///lm/BVmpHEuBbp15DgB4Wulg7AY7659l7cjhN0+0AiZt+11ttAX0GSUMrCSGPPtABBkMtK
 joVsEujhDhuaof5CMD2o8lAB6O7gf9Epo2bANNgMQWsjwkWR9YmaGZbWGDQvEc20OH4SQ86sris
 nTTpcIXt2FLzXWrQ7BvlDkh1wqNN7qwQJcPP4B3iv99bDVqskXzreL0jeiPQIZ0j7WIcsGN3hWk
 svYTN53wsgRQC1uLdrQGzHWj6v8pTirHUcE2Ndf+d/DCZZ5a9X6j5Ht6zu3XFYx7MCHnIoQ6psI
 azQAxUHywCn/ols5ZGNBGAJJashIlWQqEaZ8iKUxBNUNkO9kLLkQF5Fp+uKGnP210WEw21Tu29c
 x5rLR8a2uAchgzCJPl9X7wK6njf7zk4nljwlceaKT7PVD/NavVlFWJ0+7VUGhB9J7k5444UVjIR
 7ysFQ==
X-Received: by 2002:a05:701b:4193:10b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-1ac5da76f61mr14118236c88.31.1793598555821; 
 Sun, 01 Nov 2026 21:49:15 -0800 (PST)
X-Received: by 2002:a05:701b:4193:10b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-1ac5da76f61mr14118204c88.31.1793598555239; 
 Sun, 01 Nov 2026 21:49:15 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:49:14 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:35 +0530
Subject: [PATCH RESEND v10 03/15] mach-snapdragon: Add PBL shared data defines
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-3-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae8245c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=17UMeyZtP49W_7ZR7MkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Ey2_9Nu2vinaHPPgFC2sXKtwPnIxdEW4
X-Proofpoint-GUID: Ey2_9Nu2vinaHPPgFC2sXKtwPnIxdEW4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX9OC5Cf8mN/5P
 srhla9GDoIzs0rBbKfJeBv/s7y/RF80KxlWk6UNMaNKnoUiPIQGEEepgVzW0DxcqfYXXab2xStV
 nslVdIGTZ4YiCBxMrNaQ98mS5Eyh/s2b/ppMFWjBsXUp0rQWZx2B2WWK2zIxZvA34Zs8wUlU2Y2
 kyBrNTW7kY7Gf+x4/cgwkjpR0UzbFrLa75iUxQooeY6H6nXcYZzOXp76mtqeDcO1YFgIUfh/Y13
 XJJ9xI5xi6uczxcYPeie96w3n6UhTeBMiU4h9NWWEM1ndxwNqexgdNmr+ru7zHcjzSnqJJP5dkr
 FzAXtLR7gpvZaW13Saaj/tFxu77iogmkvU08SaVNO+Xsk9FOFySpfMxxJRjGUgQyQGXwNWKjlbe
 qrHfyVRs3UbhT4ycgx+3VHhY2KpcFDc0EIqrkDXI0e1BW7nepzyvQIv1UVwE7iA9ZmUBECfaw1g
 6ve34gbNyRLEgnlDU7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX00RFq1LBk0qR
 NRlKKdXWLGE7NXjgzKoMJRn1iP0zej6e5Sm8FVUp3ycqKMsSUqMT1wy6+nnL+p7iGJK46DrH1nJ
 +V6zQxeMmvOtbkTIS73YaojoqqYUXr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add structure and enum definitions to be able to parse the information
that is passed from PBL. This will be used to identify the boot medium.

Since the PBL shared data defines are private, move spl_boot_device() from
board_spl.c to pbl-shared-data.c to parse the shared data and identify the
boot medium

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile          |   1 +
 arch/arm/mach-snapdragon/board_spl.c       |   9 +--
 arch/arm/mach-snapdragon/pbl-shared-data.c | 125 +++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2360b7c658e..4f2f35cb9de 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -7,6 +7,7 @@ obj-y += mem_map.o
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
+obj-y += pbl-shared-data.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index d69f3e8aafe..41d8789a002 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -7,6 +7,7 @@
 
 #include <hang.h>
 #include <spl.h>
+#include <soc/qcom/smem.h>
 
 /* in SPL, we always use internal DT */
 int board_fdt_blob_setup(void **fdtp)
@@ -20,11 +21,3 @@ __weak void reset_cpu(void)
 	printf("reset_cpu called, going to hang()\n");
 	hang();
 }
-
-u32 spl_boot_device(void)
-{
-	/* TODO: check boot reason to support UFS and sdcard */
-	u32 boot_device = BOOT_DEVICE_DFU;
-
-	return boot_device;
-}
diff --git a/arch/arm/mach-snapdragon/pbl-shared-data.c b/arch/arm/mach-snapdragon/pbl-shared-data.c
new file mode 100644
index 00000000000..b9dce22c417
--- /dev/null
+++ b/arch/arm/mach-snapdragon/pbl-shared-data.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/system.h>
+#include <spl.h>
+
+enum pbl_shared_data_param_id {
+	PSD_ID_PBL_FW_VERSION			= 0x0,	/* PBL firmware version */
+	PSD_ID_PBL_PATCH_VERSION		= 0x1,	/* Patch version */
+	PSD_ID_RMB_MBOX_BASE_ADDR		= 0x2,	/* Not used */
+	PSD_ID_CPU_BOOT_SPEED_HZ		= 0x3,	/* CPU boot speed (Hz) */
+	PSD_ID_BOOT_MEDIA_TYPE			= 0x4,	/* Boot media type */
+	PSD_ID_IS_EDL_MODE			= 0x5,	/* Emergency Download mode */
+	PSD_ID_DEV_PROG_ELF_ENTRY_ADDR		= 0x6,	/* Not used */
+	PSD_ID_XBL_CONFIG_ELF_ENTRY_ADDR	= 0x7,	/* Not used */
+	PSD_ID_XBL_SC_EXT_ELF_ENTRY_ADDR	= 0x8,	/* Not used */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_ADDR	= 0x9,	/* PBL logs address */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_SIZE	= 0xa,	/* PBL log size */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_ADDR	= 0xb,	/* Debug info address */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_SIZE	= 0xc,	/* Debug info size */
+	PSD_ID_TME_CPU_PBL_ROM_BYPASS_FUSE	= 0xd,	/* Secure boot status */
+	PSD_ID_XBL_SC_DEBUG_LOG_ADDR		= 0xe,	/* XBL SC debug log address */
+	PSD_ID_XBL_SC_DEBUG_LOG_SIZE		= 0xf,	/* XBL SC debug log size */
+	PSD_ID_CURRENT_IMAGE_SET		= 0x10,	/* Booted image set */
+	PSD_ID_MEDIA_DATA_INFO_ADDR		= 0x11,	/* Media info pointer */
+	PSD_ID_MEDIA_DATA_INFO_SIZE		= 0x12,	/* Media info size */
+	PBL_SHARED_DATA_PARAM_MAX,
+};
+
+enum pbl_boot_flash_type {
+	PSD_NO_FLASH		= 0,
+	PSD_NOR_FLASH		= 1,
+	PSD_NAND_FLASH		= 2,
+	PSD_ONENAND_FLASH	= 3,
+	PSD_SDC_FLASH		= 4,
+	PSD_MMC_FLASH		= 5,
+	PSD_SPI_FLASH		= 6,
+	PSD_PCIE_FLASH		= 7,
+	PSD_UFS_FLASH		= 8,
+	PSD_RSVD_1_FLASH	= 9,
+	PSD_USB_FLASH		= 10,
+	PSD_SPI_NAND_FLASH	= 11,
+	PSD_SPI_FLASH_GPT	= 12,
+};
+
+enum pbl_shared_data_version {
+	PSD_VERSION_1		= 0x00010000, // IPQ 5332, 9574
+	PSD_VERSION_2		= 0x00020000, // IPQ 5210, 5424, 5610, 9650
+};
+
+struct pbl_shared_data_entry {
+	u32 param_id;
+	ulong value;
+	bool valid;
+};
+
+struct pbl_shared_data {
+	u32 version;
+	u32 num_of_entries;
+	struct pbl_shared_data_entry entry[PBL_SHARED_DATA_PARAM_MAX];
+};
+
+static struct pbl_shared_data g_psd __section(".data");
+
+void save_boot_params(ulong r0, ulong r1, ulong r2, ulong r3)
+{
+	unsigned long sctlr;
+	struct pbl_shared_data *psd;
+
+	sctlr = get_sctlr();
+	set_sctlr(sctlr & ~(CR_M));	/* Disable MMU */
+
+	psd = (struct pbl_shared_data *)r0;
+
+	if (!psd || psd->num_of_entries < PBL_SHARED_DATA_PARAM_MAX ||
+	     psd->version != PSD_VERSION_2)
+		goto out;
+
+	memcpy(&g_psd, psd, sizeof(g_psd));
+
+out:
+	save_boot_params_ret();
+}
+
+u32 __weak spl_boot_device(void)
+{
+	struct pbl_shared_data *psd = &g_psd;
+
+#ifdef DEBUG
+	for (int i  = 0; psd && i < psd->num_of_entries; i++) {
+		printf("entry[0x%x] = %d 0x%08x %d\n", i,
+		       psd->entry[i].param_id, psd->entry[i].value,
+		       psd->entry[i].valid);
+	}
+#endif
+	if (psd->version != PSD_VERSION_2) {
+		pr_err("Unknown PBL shared data version\n");
+		goto out;
+	}
+
+	if (psd->entry[PSD_ID_IS_EDL_MODE].valid &&
+	    psd->entry[PSD_ID_IS_EDL_MODE].value) {
+		printf("Selected boot device: DFU\n");
+		return BOOT_DEVICE_DFU;
+	}
+
+	if (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].valid) {
+		switch (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].value) {
+		case PSD_MMC_FLASH:
+			printf("Selected boot device: MMC\n");
+			return BOOT_DEVICE_MMC1;
+		case PSD_NOR_FLASH:
+			printf("Selected boot device: NOR\n");
+			return BOOT_DEVICE_NOR;
+		case PSD_NAND_FLASH:
+			printf("Selected boot device: NAND\n");
+			return BOOT_DEVICE_NAND;
+		case PSD_UFS_FLASH:
+			printf("Selected boot device: UFS\n");
+			return BOOT_DEVICE_UFS;
+		}
+	}
+
+out:
+	pr_err("No boot device configured\n");
+	return BOOT_DEVICE_NONE;
+}

-- 
2.34.1

