Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D872CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17DA960640;
	Mon, 12 Oct 2026 05:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XgG6eOAs4TWc; Mon, 12 Oct 2026 05:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E7C460601
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783306;
	b=O5wqK0BNVtFEzM5bdd5us2mi1wMygRD1zizTCa+mOs4vrLuxCZrflJZaQg4LZqX8JtB9
	 WGRb1n2+o1PhHME2ofkxw8hJafYwIRS1jFFGLeKatsC9gdw70O9dB/7euV8jLKBq7DiVF
	 aZbsYBVl8yShaMu141yUigs4DYl5IswhA57WH/BdcyZ0kzuxDn5/VUmPyNMsiyO/1QHmT
	 YHUrYzA+BGBPX80WccNesKr+m1dA0xaD4Df5tFPux/yWsv5BcQDsTKB1Svt6rl8PY3bw5
	 i8cSHCBxkeAum2MVypBKf5BFKueJppRvvtd1k1YytK7xn1JEeFRNzE2E+woosdMkuag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783306;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	b=GSlUlxTUNZ+MTCUuso4mv92O0igiOi6xL9FGh24PdSvsts8/b8IXFz+6QxPgSXWn5ge0
	 YiPark+65BLWA6cOi7dTGhwFq1Zd4rxQ/3Si1sLs5VNixC9rEXdQ5UHc9F1U4/ddJ4d0Q
	 zWEb+iHjKVCyeELNmu9IBO1NRmcvGWtagxm//SsQEw/38zP4flRWKmZ9IFicKzKmXNrNw
	 JMD6GhPWtQkwFpWqaZeh3FlWWtDyTtjRR8Xow7yetdY2wOsRb9ktgyuj231z2yQxxQq9k
	 NxUiO2ZkM57gVqVu//wWEtWkovRZVZE3JtjgM5tbErtzZbAGzJM/SD2uaoBgsaqrm7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783306;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fc+l+3MMgeUZ0a77fl7EYDWM4zD+mYYom3X9XfmitCuRrZHpsPJzYdmfQZxQRPZ+
	 0HzNe4sa6DrNpx+JbozNKdXbgezQaslo6jyH26I/lVhdbVQGsxwWhG+pCXLKXlnjVK
	 0D+9ITun7EUhBbWO8hWt7q6gm4HDN7fWzKfkg7q/Pfp1YY7H7KyjazLNsT3U5Mhro6
	 5jGFVmosBzL8WJIqWPqCvnZln7qA6pAnbumPazzUyJ8+7GzIgGRoua02kb3/ExOHrW
	 5RNnwC7oVORpI4Tvp9oh2AahmzOfMxn996gUkYqOIsifgxg0GigVaEPUi8B5Iihczw
	 21ac7tTA/ZbJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E7C460601;
	Mon, 12 Oct 2026 05:35:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E6E71DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BE5A400A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1tebFpNYri35 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 218004002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783303;
 b=GOCUrPxthiEMYRxTaMn536SX73KvREzkcU0nzORnyQ/YO0QF2dpMInFEYeGI1RSmXqaI
 eFydFSI+gd74QwvpragSXdXVHh1qSKf2Io+M56q+1gLbohkeSlEGBXOA6382+OLcq4Vkm
 gImqGMmr+TkNFFf1I1eQ8HfyGEeQuHmA5upfDxiKw9t3QxaS1Ko+y9y7WMdggUOhxznNT
 TqaU6gsE6qQ2XuZc38MAWYWLeyigJQG5OBInv7XITRZz8+mYlOYenaXtvYroT00cBFJH6
 xL3c27oSGS44D5GMXkQ4SPd2np0OAJgQfhPu86o1e2n/n8w8H4/zA+dom8gKOYxCVqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783303;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=GBbsUS+K2gvFEjz29dEczs5P52MuaqzZGVqGAKkM2+CbAwK7JyV2zICWVcd65BtR7Ir8
 o06hW+v1Ne1SmYKJgcqasEXsyHiYuOlM5N0yL6XYFYvvoaNXxCxuGQruZzUEziW3DZVt3
 m+ZsyPer42tjTdHDjls6On1FR3r4XpzlGql3uPRu1IVKE83BGEgP7eFfFcCIeDr05w2zz
 LUGnXDMrpzp3cesUWA8tkX/z0hWyduRoLyS81yyaboiB34rb3xpwoN1LemGjQwzxN6fek
 5iBDPa+m0j95IKf5nfg8sF9BA46+HxnYJj/bkOZI+qweWrXgWHazAC6hEXnkEAQfV6Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SWYQnjcw; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=H5Vf0rEx; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=SWYQnjcw; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=H5Vf0rEx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 218004002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55pZn302994
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=; b=SWYQnjcwZSHGAtGY
 IMzW2Hx+m/szBn21nAGC+phb/gzefKrRB6W2Kc2YoCF0Nj63EKobeNjVhJi8wXbF
 rSLFVt3KDOFJBqCZSYu7n3w18lsppRIHwvNbTbbmettz/5yHEWgPQRXLw/dTeusj
 tUo5p+OytaznKOdJ6g7habjVXlFjwwi4h3kzGCkygj9mR5mEmzJv3qhIxo1Fx5S6
 uANyHs7YsyXjQE/p/NdG12pPfH0q698AfOxdpXDBghJCKbp4lmU0OQqqBaSLGW0J
 N4C0Hx3VvNIEwzMyooiq4PH6L9fV7x/dDH3pISPdbZO6rPF+Z5kkXIhqxw6jo/n7
 G4cg9w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dh2uf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3580c07911eso4288690eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783299; x=1792388099;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=H5Vf0rEx0nF/W+0m6UdoKlJZ9O1fe0DcrwHEY4Iw3QvZAyp8sXQByuEmhi9i+LABV2
 QYR1zpsQ7uBT43mDmrHjLfVltS5vi/bN6M5RmcVAM6Peuv1Ew2enZ3jxbskMsOUMv+os
 0pmOnhBo0zrFVyS0akyhkvcAvVj91K7mnz2ovnFVGfSFb2gr3ZoaNaCFtJ0TzRpfLp6w
 QJWAmhUo6dADR+4QlHopseXK1wyy9GMIni2z4pb33EUe8iLFN4Qkb9Q3ICM2FtZRRUXn
 3CZKIcDT4p/UwnMzEkni9tWQ7QcVZPu3FGEbVrhO/Q8uBWsCAyaDGrjLmTn6Nr23nEpl
 9ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783299; x=1792388099;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=pDALsWsmCR61e7LxVvtPybUAj/k0E7Dw956PzYYn3kBZ5+i+SclNZqNDuyQc7UVy4K
 97X1N8ew7dY+jMuYnqQMI68mvMls9SZgupUvIzCQifRQffAn3CwgEEx0SCJWjga6luIf
 GopAjXfr+tHbgwcQSEGh9S/3edB+LTbQ2SP34B6Ff3UD18FwjMYZ9T7JdRQAAFS4f/VD
 Vj4GsKe4eTGdPejlNI6UQ/hyr/oM7lR9WJUP57ayAXzeMfGJBpfRNPl7PqDP7S0W3elN
 UPD1i1JHbSDa3BOi2rlEU7MtIHDUqN4zrKPEVEgMurNNA4o8/U0pctUx5zQcbGcxXGyR
 s7tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmZ8EGgyNqOoTEdbjKhlISyQelXm9MGcmb6Q2KT5YYxQAt/3TyRZvAiU/cl68KRDzqX22PSEM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI1Fda9fptLhf/dT/ePGEhT5hPvp4ymJsFBcLDlIpQUt+9tGCZe
 +G4Y8fBFF9mkFsiulzaTt7oNeX8obgOxxLUTBoz0UudrygHM0odr3eOB0ZYR3cC6wZaNyHvdUoA
 djW3QwQwD5Ob7cCLNa23lRhugFl67s4dgUmJ2AAMKAojVFXGy0AVf2Q9vsviLMtnBpyrt4dA=
X-Gm-Gg: AYBFou21gjY0RVFrFqx95H0pxkeOuXsxlayFiGIQYMVUv5Uvq3XSTmUlEsKBBmEldaK
 9KFP/DvfbNf4NlNTBnUHNSBpjRcT2lQYkubsWb5eIj/srXBb/6ir/twju2pYnZintuREMWokRxv
 bbCnJauPnkPSdQzZ/guz8gA9rXEQz65Uaa1Mk2m6uuWJIXkKlKzwYK0/Y9mkPd1PeULcwXaZNvF
 F8NOK1n/6w5GzgTI/lmOi2bQhq7S5OI6N7MrcLM9wpqKotebEQg+eh627WoeMq6NinvtrozmMxS
 htjp4GWTTZHt5n4ABh1Gop1lG1L6sEvAC7RsJ5USfQ5Vm1HFWzVB2rfDMzQeY81lUkg2o0yR/Rr
 3XHfklDm2hXDTbdJcIqKgGoTx1zu8Uo3Fcfy8M9hXj76qC7e3
X-Received: by 2002:a05:7300:2392:b0:34b:101f:cda2 with SMTP id
 5a478bee46e88-3537e0cd902mr19928958eec.27.1791783299013; 
 Sun, 11 Oct 2026 22:34:59 -0700 (PDT)
X-Received: by 2002:a05:7300:2392:b0:34b:101f:cda2 with SMTP id
 5a478bee46e88-3537e0cd902mr19928899eec.27.1791783298407; 
 Sun, 11 Oct 2026 22:34:58 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:34:58 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 01/13] arm: qcom: add common QCLIB SPL extension helpers
Date: Sun, 11 Oct 2026 22:34:40 -0700
Message-Id: <20261012053452.1567885-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfX9GJQWL4Vr6Wy
 SDaycuZLd1rnzhD5eVKnrvUfLEia0tCc0oOgUKP+ubbmsipcBUbG23OcjalZhBUVBy3HDFGZnaS
 8TUWJqEjmCn4onv9KwzD586Tody/8P5UrZoizP3RspCo98q5ukJA3eQzoABG1na9JTnAS6lkov0
 APAJYlzOGEcwZpfx/g/JJEbVBceaiPZn2DSrrEM2HiuIBHOcMg5zgmVkbs91ycwN6ild8P73xjs
 KCszdfNViJXzBvnRctFMXmK2M/LItw4nb12vh16bQyVGDokEEQSEPBOqorQ9kL3Ta8PH9L6o+NL
 tHp+UJchumJ3x9YXRwdPHGO/XPjGNciv+BuPuAFv/3u1BzrboHtL3SFJtqukMbw5rdwJAlFQhrO
 VnDYfb/tuz/akaS/fMnR4FvxyWXOO6qthvKU2kRDPvQFN6+ulUIYhu70M3kVyPBpphg9b/e24zN
 Wo6boJfwog4dh6q4QLA==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acc7184 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=WN52PlUurRMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2F8QJI7O2KTJmeVboGYA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 2ouicujNg6Dx11Us5uL9TePQLTHqbbFq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMSBTYWx0ZWRfX9q88+BC1Imwu
 We7FMiHiNtc9D6xjVUpWYXJnSiIT6TcEsinlw5OdZCeFAzMRziqQnJxr3ARpXELslB0x39QBiKA
 OaISH7RauwGadFhuchdZopxNlXx1qL8=
X-Proofpoint-ORIG-GUID: 2ouicujNg6Dx11Us5uL9TePQLTHqbbFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120021
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

Add helpers for adding QCLIB interface-table entries and FIT
blobs, expose the DDR self-refresh exit address, preserve
U-Boot global data across the QCLIB call, and provide weak
reset hooks for SoC-specific SPL code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |  8 ++
 arch/arm/mach-snapdragon/include/mach/qclib.h | 16 +++-
 arch/arm/mach-snapdragon/qclib.c              | 77 +++++++++++++++----
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 3293eab8f81..5aa84a3a6d1 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -27,6 +27,14 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+void __weak qcom_spl_soc_shrm_reset(void)
+{
+}
+
+void __weak qcom_spl_soc_rpm_reset(void)
+{
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index b44874c514e..10865b03ea1 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -65,11 +65,25 @@ void qclib_set_qcsdi_address(u64 address);
 u64 qclib_get_log_buffer_entry(void);
 void qclib_set_log_buffer_entry(u64 address);
 
+/* DDR self-refresh exit address accessors, populated post-QCLIB */
+u64 qclib_get_ddr_sr_exit_address(void);
+void qclib_set_ddr_sr_exit_address(u64 address);
+
+/* Interface-table entry helpers */
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size);
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size);
+
 /*
  * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
- * override for any of these; the defaults in qclib.c are all no-ops.
+ * override for any of these; the defaults are provided by the common
+ * Snapdragon SPL implementation.
  */
 bool qcom_spl_soc_check_dload_mode(void);
+void qcom_spl_soc_shrm_reset(void);
+void qcom_spl_soc_rpm_reset(void);
 int qcom_spl_soc_pre_qclib_routine(void);
 int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
 				int images_node);
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index 7f25f37b5d9..b9a74863c1c 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -2,7 +2,8 @@
 /*
  * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
  * hand-off to the QCLIB firmware image, plus __weak extension points a
- * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries
+ * and provide SoC-specific reset sequences.
  */
 
 #include <cpu_func.h>
@@ -15,6 +16,17 @@
 
 static u64 g_qcsdi_address __section(".data");
 static u64 g_log_buffer_entry __section(".data");
+static u64 g_ddr_sr_exit_address __section(".data");
+
+u64 qclib_get_ddr_sr_exit_address(void)
+{
+	return g_ddr_sr_exit_address;
+}
+
+void qclib_set_ddr_sr_exit_address(u64 address)
+{
+	g_ddr_sr_exit_address = address;
+}
 
 u64 qclib_get_qcsdi_address(void)
 {
@@ -36,6 +48,42 @@ void qclib_set_log_buffer_entry(u64 address)
 	g_log_buffer_entry = address;
 }
 
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size)
+{
+	uint entry_idx = table->num_entries;
+
+	if (entry_idx >= table->max_entries)
+		return -ENOSPC;
+
+	memset(&table->if_table_entries[entry_idx], 0,
+	       sizeof(table->if_table_entries[entry_idx]));
+	memcpy(table->if_table_entries[entry_idx].entry_name, name, strlen(name));
+	table->if_table_entries[entry_idx].address = address;
+	table->if_table_entries[entry_idx].size = size;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size)
+{
+	int node, ret;
+	u64 address;
+
+	node = fdt_subnode_offset(fit, images_node, name);
+	if (node < 0)
+		return -ENOENT;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, node, &address);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, name, address, size);
+}
+
 bool __weak qcom_spl_soc_check_dload_mode(void)
 {
 	return false;
@@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
 
 int __weak qcom_spl_soc_pre_qclib_routine(void)
 {
+	qcom_spl_soc_shrm_reset();
+
 	return 0;
 }
 
@@ -60,7 +110,7 @@ int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
 int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 					  const void *fit, int images_node)
 {
-	struct interface_table_entry *log_buffer_entry;
+	int ret;
 
 	memset(if_tbl, 0, sizeof(struct interface_table));
 	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
@@ -68,17 +118,10 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if_tbl->num_entries = 0;
 	if_tbl->max_entries = MAX_ENTRIES;
 
-	/*
-	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
-	 * QCLIB fills in the address itself; SPL just allocates the entry.
-	 */
-	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
-	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
-	       strlen(QCLIB_LOG_BUFFER));
-	log_buffer_entry->address = 0;
-	log_buffer_entry->size = 0;
-	log_buffer_entry->attributes = 0;
-	if_tbl->num_entries++;
+	/* Reserve the common qclib_log_buffer slot. */
+	ret = qclib_add_iftbl_entry(if_tbl, QCLIB_LOG_BUFFER, 0, 0);
+	if (ret)
+		return ret;
 
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
@@ -146,9 +189,13 @@ int qcom_spl_invoke_qclib(void)
 		register void *x0 asm("x0") = &if_tbl;
 		register void *x1 asm("x1") = NULL;
 		register u64 x8 asm("x8") = entry_point;
+		u64 saved_x18;
 
-		asm volatile ("blr x8"
-			      : "+r" (x0)
+		/* U-Boot keeps global data in x18 on AArch64. */
+		asm volatile ("str x18, %1\n\t"
+			      "blr x8\n\t"
+			      "ldr x18, %1"
+			      : "+r" (x0), "=m" (saved_x18)
 			      : "r" (x1), "r" (x8)
 			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
 				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
-- 
2.34.1

