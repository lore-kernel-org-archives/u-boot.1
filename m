Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F09CC6B0A
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9A9740664;
	Tue, 13 Oct 2026 05:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j05whB8N-WOp; Tue, 13 Oct 2026 05:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C950040627
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869601;
	b=D3urn+oerpoQUkW91e/duXliYHRZ+dXG8to5f6RoGLp+EmnMoB6plaNAdcZZgYnQat4p
	 CPaWPROH0sKZ4pl2YcSdqEegCBR324paiBbZsZh8rG4Uqi/XFmRiQcfwCqp6TDBJyeugW
	 Md9l7Iwb7aeiS2tE6uHlxFJIuBfVNv3ak5F6lSotWoXSHHL6GsgXhhb624Tphb878nsUJ
	 a1lqHqTGpIE9PkHrM3Kif7FpieNcy7YjgG+0RACtKBdd95BMQDPJoXXgihldRnfem/dfj
	 LL+QHZGkfvBM7tnO39AT0zsSmlqo702uc/DtbQUKebKazS0CylodXKi9tKBLScTkjbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l5PLnVzkWxhNdgty8kUrG4HtWdeFWGMhRO1byJjx0NY=;
	b=NRQSPEo7ejgcX0pwgwCwlWueYHrTNiYvn3QbGAy8Dgt3rABDtaKGnAXn/qYAuHRWTahx
	 pFUlVXLEWi2MEZbrgtZZ2Q/blP11t2urenVsSCtwkIPlL/0ZB6LdF/b475m841xKhqxky
	 gutGYfpqjlPMDY1HanBRE7M5uJJM6fWEHbGwqZLT4QvOGxvPRIpAA2LTNb/OScQOgPf04
	 WY8fZ32mQB96gEWx1G8BUxP6sTACBRdtSTQKOSy58FTrxBBtwwtDGOQ1qBul24dENL5Xd
	 DtW+cdck7nwdqN6FQytIy7NLp1ej8Eh0FqXNL9USbV8LNSDKueVui5/EJxoR0MUONhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lyevR6uH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fKsPN3Jt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869600;
	bh=l5PLnVzkWxhNdgty8kUrG4HtWdeFWGMhRO1byJjx0NY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B96RPLNpQLlFobVbtCpOLkqnLj752s/DlvrjdHS8KrrMuBRmTcp41q2pnzIyW4Mew
	 dAQxMaAdj3sDx9tW2LWmO+fwGG93RGV/oEYpErj1pFpEKV6CwoDf2hSCbFjZLbOrDY
	 NFLT8jPFQ0PXd4r3hFs6h+/g3qRjuF1zMHmETZC1SpcZukQe3loiBMDOjI2P/zQ4cZ
	 WS+70jMq6Y239rSYxBoJA1UmS17CSmwXKu/RyKTVVQ95re2Iarf63bpiMzhcrxvAKb
	 o1c7wQ2FhUGCs/ug3hMWwCzGokvYLTE9kATq3PU/stRS7d9avIDAVK1qjoxBWvns8C
	 ep+EP2eZndypQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C950040627;
	Tue, 13 Oct 2026 05:33:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF856105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1597405E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NckjeMaBFmEV for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA0404066A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869594;
 b=d+44qVS5OfbQDCZHlJ7ccLsBUJgqCrV9rqTIpi/JAfY/fI2HvozUSv8Q4lgp9+CGLHH0
 VqELzfrxF1ubNgf+NJRFaHFOjX1LnpWaG0OOZuq6fUznBPkNd/xXlQIlXof5RYDnU7rZJ
 8m3kOTrLqAdzFbwR4cewKKnj9KHPnZ/7vMd0P/mTqhJM8SMDFkZxlUDCH/SIk2HD0NlkZ
 9RbfyGI0KKNHM9ZwPl212n7eSJXoMsdU+LBG2erbc5ZiGK8232RKtLa1bEIdkLmHKfM4D
 IMBbSEkOurlhpY9yaW9ukvZJNay95WvhQCSgf4C2Qq0wHxXcNJUEH5hVgITRyj4NDOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869594;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=l5PLnVzkWxhNdgty8kUrG4HtWdeFWGMhRO1byJjx0NY=;
 b=Z5sXUJLQnVCLcjgbqnmMl0yuIFnQq5q/BejUCeE5T12NSWxOAJTaiVNi1+dNbSTqPGnV
 62tgOtV7GzU3v4MeEbqHgigVsso9wkKhLNucjnVHyVSM6OJA/g15eHU4vcVqUYhwS9uXI
 KfeTcRunu9Hl4uLJFUSWLYB1idV8aGw3u2rVR23dlfohyGnBuk3kUbaNOPNz2resorDXj
 k79wP4NAN6PbOCy9J1AjLfx+DppcoqSOtOhwbTDs+p+zIZrOTzVW/PAfo4+NjwocGPSUw
 XwwE3Nqk95KFTtMwQffeSicNAmFLjFVx7JuQQhAQiEXhpNoSkkeL4jyreu+Z14bTgrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lyevR6uH; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fKsPN3Jt; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lyevR6uH; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fKsPN3Jt
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA0404066A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21evY2620655
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=l5PLnVzkWxh
 Ndgty8kUrG4HtWdeFWGMhRO1byJjx0NY=; b=lyevR6uHrIZrgYVXOYbL7rISt9z
 gso49bo0ot7edePa5gbpArNk0PDoIMfbx1rLlYrEB8hDjAkG3OFMHCz4vqR7yEU+
 M26W49qqd2ZNpEKb/UEx9b26/jSRKX48s8wdptaHzCPzPA757SoEMHUx/bVuMUd3
 dE1KHy/rMID8boIdU3V033cwpHTS2hgHemkHorArhax1R9HEhUI7rERD6VwX+eJj
 aPYsRzkbTvl9fWD17VIu3iQeIP5TRuTUlNq62cRWhoux9V54HNyXptFj8yhfQRiw
 oq2QTYbPntACmj3KecGshndbI6IAxCljW0Lkn0YZQfStlIVTtEomAAzXNzg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcva42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5284177eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869591; x=1792474391;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l5PLnVzkWxhNdgty8kUrG4HtWdeFWGMhRO1byJjx0NY=;
 b=fKsPN3JtAs1EX2Qs5Ewtd7aNNom+fSFMCUIL0ZrQUOv6vWy6rypxQ6hrotwPRUh4L1
 b5K0hQ/irZbf3nKCH6/AZhK2JdK9mhuVw0EwfDeRLWG5KJ2iUNLZqS5mrxvW0yda+0+A
 tL1gKfnvx5Iwuzxdi6RFKXV6Zjm8zCwexHdFs/GnMl0Gi13X0c99HGPtpBj6NUHD8tMe
 m+bTiYjcqLEjq7DX2zxn3Nq2yiPCETn50nGKrKCGFg9i6YoiXFXcFCHA5lgJeR418TUH
 S2CTXZC1NbwbbngvQvQoJFxRsqzIwMLb0l5lLOzbkyPbbmQfNDHJACmoAKfqmP21CZB2
 /Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869591; x=1792474391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l5PLnVzkWxhNdgty8kUrG4HtWdeFWGMhRO1byJjx0NY=;
 b=QQjnTCPXL3KncPEDnLCkGrgrGwWrq4UJmwgCmNzVuZ30KQfKtEcsKDmsU0Ed2JCyNg
 IkJe/RczIjXMhoJKNRIJ5CghTd6rnAAUNFPljle6VQIbhpOin3A42K/4yi6VPPhcHtr+
 HfyuxI92kzvbb4iMHAAwKqbWqg0LrbCwk6MLaoY7Yu3q8RZF7BxkWVOu4VOBfjquxTkI
 AOtu3ZRutELSQv+3z7ADQ+4ZpYrlak/KDdmDfZZJCrJllvgmFIYbF7LCIsH5fbHSszp5
 yfxEssR2dHlAb81ibwhG8BZjzqbrvoPCi2OsUmnI3s2zhhewGARm//FREMDMLdE9f9yf
 3/lQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzj0gglsTgHJYS8Ygxq90JPNdv3pBaMGj8A/4bP29fdcPJfpCQGFeAujRCa5U32Th01TAdRgPg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL/KQ70brnTg2pTcem+dCg/9fDBvUvABPBbaOpbroowHWgYcknD
 yftCnB18qpDkMiMeD7ZFeGeoBwayyAoS5JLjPPS5cww1GzY9G8L+7xRDBHUc/qXtLoru2NrMrrT
 H3sY16/6fHTj/DyPgqBpK7yksvfYYjqZWBh4jHb1DKM0hDkla4FILCj+Y28bPQcz0OtuaOZI=
X-Gm-Gg: AYBFou3LF2APJ/MMkv6PggQgrucrnYXCQ3ltcJSKJaM5P0HMHv4XaPq2hXwp6oP/2F/
 NvlsX/qWLbyXZafZ/lAw0X3l1vZMfiSin4yZjk4ynf5PYbFyViR9Gi+R1dAYAm9wo+8cJCjkjW+
 GWbtWq2xWlpnQ+WrjYCwXpgVvRQ/dtG/Yo+99SU49doftZD29dc8HaGsmVZ9kbMTF0hxdsSpT9c
 jk9AJkEdFQcjbhJlfcDMCjhUu15w6WfMoQecUFIV6GJzoaor2oDUtxG0Y3mgFAhXy3leGYIDl8T
 2HS6dp9/d1ATaAScOeq4ySQn0lRRgX2Cc41dPeG+SrHGwoRgy1rIRLL9Hj2WJ47Do16utqY5hw6
 9tlrXWyjbfaQd0/9D1kslzj6YgXdBaNuG7XK/yPYorxwsb/Y=
X-Received: by 2002:a05:693c:83da:20b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-35c85fa5b6emr1094612eec.38.1791869590739; 
 Mon, 12 Oct 2026 22:33:10 -0700 (PDT)
X-Received: by 2002:a05:693c:83da:20b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-35c85fa5b6emr1094570eec.38.1791869590046; 
 Mon, 12 Oct 2026 22:33:10 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:09 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 10/13] board: qualcomm: shikra: prepare QUP firmware in SPL
Date: Mon, 12 Oct 2026 22:32:41 -0700
Message-Id: <20261013053244.2954876-11-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 27n06stHX4Qx_weMJjPR36Ij6aHGhR0h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX3CZdb8OOpDxS
 3jCJSSbS+WFoUTnn7zGVqyaQrL6bDnVsjDFFEE3mHuRc1npqzF/eUVwdzDd0QjsxJevo8EC/xYT
 YAY9vRQPQTpGfFYbpzoPiV7y/kzJEDA=
X-Proofpoint-ORIG-GUID: 27n06stHX4Qx_weMJjPR36Ij6aHGhR0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX2UiPehMbQqTt
 /OG6+TqIkpUsMESCMOW571G/Ee/WPuF+Gdt+0/ixAeakYxl38H39awaTHjUFpiuA+TXw5/rgnZz
 U6aYOiqXmhmVog4tQVBpTf8cMUwqRtsBFz3L9IWlmHX54u94CCBX+CjVPv8GMg0Dp/LObDv3Po7
 1cwi7owmFNnYJvx4C/8j0j3/mgElifHLc9xOx7qQXHTViAmR598adADktIfAqQKBEamXeOwFE6Z
 2GTxa0jCqmY43xq8f3bQ4OpYICP5hSkoLpNyqOIHkIiEuvr58q9Hu/NyccIePZkfDM2lbwycCKj
 x6BXVKl52f/lakX04dW5qU/VhkEQkFk1k7Nj+xHJ/BiKFeROAMQzKBN3GEHRe/PyFc+V/ZVrwUe
 BY6GJwzaAak4Byq7KT2uBHjGAIc/BuiqHmSzBQiEUeIQHPzY6LHMDWomBl8pR7qVrn7OU+ubOce
 hgFeh1SXkN5rCT//utA==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acdc298 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=nMXrJebM6ccVpyDcoNQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Prepare QUP firmware support before serial-engine children
are probed during SPL initialization.

Enable QUP wrapper clocks before firmware detection.
Initialize the boot MMC before the last-stage init event.

This makes QUP firmware available from the boot medium.
Release the dynamic firmware buffer after children are
probed so SPL can reserve memory for the MMU page table.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 112 +++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 358023b24e4..c2a5d2d692b 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,6 +3,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <clk.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -16,6 +17,7 @@
 #include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
+#include <mmc.h>
 #include <part.h>
 #include <spl.h>
 
@@ -174,6 +176,103 @@ static int shikra_boot_device(int *mmc_seq)
 }
 
 #if defined(CONFIG_SPL_BUILD)
+/**
+ * shikra_prepare_qup_clocks() - Enable QUP wrapper clocks.
+ *
+ * Enable wrapper clocks before detecting the QUP firmware state.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_qup_clocks(void)
+{
+	struct clk_bulk clks;
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get(UCLASS_MISC, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		ret = clk_get_bulk(dev, &clks);
+		if (ret)
+			return ret;
+
+		ret = clk_enable_bulk(&clks);
+		if (ret)
+			clk_release_bulk(&clks);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * shikra_prepare_boot_mmc() - Initialize the boot MMC device.
+ *
+ * Make the boot MMC device available before loading QUP firmware.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_boot_mmc(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	int boot_device, seq, ret;
+
+	boot_device = shikra_boot_device(&seq);
+	if (boot_device != BOOT_DEVICE_MMC1 && boot_device != BOOT_DEVICE_MMC2)
+		return -ENODEV;
+
+	ret = uclass_get_device_by_seq(UCLASS_MMC, seq, &dev);
+	if (ret)
+		return ret;
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	/*
+	 * Poll SD because SPL cannot resolve its card-detect GPIO.
+	 */
+	if (boot_device == BOOT_DEVICE_MMC2)
+		((struct mmc_config *)mmc->cfg)->host_caps |= MMC_CAP_NEEDS_POLL;
+
+	return mmc_init(mmc);
+}
+
+/**
+ * shikra_release_qupfw() - Free the QUP firmware buffer.
+ *
+ * Free the dynamic QUPFW buffer before allocating the MMU table.
+ */
+static void shikra_release_qupfw(void)
+{
+#if !IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+	struct uclass *uc;
+	struct udevice *dev;
+	void *fw;
+
+	if (uclass_get(UCLASS_MISC, &uc))
+		return;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		fw = dev_get_priv(dev);
+		if (fw)
+			free(fw);
+		return;
+	}
+#endif
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret = 0;
@@ -188,7 +287,20 @@ void board_init_f(ulong dummy)
 		goto fail;
 	}
 
+	ret = shikra_prepare_qup_clocks();
+	if (ret) {
+		pr_debug("failed to prepare QUP clocks (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = shikra_prepare_boot_mmc();
+	if (ret) {
+		pr_debug("failed to prepare boot MMC (%d)\n", ret);
+		goto fail;
+	}
+
 	event_notify_null(EVT_LAST_STAGE_INIT);
+	shikra_release_qupfw();
 
 	preloader_console_init();
 
-- 
2.34.1

