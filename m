Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203BFC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 10:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 747818469D;
	Fri,  3 Jul 2026 12:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uhe2uG6v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCKHt30s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05052846A4; Fri,  3 Jul 2026 12:28:06 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5EB841F2
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 12:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635ri0q3134735
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 10:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ipB/hMd33XeJT0Rhb9bqYmk0
 wi4z/PFGVeMv/H0Py+s=; b=Uhe2uG6vTEePd2TeYgIF5OOkHnQbvv+4sgLugIcS
 BO6absGgs5CoS5O61M1SS4On5f3nvH6Efx6aYOfsj2ap6q5e18tTFtSPMlKc1DgT
 bWKhWW+qQF0xKsL+q7MWBIqOMzxYoxrot2+oFN6iA7LmIn9eZEmN/LfCTVtjm9Xq
 NJgIiO7PU4wCu63Jp0FklWOcrW6GcCC5mjcx7uEa9oJFBy0HYcIjXAPaFDdvOz6E
 tYsHBir4i6LtrCmc1NKHsDxguCSBUngqxX2coKjrp6nH1b/ZZhSTt9w2uW3QBN6m
 tpTR9m6yxJnUtGwANgd706XcwbG91uAWwib89n1CQf+VRA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qchkgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 10:28:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9aa197d5easo1980407a12.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783074481; x=1783679281; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ipB/hMd33XeJT0Rhb9bqYmk0wi4z/PFGVeMv/H0Py+s=;
 b=dCKHt30sv6NjHGM1666noKxQi3D5Rm8DP9NdRerwuFAkHTRS/AuKpvgrOx7bLHRe+5
 eFpDZCAYCepSuuxnI3DDR1rs39FFiRKKJ6FBPadBfBEjMmSWg9hFLKCtau2uXwSRQWmi
 Ls8m6+l4Q5Oax6O4ngfLHprmC5aWbevope+oOeDdL9HfOOJp6SwnFkne/BZakNKwoAKu
 xw3224kONeTTYs8ayiVlwqCdJSa5kT8sfOUWujgDTcFxIKi3tF2yzKQpnwTA+rsC57bf
 AMcyI9pcdb70xvQwC8xNu3D42bgFE6K8JK7xLmTVzpifA+nfapUzxnqoiaAzVzGkWcWA
 FIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783074481; x=1783679281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipB/hMd33XeJT0Rhb9bqYmk0wi4z/PFGVeMv/H0Py+s=;
 b=oBJXGrsSjUtNdbKZBr6CqFFQVXTySnFhK3XSJyVED41wZKKfbPzKZ+p2lyDtWcesa9
 EO+d5XH/jdHjBrmFu3r8dczlR+0mxa7+pPeh+Q1aF/Pbht6vdzmUSyY077V+yd+XUxhs
 I7cny0qYCMd+64VEM93dOQ3PHD6kYfoai5YLqHHACZE14TCqVyJ+DijDP9e1u8bJVZjM
 iaBF+obbsHXax1FI2txpN9yxnaw77OWpBtm3A5JY/fOUHlnLe83K7ivmlP7N8Frb4xAp
 1ATjCNchU+M2njm3aaDMLTGPjRDjwvYB1cWZ97RfZwNR3XAak5HUoX6bWKqWQD6OZRML
 a5uQ==
X-Gm-Message-State: AOJu0Yzfn5RklRt+d7hMifihX2OzljvKI4a2zI66Vf7uYsT4lbaJEJvu
 fDBsATNXTfxiEJsm6SWsvgsfZyrgsAqteza9HSpz3ee2+kEivd7LTofy59Xf80BzLZ284+f8eTU
 prYfjrLdRa8qQqy6U425v8AF4cGGL3mNMVDdNHDjj+YWaAW7eZroAauTsWqsop4GM
X-Gm-Gg: AfdE7cnpPoLsqIysuRZYN/6fwPIuKEyALFMt4WeVsH9srX1NhqWXDgcrAot1PVSjnS1
 sUNDrILPGIWLOnw+mhJNR3OlmfmRljUokjEQ1CcI8Nlu0P+qWN0dYoE023IHa3NZs20GHysjT0B
 F8d0QQEL6ILnbzvLnQntt/4Ozi6gkRG21Ec2Fl60VFVgaqVhm8xHdFRMZv09dFmut1GKcOcPV4e
 AAiQHU0hkzUaEgceNM1hduqHxRsM9WddxqFb0rwZTqhKvQIkR9+sKst07mYdRf70tW2uY7rPFvq
 /I+HbOnIAouBUe/QgcuorV73ZtBlM5es0bG35B6Rcqo72u6lYGJK9BZOk5dkxBobJNkvZWMAvgi
 m9ZS2SfMYrTaXg2WKZ9uNx349gGHgV0vBJngPwuvG+i/miC0wSKxDVbK7a9B8KnPkuJxBr9RMAj
 2njZKo9BZdNlemBbewg97LO7iJ1MYzfDVLmK2+Vdjx
X-Received: by 2002:a17:90b:2e46:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-381122ec0a8mr3983848a91.12.1783074480677; 
 Fri, 03 Jul 2026 03:28:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2e46:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-381122ec0a8mr3983821a91.12.1783074480006; 
 Fri, 03 Jul 2026 03:28:00 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b816a42sm32660107eec.9.2026.07.03.03.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 03:27:59 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:57:54 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH] drivers: sysreset: Do not end sysreset_walk_arg on
 -EPROTONOSUPPORT
Message-ID: <akeOqlGa/bRWA3B7@hu-varada-blr.qualcomm.com>
References: <20260703-walk-arg-fix-v1-1-64beca00d7e2@oss.qualcomm.com>
 <af5d617d-4963-44cb-81b2-c0b0b0dc4c6f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5d617d-4963-44cb-81b2-c0b0b0dc4c6f@cherry.de>
X-Proofpoint-GUID: 6TQ24bj2F9DXTCiN7wTq7Pi16IGH-YFa
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a478eb2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=uQ1dSaR13VROMfcMDRMA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 6TQ24bj2F9DXTCiN7wTq7Pi16IGH-YFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwMCBTYWx0ZWRfX76Vugdh1a/s+
 uXx7uPELtr/2nXu5JcdGbANFjGpbpt019CHDWOUJbMUBOshIi42Q+RVjOiKyHU+mcoyTD9KbV2A
 M98rmU20TYcnYBoPU7gFw+c8G8LUbnNcPzGU2KbAb0rnExLfcLGNtkHmgr1MZIM0FkwlaOE6ELe
 lCDb1DkurRjH+mg8ke5o46JFYbOwXLSr56nUZ+NnDkwL8qojAYstBFQE/9pp4wB53dCji4amr6W
 2QvYSu3q6Luakwk4i1y8kdZGP3SIOJp6b+NZbvCbEB2UbeMxT+M1Yj47Qu0aga0hYh22JynUIqI
 rmzGe2NzcBnKFWqTD3fPZxGqp+mei3J8RwXKzVq20babwEJ9NRQWN4xzRk8vImSm+eX9xzxIxEy
 hVdrltmjT3WYL8CF/zLLMvUWxRTALUAbGmUBXJMINpkjmfupDnRoS6QZE5swbrDn0NtBMHIaNoq
 +6XwIS//aZaWtKlc5Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwMCBTYWx0ZWRfX9UrSFWwJaOER
 EQeGeWsEk71weKIV4jzRgGA0Hpce4I57Gvm20CPmimEcaucW3hUGaAanu+grjS5JRQKJH1EhqD8
 BdfmeKl3U8YnL6gM43CeqtTuIJlkIKQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030100
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

On Fri, Jul 03, 2026 at 12:11:30PM +0200, Quentin Schulz wrote:
> Hi Varada,
>
> Thanks for the patch!
>
> On 7/3/26 9:24 AM, Varadarajan Narayanan wrote:
> > If there are multiple sysreset devices implementing request_arg callback,
> > the first sysreset device will consume the args and may return
> > EPROTONOSUPPORT if it doesn't implement the given argument. This will stop
> > the loop.
> >
> > Since -EPROTONOSUPPORT is used to indicate absence of support for that
> > argument, subsequent drivers should be given a chance to see if they handle
> > it. Hence do not terminate the loop on -EPROTONOSUPPORT return code.
> >
> > Fixes: fcb48b89813b ("drivers: sysreset: Add sysreset op that can take arguments")
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >   drivers/sysreset/sysreset-uclass.c | 23 +++++++++++++----------
> >   1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > index f25e09e9cd0..0fc096e7f0f 100644
> > --- a/drivers/sysreset/sysreset-uclass.c
> > +++ b/drivers/sysreset/sysreset-uclass.c
> > @@ -89,14 +89,12 @@ int sysreset_walk_arg(int argc, char * const argv[])
> >   	struct udevice *dev;
> >   	int ret = -ENOSYS;
> > -	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
> > -		for (uclass_first_device(UCLASS_SYSRESET, &dev);
> > -		     dev;
> > -		     uclass_next_device(&dev)) {
> > -			ret = sysreset_request_arg(dev, argc, argv);
> > -			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
> > -				break;
> > -		}
> > +	for (uclass_first_device(UCLASS_SYSRESET, &dev);
> > +	     dev;
> > +	     uclass_next_device(&dev)) {
> > +		ret = sysreset_request_arg(dev, argc, argv);
> > +		if (ret == -EINPROGRESS)
> > +			break;
> >   	}
> >   	return ret;
> > @@ -153,6 +151,7 @@ void reset_cpu(void)
> >   int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >   {
> >   	enum sysreset_t reset_type = SYSRESET_COLD;
> > +	int ret;
> >   	if (argc > 2)
> >   		return CMD_RET_USAGE;
> > @@ -165,8 +164,12 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >   	mdelay(100);
> >   #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> > -	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
> > -		return 0;
> > +	if (argc > 1) {
> > +		ret = sysreset_walk_arg(argc, argv);
> > +		if (ret == -EINPROGRESS)
> > +			return 0;
> > +		log_err("No handler for reset command arguments (%d)\n", ret);
>
> Just use printf to be consistent with the rest of the function.
>
> But here's possibly another logic bug I think. If we pass -w to reset, this
> will try all available sysreset devices if any can handle the -w argument
> and then print that there's no handler for the reset command argument, which
> is to be expected.
>
> So I'm wondering if we shouldn't bypass sysreset_walk_arg() entirely when -w
> is given as argument to the reset command.
>
> Also, *any* argument starting with -w should do the warm reset, e.g. reset
> -warm should do it too as that's the current logic we have (we only check
> the first two characters of the argument).

Would this be ok?

int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
{
	enum sysreset_t reset_type = SYSRESET_COLD;
	int ret;

	if (argc > 2)
		return CMD_RET_USAGE;

	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
		reset_type = SYSRESET_WARM;
	}
#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
	else if (argc > 1) {
		ret = sysreset_walk_arg(argc, argv);
		if (ret == -EINPROGRESS)
			return 0;
		printf("No handler for reset command arguments (%d)\n", ret);
	}
#endif
	printf("resetting ...\n");
	mdelay(100);

	sysreset_walk_halt(reset_type);

	return 0;
}

If this seems ok, will post v2 with this change.

Thanks
Varada
