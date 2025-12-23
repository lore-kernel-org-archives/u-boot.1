Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71227E6B261
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 05:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A8583DEB;
	Tue, 23 Dec 2025 06:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DwklFr4n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOnv+L+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151E483E8E; Tue, 23 Dec 2025 06:11:40 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD22083D1A
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 06:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BN2LHD41531701
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 05:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sIOn5riiEioi5jz92MBDEvuZ
 ca6rW3Tmze337EXi9Ps=; b=DwklFr4nbhPRJk/uIlVhDmzXtxk40pqkW8+4YpyF
 WWlRxRECUUuUyJFPT66ccjKexijs6i5NtHEC02mrbVc434tYTd5QQ5ejha5NNK31
 XJEB0kp8hSLHgwsyThh+yQqhd9AZFr+AFGLuI7q4KRylDZdaeTXdyNR7Qk85AJbE
 ZBvfcCDft5olSwXvngmeBTXz99aigHrNzAGlBMkiYR3VaGdN284eo0r2QQcRa/s+
 nXMHWRD2IFQbAldsbBHSjTonyT4sJtsObwK31bW5W4x9Ivw5lr9xE34i8MuUzDCZ
 fIbVHnstynsVayA1rxjJErZL/YdlLI3dWlu5DvhivRvkNQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y2mkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 05:11:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a0d43fcb2fso149623605ad.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766466695; x=1767071495; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sIOn5riiEioi5jz92MBDEvuZca6rW3Tmze337EXi9Ps=;
 b=dOnv+L+BXfZdHEkt4NL8mreis438SGll5tlfEoRP+76pKIfPH3WwZmIe7VuEz5qnCf
 BoZWdsPSMTadZIhKHUFgHchLhiIoNE1fgYfTU5PJPvuoyuBONVKO2SkpWYLF6clm5Tzu
 3tr6pvU5w4URsNpyepPKE3G0Kf/oNJ8PYX/Mu0dOeiQ9vtuc2tyvgF5YItzuDuA3ataS
 UNzM60DEL8DILymFzYJCDar00Y2i+ghcHHNf9JK9ISNn3svIIhBMqUwCydJwaG1SYaMT
 w10npZjEkSHcwc5MP269SVVf3J4yNZsMhRTr7FPmVcv8WCbB1mD+oWn9y1WOYbWVdeqE
 GGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766466695; x=1767071495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIOn5riiEioi5jz92MBDEvuZca6rW3Tmze337EXi9Ps=;
 b=XA/QLBlwzCAvybZj4vQlHAohYPkwpXG/R3Hj2i42OwBftXTe9rKMvveONsgZ+2xn6C
 HU42NCaSwXydlfH9FlUjA3M10P4c3iJgePXx0DQG8wrG88Psh2ZE5x8Y1xHLuaDPA083
 dFklIHxiE8GDN+Zg20AqzFXGjkXzRdCwuHAe4ieFYWvbT3tSR/02a0Q65LHUV8TeXNnc
 HnvbSt9NcMRwkSdmYHJZ/b+ycy1btganXyWNa0yTcm3EBDxxyhAKwq5XQvpHE+mPKzzc
 cusPQE83M7yWev8Fye74yaJvgUks11rL1hGbm5tnawFXSSsVvaUsXqjJagd9TeabxuVi
 /lrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu/9aGHpsAlyWCYkjMSl5jgBYksGipLvpehx3+NqcONWZCcqE3SnzYM5SZ1OXDc/BvbQaueog=@lists.denx.de
X-Gm-Message-State: AOJu0YzSUsapQRcHsNcFbp/ClEBRCokcFNeE2FI6YX3+zsw/P+eOxRiI
 UOfwW0J1hZs1CyHHbZJalbGkY4Ruhed2POaCg4ba5fUmmpoAsfvrgnX305kp6h+rfqgudYFsVBe
 Ts+jbQSYfiyU776O6lvehrrMhEI/PtfAs7ggC7vkfBnJm9/yJGxFUXySq
X-Gm-Gg: AY/fxX6FKUfvFPs3O3O9UKDnUuC0E4R5xZblt1ATPJNGsQG2SNCqV2xfl3DiSuHjmOf
 V9haiD/T7xL29EP+LdzLi/pe/NcTpvPnlAg794SorEHOuuR2emcveIR9NDJJPeDGvVopSPp1ojr
 QIwnU3jr1wfEG+16MFTrs1WugGDS30uvaubSLA6gb+NetP7a79FwfVa6LwbRPt8Qso3LpraC2JJ
 g+7oGaJcDg9dOQKbOHIY2Yvey5zttrYTzAd/ROAEvWXR3WV5l3oCsLYhTjgaiyQD0ovxr18W7XX
 yX8cEAlKHuYuWlnvh8S2VCbpADYaOC8C6BlnXGlGnaWbvuVn6p0ymeR9t7FKlK83xLUJYdKC+NY
 1MQ6yt+o9dt/yMlg9ffSMAEdpGbmTPm4n7da6PbFadKmx0MkW8bCRCtmjSqyP4K4jKQIZkDbj/r
 cm2XayHSzYL2gpudAh1vtY7HdoutEWU1ZTv6TwaL8=
X-Received: by 2002:a17:903:290:b0:2a1:e19:ff5 with SMTP id
 d9443c01a7336-2a2f273818fmr146978035ad.38.1766466695012; 
 Mon, 22 Dec 2025 21:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdbUH9+LS7GnWKEIcVrCXnbc/h2xwRtf4GaFc6TRcGq8tdaKtWtp/pPDu5AETSn8nf1MCY6w==
X-Received: by 2002:a17:903:290:b0:2a1:e19:ff5 with SMTP id
 d9443c01a7336-2a2f273818fmr146977725ad.38.1766466694562; 
 Mon, 22 Dec 2025 21:11:34 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5e467sm45084615ad.83.2025.12.22.21.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 21:11:34 -0800 (PST)
Date: Tue, 23 Dec 2025 10:41:28 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 6/6] doc: board/qualcomm: Update RDP flashing
 instructions
Message-ID: <aUokgCzdxE8jSED2@hu-varada-blr.qualcomm.com>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-7-varadarajan.narayanan@oss.qualcomm.com>
 <aUVkq7zt5PG7nZZo@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUVkq7zt5PG7nZZo@sumit-xelite>
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=694a2487 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YYPRvsH4Cy3J0qxLkX0A:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Rd9EwJt4IB65jC0UG13jSSFkuUQm9rqc
X-Proofpoint-GUID: Rd9EwJt4IB65jC0UG13jSSFkuUQm9rqc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA0MSBTYWx0ZWRfX0E54olpCKoCw
 XeiBRVf//PJ+AejXJmeh7ACj8q0nk9U7NzIcuuLzYVb8lu1LsH9awahepLKcOuDbdHsPzsKwb9l
 TNYZ7//6riMk+DuOt3PCv/bGyhHfDl87McKu+6GC1Ghh27mqC1Sp8wJmJI7MKLC5qD0yAJiW+7z
 TiWoCp/dNPrmbRuE5gfFw/MIt7viLoLUlurjadHRXA++W3lAmtADyRpjcr8LzebvyxHH9pfQNA9
 MSGvLwpSShLRUYPvZuWR4IYxrD2k5n8Yq0ae+X1Cm36jRXKR9iFcX9jQ9GHPQxCGvWfEAZJa12l
 yuF3xvnqAczAxGmX4GHqdJvDy25N11h5VGuRL0z7o5iDM8V6aJjysx26+5aVn+nqLmpy1Fkpthr
 ZWOo/aCFZoKMNoc/T6TXR2QHuIhZKtpOti2aWLLutbrk25pnvRAQVg67sWYozRSZKxFoOzOL7mj
 O1a7Yz84HXxf74w0lcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230041
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, Dec 19, 2025 at 08:13:55PM +0530, Sumit Garg wrote:
> On Thu, Dec 18, 2025 at 11:45:57AM +0530, Varadarajan Narayanan wrote:
> > Update the flashing instructions to include fastboot.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >  doc/board/qualcomm/rdp.rst | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > index 99cf8eba57c..97a64e4677c 100644
> > --- a/doc/board/qualcomm/rdp.rst
> > +++ b/doc/board/qualcomm/rdp.rst
> > @@ -42,6 +42,20 @@ on your device with::
> >
> >  U-Boot should be running after a reboot (``reset``).
> >
> > +This U-Boot doesn't have the n/w driver.
>
> Can you expand a bit on "n/w driver" a bit?

This board is capable of network connectivity over ethernet. However,
the relevant network driver is not available yet for U-Boot. Hence,
trying to enable fastboot to update firmware.

-Varada

> > To restore the original U-Boot or flash
> > +modified versions of the above built U-Boot, 'fastboot' can be used.
> > +
> > +  => setenv serial# ipq9574
> > +  => fastboot usb 0
> > +
> > +  C:\>.\fastboot.exe devices
> > +  ipq9574  fastboot
> > +
> > +  C:\>.\fastboot flash 0:APPSBL u-boot.mbn
> > +  Sending '0:APPSBL' (620 KB)                        OKAY [  0.042s]
> > +  Writing '0:APPSBL'                                 OKAY [  0.030s]
> > +  Finished. Total time: 0.342s
> > +
> >  .. WARNING
> >  	Boards with newer software versions would automatically go the emergency
> >  	download (EDL) mode if U-Boot is not functioning as expected. If its a
> > --
> > 2.34.1
> >
