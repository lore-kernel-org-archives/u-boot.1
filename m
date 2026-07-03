Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370D4C43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 848F1841F2;
	Fri,  3 Jul 2026 09:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fUxzi+kl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="byIRaL0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503B784671; Fri,  3 Jul 2026 09:28:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC8698407E
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 09:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rlO43108960
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 07:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n1MvlhlWT8nSV1vQcC6VK+CZn/1I9MaujjJO4vaYmeA=; b=fUxzi+klaJOCvsYx
 uBRdr8FKUMoob4gGsB+dpkBuu7rqMPn3OCCtLH8GeJoXlq16rKLJl7Epj65MNvU+
 nH1oXP8aP3yiuT5o925nFemrhvbgqbmQFJcxg2JR7dpPTahazxxVeLYUbl34zZbO
 x/1SyOiWempGGgeqaNveYJu7bQJRqu/j4mk9m2l7RgwgzAP3kSZ2nXU31TMt/G5Y
 AQ8zyXUm6wESmY3V2M98rxQxprEj3BPkhPMIXmNraU7bOuk2PYFJdTaxhvvJgJJX
 MHEl9eKXHlWIOlLTjVw4KxtPjbiU0PGi6BHjsioLhR0dkkRRZrtm1pPRwaMf0Emw
 UKZnfQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60ey9vvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 07:28:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88da04b719so271730a12.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783063726; x=1783668526; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n1MvlhlWT8nSV1vQcC6VK+CZn/1I9MaujjJO4vaYmeA=;
 b=byIRaL0KcxObL2jHB2TGRaKTAtoIofLzjsifCXt9i+zUHGtOZei5w+Er5O1eM99vYm
 0jJ2QF5Sh+tARWDj7mrE+Jjz0mrNRxl1b/LZDenLl1SJDjJYjYroAvUXs0Y+0IdRtYcn
 BJT0EWyOsJ5eHy5G9QHUjR1Arnm20k6Te5uFort9YfZUcuIAEqzMs5/zNePFwKxxxiN/
 G6vNSIay1XOqkp7Hyf4sHkbixvPLJtBvBiMuwWtH98rPhgsmAQ4kxxDtddl+7SRgE0Qz
 TdORzNr1FYM4md9uJSgQT9/RhIjc3q/Sxoltxd2guRSsHLnd42muFtKfBkP8S3bauBhz
 3SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783063726; x=1783668526;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n1MvlhlWT8nSV1vQcC6VK+CZn/1I9MaujjJO4vaYmeA=;
 b=iCo7jVubQA06ODsdUNlT14JpBrPn2HNcgcy55bi/iv7xmbBzHG19ZYEYbVBA8OMsmT
 3O7zJ8lsHe/EubIW8QUk84Wk2hv5nQPUoQFHIFcMtvWBgVwRwut5jCu0n/98xFB10TMS
 nAkVGyK/3JXt0XBTdWiNRLfxEuHPqK7KSnadxXrhN6SxVg4BOBSej4MfqRixE3/Lsr4+
 dpim+7vgBylTTWTLoI5hdg9iYcuAAvodkGA4+hcbwlaKUZcUCfKWb/SiZSsUVOkLyw1U
 c1AIC4JCBfRNa715f80tMkzlpCIL7bdVJr+diP5XdkMspMhFf1YKjH3qh7a6oja3LWu8
 6zow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OW6cTTZwELOhsCjuMxj6xv+0BXvzZF5TdYjZ+1BqdjktR3oZNJMzpnus2ufDg6eiIYKr2Jz8=@lists.denx.de
X-Gm-Message-State: AOJu0YyNhJuJH0hizzdTE053ZzPFxWkgf1/UcN5CQGa3tr57iiczB8hl
 4+NOxwHuAFdaf5UGhC4lrz/TJoUaGP4b880ZBubbgK/xwc29Sd+RQYCRRMm6Xm7CyPQbTX45Sh+
 o09TkWZYGP2Hc+QQ3twIS4p635njTu4hGlqtaVH6Z01mYaCgplU5LZ3bF
X-Gm-Gg: AfdE7cllOSMumFhTvcpNUlGS/fgEk9qqf+5dUzUiKn+7XDf2WQIqtcV7vYDgheGnSk3
 YYnE+TKObW4+0MrT/PvPQa7xZe8gFzMtcYoJTpK2UIFZwlUwQ5jDzavBeVl7d2S+hpa0rBAFDNs
 zO9Qzb9McV8ASxY8Yv3RMWdW/A2yOA9I6zOpVt2PVXW7X1SIljsjEEzHXX1XwaHl3faNeVaamzz
 NxhuKF/60E3tzMQMlLc1AeiaVcP1NWrK5EfQQR0NXMNNyCrV8cG9yHJPCg30jjMIPkYzAXnL1tT
 UzVxijlgXTCh1VhrdTQLQTMbMKsC9oC0ZXC1xMlBtfjGv+5bd2KynrGD0mZZvYjnaJqZb0l56MC
 HtGNcqqN46QoRfOotc96H77TrgRfmQCDUwgC/7UdgBuGyU3ZAZx6Cvf1hrI6xBOjq14+As9hnix
 DoNmEFiw3cjZceLXz2+dPqNy8vs0TwxyLSFf9U4jRa
X-Received: by 2002:a05:6a20:4310:b0:3bf:c12c:2ecf with SMTP id
 adf61e73a8af0-3bff430fae9mr9600684637.59.1783063726187; 
 Fri, 03 Jul 2026 00:28:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:4310:b0:3bf:c12c:2ecf with SMTP id
 adf61e73a8af0-3bff430fae9mr9600644637.59.1783063725727; 
 Fri, 03 Jul 2026 00:28:45 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm15580890c88.11.2026.07.03.00.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 00:28:45 -0700 (PDT)
Date: Fri, 3 Jul 2026 12:58:37 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de
Subject: Re: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <akdkpczZxCWRvBm+@hu-varada-blr.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
 <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
 <4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de>
 <20260623165021.GJ382693@bill-the-cat>
 <0a0af22c-ce8f-4c41-84bb-32d1b949c1f0@cherry.de>
 <20260702174613.GC749385@bill-the-cat>
 <akdG1STYeiKYRjZo@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akdG1STYeiKYRjZo@hu-varada-blr.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2OSBTYWx0ZWRfXy6VO62eWmdeE
 2gecdZuse/mCW38TonhmK2hDGJRPADtqbmarZhl9SUaCEN7aJ4Vq5fVteFNSC4cBNXm8Ia3R403
 +wW9FaycEeyj61OeIn/4wqIb+BcDtiXX7SeW9gv/HYuZmw26Y6EYhsEke01sbhI1mZ48y+OCyTD
 ZeM0i8PSk088Gw9cq1GGiz95VYgNjcQ6ejWsrylbgROJ7qqyVVFTrCWavzGIdTnoEk4S4WCv7OF
 13KfHt4qfyswS4TmpNCs0HlidVIIwTVcHdbKQfJs06tIOltADTlMkjyI9b3P8EhejC7eB37Ww1f
 Ujp/DH41D7GVpvSmEHvNnVBQYqk4RD16O8tlR89iCny+LIvBEmK3X5Ovn4W/GejgW/s3uYUr2rM
 E5EqQ3Hri8jIfBrZ8yoS4Iu/8ElP8tLXgbNZJJft0bb+nbtyIR+DJ4w+6+nUt3IJ1651tl6gir2
 29y7m2L7Q0zjoCCuU5g==
X-Proofpoint-GUID: 9DP8maNUesI57eHiwYHf0dD1fx8nGQSS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2OSBTYWx0ZWRfXzf8JlpQpqVQf
 0zHwqQdsX+CEMydocadXKQdZH6Ca8Y3426Fr8C/2ZyVxhoA8vVjvb5X0UDt5CAoKaYu4yS9hLQ0
 RYsL/ZcP4fGSRBgBr2kIaIrFwt13BB8=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a4764af cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Jbssjx0sovcfAvcieLQA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 9DP8maNUesI57eHiwYHf0dD1fx8nGQSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030069
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

On Fri, Jul 03, 2026 at 10:51:37AM +0530, Varadarajan Narayanan wrote:
> Quentin Schulz/Tom Rini,
>
> [ . . . ]
>
> > > > > > The issue is that the first sysreset device implementing the request_arg
> > > > > > callback will consume the args and return EPROTONOSUPPORT which will
> > > > > > stop the loop.
> > > > > >
> > > > > > Think about multiple sysreset devices, and let's say we have a new '-
> > > > > > dummy' argument to the reset CLI command, then it'll depend on the
> > > > > > registration order of the sysreset driver whether the dummy argument
> > > > > > will be handled by the qcom driver which will return -
> > > > > > EPROTONOSUPPORT since it isn't '-edl', or by the dummy sysreset driver.
> > > > > >
> > > > > > I think we should have a fourth possible return code which is "I don't
> > > > > > know how to handle this argument", e.g. à-la IRQ_NONE in Linux kernel
> > > > > > for interrupts that aren't for the device this IRQ handler was triggered
> > > > > > for. Or maybe we should really be using -EPROTONOSUPPORT for that
> > > > > > meaning and not exit the loop if that's the return code?
> > > > > >
> > > > > > Or maybe I misread or misunderstood the code?
> > > >
> > > > Following up here.
> > > >
> > >
> > > Do we end up reverting just before the release then?
> >
> > Please send it out, cc everyone, and see if that gets some response?
>
> Sorry about the delay. Will post a change shortly.

Please review [1]

Thanks
Varada

1 - https://lore.kernel.org/u-boot/20260703-walk-arg-fix-v1-1-64beca00d7e2@oss.qualcomm.com/
