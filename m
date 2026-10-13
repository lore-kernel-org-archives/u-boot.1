Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D56DCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C68FC60688;
	Tue, 13 Oct 2026 13:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SF0gs2v4865j; Tue, 13 Oct 2026 13:08:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AEC1605F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896880;
	b=ZA64ayHXyucN0CY9QXQrLvG+rCeo1eKrsfBwt6e9S9UiTaVCKeYLfqcgurKJzjpbQOC9
	 1DcNrKGakwlCJxqtKtLpeQHcn0csBuQGU6t5DH/pEz3AagarAUzWVab+emModG4zrA2a6
	 O2dIRgO639WRiKnWAGwN/BMMy/43rZMuBxpgJ6t52uGuOOBfxWXZU2HGepjYq61ZkUtQs
	 tFYODBLuxZ59aZBncW+0z9FW/MzGHe7Y2KBehUJulelp4tpYcLaxJgfW3/7G/cx6zgB1P
	 yZ1u4gAGNyck0CAdtMLZ0mNA2fV40Mv78CAowoq+N9PuBMJtNmJKJMCn6/gj36LfVtg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mDnBU5bRLYdfU8rgBSmijRlJY28ib/ohaxTCgqz7MBg=;
	b=jgKFYpcOcPNGziPRF8dfW/NM/t5f2N9xMbgDoq4lEMPMBrT0IQPAUCWZ6C5ldNQ+RFsB
	 Q1zzyUCKntYc0ZcPFONNag79mdM5uFAHMtvoGmS+TJMkP5eqLzI14VFkUyiT0ppDsnSlb
	 LDwGLuxfjXnnPNDGOSQ//WBhKd4UHD5zXI9TnGpBscwQdcKdIBhi1R5zvXgWaD3nyvTku
	 FGZoxDcLALb1ySSuUy8XkcXibnOUu3nNcU5UIGiI+r2yS6rofIKNcUCtnsi8Ma3OiQzdf
	 8u4dSvWEFX7BrNJ6P6FFrfTd2zIHKu5bErsWglKJYqA6Mu+pXHgCGlFfMgYPMnNOGhw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896880;
	bh=mDnBU5bRLYdfU8rgBSmijRlJY28ib/ohaxTCgqz7MBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJCZB8aLbz8/sJbHp0FSZGLp6Y5EBg6m2RscD2dKvVDhbGDha2c+/MLxg1y+MJk8L
	 8E7lr99kDxq+r8SEY8ftljMWXGsDLwwZuPuUyk7HXhhpRqPrzJivLNA2Zy7NAkT3Q/
	 bSUBDqZUWVuXdZhLlpxvXd6OSJZbIuYbW74+x53WkzpRLy3Irnu0jymekb2JAz6zcB
	 KRBv5msNehJoBOaJMXrUwT+BmbzLbU+KXVnFc9wF3QGiIt+6p7v8J5M7GsX+fcCzI5
	 N2CN9cffYd0EGImvCa2UkUV/Ru/AdumOfICMpHmMYFXvmtLNYMLTMhy1+uJurtFVIY
	 gxzOCrK8b+J3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AEC1605F4;
	Tue, 13 Oct 2026 13:08:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82E50235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 743124035C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:07:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktWmAsGaW79c for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:07:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AD6F40311
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896877;
 b=q+eqVbMJ8qRGCHE4sb9Ey8ep6lgpjOtxisM6MWYRPG1RnP4AE5ANudufZs+akCCVlOUf
 fFrSGOWOI5CGXtaixq5xHY8ZWAj20VgoenmOLnOWpqKUeZIbbxJ6/iMW3hqLiFTh9oOY1
 aW939f7EtbpmgIAYhvlhM9VpyT+QPt9kn+JrcBLDVrGlsvuABJwyH+Fp4DtaYfZg1NBWj
 BiR/4G1mAclXt0N8h/oTscA3+XdWtOPy6tEPkxSxAqNmxMzfEhpWbaxVQKRUHYq3msfFL
 fhpiFGRfq1CJWqUzud+gQGsMTyrTJF39PPuGXe1rIlk0ubiGrdG0yYu0PxCcgIY187g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896877;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=mDnBU5bRLYdfU8rgBSmijRlJY28ib/ohaxTCgqz7MBg=;
 b=s5PLWMj54oiAi6w3qFZepnRopQhwOkpujlI8rufxAg0o6rrK62/Qymq7c9yEcaXlxUkj
 T5TMZzHp8/i5zO6buGArx8UJltOJkdW/gZrZxxGvinRTyF5PKFvC3ysxSMRo447rjQOkF
 rzyE54aAgsN4fInm3W6d570RYzm0InNnGzc9rVZ1YK9GlC4/EKzsKG36nNFsYyeFW0IeM
 QozJdZoeBBIhczAS5AJXy7gQK1QD8mdZjvxSN0WtJVT2waIFTbgqZgHYimyJh/7ARVg73
 BkmWjruVL31n4lCbVtGZdim9A8LECdcDxVPIgBWX46sLP+ixSFVvyt6kEVy7EIC5aeQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BQYyYWmM; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Oa56Rxj3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BQYyYWmM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Oa56Rxj3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AD6F40311
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:07:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8UrYO922843
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mDnBU5bRLYdfU8rgBSmijRlJY28ib/ohaxTCgqz7MBg=; b=BQYyYWmMximDsKwT
 t3Fmcpcsg6szhg1FUWPFLhnAGMAy4Ggg6EuAh9MHPW4wfmU8QUFicyQzz2KL5bxd
 YTt4PFC6++uoW1ZmV6GiDYure2k+WRyGJw0NmKygNmzBDepT+fBtuqB4hIhq93XZ
 wHKsnuIghBYrCXRK8yRo1UxqNknYztOVIlWY1GUWfqisSUa3gVibRkOKWmxu1NqZ
 VD+0+lZMG678ThSaR/pZt4nxnT36ngVqhGdMqCWipkjBWfBH9DFzEIwUeJWk3d3z
 JyhhGDxr7xN3OhHniZevpgbb3oyph1jW8nH3gD3hIsbQczmrae8ofceaaHcWuXEB
 F0X7IQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1u2kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:07:55 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66f81a0f5c9so4933755d50.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791896874; cv=none;
 d=google.com; s=arc-20260327;
 b=G2lAM5XOEqrZIBW2YNImfVJkfI9EMs8wzkLOJaAkqut5i9lC+6fI8jKIvn9xNBWMWh
 B5+aV36zNTf4kDGt+99/8tZmUbQMzRJ3lMKGeeMnni5gzt9aDuCEGrwpkB9lRktdzcwy
 I+S0BqsCBXfLFNUaCOGBQluEeJewjfsEGxqz5vc6tSA0CaiS+z2Wels5qrjr68qx4ooQ
 Sop+e/+u2NFUU4/moVDF4wYhNOqbs4WDSgmj+cwcM/J0tvfSIrO15/M14XUbP2/EXKrU
 RQpgdSZ1dhamSofzlrwdEridNr523VM9DduVrk5Mx1qiQ4qx7teS9pZZoFrjYQa4zEBz
 WztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mDnBU5bRLYdfU8rgBSmijRlJY28ib/ohaxTCgqz7MBg=;
 fh=yGPX4F1ZspDZjnMFbJONZ6IoSMqzdEYEekyCIHhxNto=;
 b=YNivKw/z5j4YDAgvDS3gLy7txJDw6BxBB7x/rHKl71TrF8fAItXxGrk4IhAshrSGkx
 JAVblB1I4RP4dw8UGE6YIWLRWqcICvkQJqZsGm/5xhJtvh30m7elcsRrsAogYlqxTj30
 8nktgBeUYeZC5CDWUWJrLB6mbntJDnklADlBTUGMx7XTgpd9QPtlO5wjj2OQbdbokSTX
 rIM/Njprj29LnPPGyiGrds2rSPKiZdGBaqxyToKL6b64CeQzy2g60ut7a44wsHVYq9pp
 FIi21ek6I2n7ymGCJxuC3c5qUJT5vthiGGN9uL4Z7MVMt8nt8N1lU4SxKaf1LDPWSCQz
 m2DQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791896874; x=1792501674;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mDnBU5bRLYdfU8rgBSmijRlJY28ib/ohaxTCgqz7MBg=;
 b=Oa56Rxj3QGHuy7k8MMhp1flp6DvDKm4yZbTp2g0QH6I3JHaVY07EEru9tjiMDTqHan
 B0eFajEeSyb1/XskYjityT6PVQVMt3N9RNms0coSK7bocRq2/bUhxzF/ycpPG4UHkqs+
 oUP/Ih3BIDeNwD05mZwvfbOGK0r1OjfNBqN4nu3VGdfmYmSjy9eEKkIPcCRwxnodxAy7
 o/Ul7xxiOkYijim87veVkALCo+TeZ2AIuJAamfRNekWtjLJef2jcrygOf9OIPm7nZq18
 0U65ii+C4afCWFFJ5VRGHpZcAc2FCpHGsTetZ0c3aRCWLfmZ/vZiGWqKsaZlC7dqW7Hv
 f/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791896874; x=1792501674;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mDnBU5bRLYdfU8rgBSmijRlJY28ib/ohaxTCgqz7MBg=;
 b=r1xgdSj8uU5hMjRE9wC88qAuMROfizqMsnBv5BwKCbPWEToPnqh+zY1CEY3JDBEOYP
 3H2+ayImAr4MsqyaEfVM2YmtiIpm4quOQdCmvrMoje4IkGe3/1MAjDqzH4w3oHEOKM8L
 bzblD4UixkViygH2qMZPmC8mVuMoJ+reQJySQCmwksFASDhOU7TuNNsvFJO/MsDfk9ve
 LQYWG9zg72pwNzWng9h3ADKXXoxTuQ3plFBVrrGTKIUH1p/th2byoJcLPFpr9reQQ19Z
 gAZ+KxSalqo9ATUzCUwKhuqOHmjUeqsCe0G7A54PDOgzuBx9h0EZJe1HOi7YiDaWQpnM
 KICA==
X-Gm-Message-State: AFq9FYJEML8oVFE29Oq+mdMyWa6958DyZZyIaJWz5lnV4R+QkPVTNH8T
 a6Upj0fgB04R8mhVp6EB3C0OadCV5mrYzmwfcYlhFH5LIdcHZp3hKiRgjOtrrA1ZVMo10vOQfhZ
 oucaB3aetiB/rnrMrovaSmf6+fAoLNoZgvxwj6E8a7YtI7IyS6N1oUUtzQbyQNisbfV2+ZWXuH+
 gX3rYcBIQ5VtxMOhKyoV1vJeERbuD13if/X67YfU6S87yTVQ==
X-Gm-Gg: AYBFou3/HUoP9xTXdSguEDXlcfWeCDC2xG2rFuwKpQA04Al8tto77WKOsGoN/QtILCh
 5Y54p9gUoDM5Wr+omLoXQslwnn/fkoOAVe+Akn89ZvpyyrFRIsO/Qu8uQm4amezC0wR52QbCUo8
 iIkseg3iT+4lIps0J7ga1+d7fYk2cJVsWaisvkXeeVXT1odIRpNbOsRqTIqg==
X-Received: by 2002:a05:690e:4106:b0:677:b99d:88a1 with SMTP id
 956f58d0204a3-6793600cd5cmr3994088d50.33.1791896874083; 
 Tue, 13 Oct 2026 06:07:54 -0700 (PDT)
X-Received: by 2002:a05:690e:4106:b0:677:b99d:88a1 with SMTP id
 956f58d0204a3-6793600cd5cmr3994076d50.33.1791896873542; Tue, 13 Oct 2026
 06:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
 <20261013-snagboot-v7-8-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-8-fc296a32836a@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:07:41 +0200
X-Gm-Features: AclHuK9es00TJ-03J-UIF13qhlPL2Y4jTFdxzrRIeUyie8ltANXFLmDVeK6Lxos
Message-ID: <CAPzfCAb8nVn0XSufjg+zZqp3j6ueWMXJDXZu46KxJqNLzB_GmA@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] doc: qualcomm: Add snagboot mode documentation
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace2d2b cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=cSziVDP4AAAA:20 a=EUspDBNiAAAA:8
 a=SQLdX9FXi2zifaTzwZAA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: sSNM9iu5akEbzL5W9cklwhQv8wzZFWVL
X-Proofpoint-ORIG-GUID: sSNM9iu5akEbzL5W9cklwhQv8wzZFWVL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX9ezjNndFXopp
 qCRNPavDvBCXt6IQnnI73w64doOgt8X+uGXaFmVufEi1w1XBdbsEFheVWAMLOjzgEvvfPla1B6c
 QXIFtkVYMc43Iu06JttoezUsOmT9U8c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX4TMMGlPH3fDt
 C7EVZxp/krtGs/i+aXdnFCxX/3eJ8IORBs9hN7NrmZfa1oI8FPGT5Cp3wlvWyhNUtG+Ltjn92jB
 q0qiB5+IT4gONFkXUTfsGxyYWtafQbHdCcy8CtiDHGXHLKXl8vma4ZBx9uqUiX03Z+oBuMe9FR0
 EF2O5N3o5kxrqLZHgWZ75aYcMUidl+yF4wB7NySWeu/f11KRikKeM9I0lT9Ltaj02ABTuValq3O
 7ppqBv9rkNtTjb41LJaOQG7jtmaFsUs2NDiYB4uUAJL5CJCcNMRUFHCmX6JbLYENDEGcRqoAFl3
 lHA208P/ltL6m4Cr+OULvQ7QZgHKjF0QecA5hIPgSKxC4MGbbh6hHgU9mz4ryfiugH5Btlf+l8q
 woQUhKmJTualdh6Yz786X8D6f91wLXyr3PKFx8b2+qVVgyzNEhsTWuxPaE00tPNPDE0GOAyWCx0
 9y81btSSThG7wtLQcDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130052
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

Hi Balaji,

On Tue, Oct 13, 2026 at 3:54=E2=80=AFAM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Add documentation for snagboot mode support on Qualcomm platforms.
> This covers build steps to compile U-Boot for Snagboot mode for
> Lemans-EVK along with the architecture, execution flow, and Snagboot
> enablement requirements.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v7:
> - Rebased on top of latest file
>
> Changes in v5:
> - Added build steps for U-Boot in Snagboot mode
>
> Changes in v4:
> - Newly added in v4
> ---
>  doc/board/qualcomm/index.rst    |   1 +
>  doc/board/qualcomm/snagboot.rst | 224 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 225 insertions(+)
>
> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
> index 56b8d894c2a..b8bc37bb384 100644
> --- a/doc/board/qualcomm/index.rst
> +++ b/doc/board/qualcomm/index.rst
> @@ -17,3 +17,4 @@ Qualcomm
>     rdp
>     signing
>     spl
> +   snagboot
> diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboo=
t.rst
> new file mode 100644
> index 00000000000..0cbde61253d
> --- /dev/null
> +++ b/doc/board/qualcomm/snagboot.rst
> @@ -0,0 +1,224 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Snagboot Mode for Qualcomm Platforms
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +Snagboot is an open-source, scriptable flashing framework that provides
> +an alternative to the proprietary Firehose protocol for device

a bit off-topic and just a note that this should change soon: there is
an ongoing effort
to make the Firehose spec open and community-driven, and eventually to upst=
ream
support for the protocol in both U-Boot and EDK2.
On the host side, QDL [1] is already a completely open-source tool
that implements almost
all Firehose features. I currently work on and maintain it.

Also my two cents here: I personally find fastboot a much weaker flashing
protocol than Firehose. For example, it lacks UFS provisioning,
device/LUN selection and
storage identity, whole-device erase, raw sector writes, on-device
digests, validated image
programming, and device control (e.g. rebooting back to EDL). That
said, I agree that it
does its job and is more widely adopted than other protocols.

[1] https://github.com/linux-msm/qdl

> +provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
> +Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
> +and execute bootloaders. However, instead of using the proprietary
> +Firehose programmer, Snagboot loads U-Boot into DDR and uses the
> +standard fastboot protocol for device flashing.
> +
> +The framework consists of three modular components:
> +
> +* **snagrecover**: Downloads XBL/QCLib to initialize DDR and load U-Boot=
 into RAM
> +* **snagflash**: Communicates with U-Boot over USB using fastboot to fla=
sh system images
> +* **snagfactory**: Orchestrates parallel factory flashing tasks
> +
> +Why Snagboot?
> +-------------
> +
> +* EDL + Firehose remains the default and supported factory provisioning =
flow
> +* Customers are requesting support for Snagboot, an open, scriptable fla=
shing framework,
> +  as an alternative option
> +* Snagboot reuses Qualcomm recovery primitives and standard flashing pro=
tocols,
> +  minimizing platform disruption
> +* Provides an open-source alternative to proprietary flashing tools
> +
> +Architecture
> +------------
> +
> +Snagboot Execution Flow on Qualcomm SoCs
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The snagboot execution flow consists of two main phases:
> +
> +**Phase 1 - snagrecover**:
> +
> +1. ROM code enters recovery mode (EDL)
> +2. Snagrecover uses Sahara protocol to download XBL/QCLib to internal me=
mory
> +3. XBL executes and initializes DDR
> +4. Snagrecover downloads U-Boot into DDR
> +5. Control transfers to U-Boot
> +
> +**Phase 2 - snagflash**:
> +
> +1. U-Boot runs in DDR and enters fastboot mode
> +2. Snagflash communicates with U-Boot over USB using fastboot protocol
> +3. System images are flashed to non-volatile memory (UFS, eMMC)
> +
> +Boot Environment Considerations
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In the snagboot execution flow, ROM code in recovery mode loads
> +snagrecover, which downloads XBL to internal memory. XBL executes
> +and initializes DDR, then snagrecover downloads U-Boot into DDR and
> +transfers control to it. At this point, XBL has left the MMU enabled
> +with its own page tables and has not initialized PSCI firmware or
> +populated the Command DB. U-Boot must handle this non-standard boot
> +environment to enter fastboot mode for device flashing.
> +
> +This is why several standard U-Boot features must be disabled in snagboo=
t mode.
> +
> +Comparison with Traditional EDL+Firehose
> +-----------------------------------------
> +
> +**Standard Device Provisioning Path Using EDL and Firehose**:
> +
> +* **Emergency Download Mode (EDL)**:
> +
> +  * EDL is a special boot mode built into Qualcomm SoCs Primary Bootload=
er (PBL) in ROM
> +  * Triggered via hardware strap, software command, or recovery from boo=
t failure
> +
> +* **Sahara Protocol (Stage 1)**:
> +
> +  * Host PC uses Sahara protocol to communicate with the SoC's PBL
> +  * Transfers Device programmer (Firehose) into RAM
> +
> +* **Firehose Protocol (Stage 2)**:
> +
> +  * Once the Firehose Programmer is running on the device, it establishe=
s a Firehose
> +    protocol session with the host
> +  * Host sends XML-based commands to flash firmware images to specific p=
artitions,
> +    erase or read flash memory and manage partition tables
> +  * Integrated into tools like QFIL and PCAT
> +
> +**Snagboot Alternative**:
> +
> +Instead of loading a proprietary Firehose programmer, Snagboot loads U-B=
oot into DDR
> +and uses the standard, open-source fastboot protocol for flashing operat=
ions.
> +
> +Supported Platforms
> +-------------------
> +
> +Currently supported platforms:
> +
> +* **Lemans-EVK **: Initial platform with snagboot support
> +
> +Additional platforms can be enabled by following the board enablement gu=
ide below.
> +
> +Board Enablement
> +----------------
> +
> +To enable snagboot mode on a new platform, follow these steps:
> +
> +Using the Config Fragment
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +A reusable config fragment is provided at ``configs/qcom-snagboot.config=
`` that contains
> +all common snagboot settings. Include it in your platform-specific defco=
nfig::
> +
> +    # Configuration for building U-Boot for snagboot/recovery mode
> +    # on <Your Platform> boards.
> +    #
> +    # For normal production boot, use <platform>_defconfig instead.
> +
> +    #include "qcom_defconfig"
> +    #include "qcom-snagboot.config"
> +
> +    # Platform-specific settings for <Your Platform>
> +
> +    # Address where U-Boot will be loaded
> +    CONFIG_TEXT_BASE=3D0x1c100000
> +    CONFIG_REMAKE_ELF=3Dy
> +    CONFIG_FASTBOOT_BUF_ADDR=3D0xdb300000
> +    CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/<your-board>"
> +
> +    # Timer frequency for your platform
> +    CONFIG_COUNTER_FREQUENCY=3D19200000
> +
> +Enabling ``CONFIG_QCOM_SNAGBOOT_MODE`` (via the fragment) automatically =
selects:
> +
> +* ``CONFIG_QCOM_BOOT0_SNAGBOOT_MODE``: Early boot initialization
> +* ``CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK``: Enable boot0 hooks
> +* ``CONFIG_SKIP_RELOCATE``: Skip relocation (U-Boot runs from load addre=
ss)
> +* ``CONFIG_ENV_IS_NOWHERE``: Ensure recovery works even with corrupted e=
nvironment
> +  storage, since a recovery mechanism should not load a potentially brok=
en or
> +  untrusted environment from the board
> +
> +It also enforces the following at the Kconfig level via ``depends on !X`=
`, so these
> +configs cannot be enabled together with snagboot mode:
> +
> +* ``CONFIG_PSCI_RESET``: Not available in Snagboot mode (XBL doesn't ini=
tialize PSCI firmware)
> +* ``CONFIG_IOMMU``: Not initialized by XBL in Snagboot mode
> +* ``CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR``: Previous bootloader cont=
ext is not preserved
> +  in snagboot mode
> +* ``CONFIG_ENV_IS_IN_SCSI``: Not available in Snagboot mode
> +
> +``CONFIG_QCOM_SNAGBOOT_MODE`` also requires ``CONFIG_COUNTER_FREQUENCY``=
 and
> +``CONFIG_TEXT_BASE`` to be set to a non-zero value.
> +
> +You still need to set the following platform-specific values in your def=
config:
> +
> +* ``CONFIG_COUNTER_FREQUENCY``: Set to your platform's timer frequency (=
e.g., 19200000 for Lemans)
> +* ``CONFIG_TEXT_BASE``: Set to the address where XBL will load U-Boot (e=
.g., 0x1c100000 for Lemans)
> +* ``CONFIG_FASTBOOT_BUF_ADDR``: Set fastboot buffer address for your pla=
tform
> +
> +Example: Lemans-EVK
> +^^^^^^^^^^^^^^^^^^^
> +
> +See ``configs/qcom_lemans_snagboot_defconfig`` for a complete example of=
 a
> +platform-specific snagboot defconfig.
> +
> +Building U-Boot for Snagboot
> +-----------------------------
> +
> +Build Steps
> +^^^^^^^^^^^
> +
> +First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-=
Boot for
> +the Lemans EVK platform::
> +
> +    $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> +    $ make O=3D.output qcom_lemans_snagboot_defconfig
> +    $ make -j8 O=3D.output
> +
> +Expected result: the build completes without errors and ``u-boot.elf`` i=
s
> +available in the ``.output`` directory.
> +
> +Signing Prerequisites
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +* ``u-boot.elf`` (generated from build, located in ``.output/``)
> +* ``swiv_build_utility.py`` =E2=80=94 download from:
> +  https://github.com/qualcomm-linux/boot-firmware-ci/blob/main/tools/swi=
v_build_utility.py
> +* ``qtestsign`` =E2=80=94 clone from ``msm8916-mainline/qtestsign``::
> +
> +    git clone https://github.com/msm8916-mainline/qtestsign
> +
> +Step 1: Generate SWIV ELF
> +""""""""""""""""""""""""""
> +
> +Add the SWIV segment required for TZ-based signing::
> +
> +    python3 swiv_build_utility.py \
> +     .output/u-boot-swiv.elf \
> +     .output/u-boot.elf \
> +     lemans
> +
> +Output::
> +
> +    .output/u-boot-swiv.elf
> +
> +Step 2: Sign Image Using Qtestsign
> +""""""""""""""""""""""""""""""""""
> +
> +Sign the SWIV-enabled ELF using qtestsign (test-key signing)::
> +
> +    <path_to_qtestsign>/qtestsign -v 6 -o .output/u-boot.mbn tz .output/=
u-boot-swiv.elf
> +
> +Output::
> +
> +    .output/u-boot.mbn -> Final Binary to be flashed
> +
> +References
> +----------
> +
> +* Snagboot project: https://github.com/bootlin/snagboot
> +* Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/=
docs
> +* Qualcomm EDL mode: See your platform's technical documentation
>
> --
> 2.34.1
>
