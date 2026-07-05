Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5F0C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 07:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9244846F8;
	Sun,  5 Jul 2026 09:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pfXAi9HC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U4dPyWMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05820846FD; Sun,  5 Jul 2026 09:47:53 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECEC846A4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 09:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664LqcDn4143295
 for <u-boot@lists.denx.de>; Sun, 5 Jul 2026 07:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EJHNh3AAVyjEzAPJy6h1u2XA
 w8mT6AvltmZ+TltSNl4=; b=pfXAi9HCzOx646wtYBagKRNu4ygWiZFAE+quKw+i
 ygxhyLuQIvT+S9sctrK7fgND2QKLHMNG+HIZ3KWRxYJ2eSV3XGlwwQlr5Q787dfh
 MywLjnI2KAe1n/BLP4H6rcEXNgx1BWsUCe7MhtQBckxTjJC2LQVlGNqZ8Wk6YLyK
 cTFZ7ynMPWC0zJzqO91+d0AoouUSXl3a3KnrkmMqsAX2znleCiz7wJg88z+OBuFX
 NfUffYGhy3q0yh6BuFovgP5by6zAbRLTp0OJG9o5qKXFcICNn4BYNpldFVYhIm9E
 15HJsTTjAIetyBJCyCTMIv95WeUIbF2nowuaJXjiSSnMvg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4stdhp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 07:47:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so3177374a12.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783237667; x=1783842467; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EJHNh3AAVyjEzAPJy6h1u2XAw8mT6AvltmZ+TltSNl4=;
 b=U4dPyWMg8U7U7TYZzgGF6/Un/iVxDo3JAzMuDs3EuxTxrtNuttVOoaW0T78EJG70wr
 flyJaUU0x2GsU3ogb0TNXlfw6bYnuPs22FMYThDMvWQyrGGx7ebV5J1dfsxsUQYerpVX
 b9Dogtm5AqqGJbd34cp4+3lq2Xz2eyAeMSNeNp88Mh9J2GD72d4MXyv2jZsyxIIlQmtj
 WH4E1tcELuCbjtWq+8F+YGGQxC0jFdFt0HBCnHp4Xs2vZbidhbVvNaEnVIh551xCSPhv
 OmqecQKBRbzfHlLdGElFayfW33xrsgiwvm8/bmo8osiDYfh8lGwWxYYEopmpTU4y2t5Y
 2AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783237667; x=1783842467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJHNh3AAVyjEzAPJy6h1u2XAw8mT6AvltmZ+TltSNl4=;
 b=ETjpKu9ELHILPbZ1fydwkcjd908+zeJgd2t6sTZXEutHBo7NxnX6cRJS8TKc8JI2cq
 7ydnxmmLGFv4bcuKD1S0dqSgRa5UBMjMbihcBepu9dNLz6/RLgqR3METvYTPmeZ24tRK
 fNXjK+faLMNgX1HHVGSP6WWauLTKUo8LW5luL4U+7y7NzxbPP2ACRdWUBUBhlqY4P42i
 XMwYxOc/kaNqAes94GL7uy5PaYx50aIo0yed6i0tL6qnsmWmXWw7M0goOWhLwb56bJDz
 KB8kZeFatlo+1WiPVkK7+zdSpxuwNN0X4zURvBpLUPoqsKNb8J2y3UxBL/U4Lpz99AoJ
 JOuQ==
X-Gm-Message-State: AOJu0YwIFrr8G6RewrUgLC+J9g2UTxNVQThDIiyZXY7mnJcgSUFz1sHO
 aakOp5qUy6So3sfhqMyz9KEVmBl9kWXsULeaKkbHcw2Y6VLYR7z8diLU9A4modcBadIDG2gQXAE
 TpJVuaiQdHJL8C3CNvAq0uaJkgYW8Hu4xLM/El2v/9JYJUfSxiRdrCixl
X-Gm-Gg: AfdE7ck/1bZ8Fbw1N2Ih419yAslPbBNHlyPOSAmxbzAwlqYZL+uQTY1GWc1I6GOhSoB
 yQpi1TLlZl8ZVqZ6DwgRD8QrTtQOJ3HJGLYh2IAlWzvwWzbdeEV47Xif3/9+GcJjqyji+f+XEQ7
 m+0Sle3mzMSTvEEGWcNptbE9x5FsWBWVvHnrpHcRTIXoDa6nUdgmVLhk1YPD79PmernugaHakPP
 ngcaerETbaup0xoARPgx1Ox2ATi2kgBpMqPDbUFSPwNZeaMReOVJkyB/A5gymkyb0Q5A8iz+OPC
 DBK1oD9RxgGY0u2+cFNF04X7zpm6o8V6Z6IZLU13e+g1jDVJPEHkZwIgJYnKoYmsapfx4Pif8b2
 8xjhmVIvgenqGXly/IgRG1MAHFi1o3RAkiTzyuyrzwrHylAUSu0tAPj7kzf5AncOHvdeD1HsUfb
 vqMXYM0dNJJZjDMzKFJsPhriEKEw9e6CNvRhSJ/4AT
X-Received: by 2002:a05:6a20:72a0:b0:3bf:c126:baf7 with SMTP id
 adf61e73a8af0-3c03e4b4006mr5973126637.47.1783237667430; 
 Sun, 05 Jul 2026 00:47:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a0:b0:3bf:c126:baf7 with SMTP id
 adf61e73a8af0-3c03e4b4006mr5973110637.47.1783237666907; 
 Sun, 05 Jul 2026 00:47:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm35364819c88.4.2026.07.05.00.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 00:47:46 -0700 (PDT)
Date: Sun, 5 Jul 2026 13:17:41 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH] drivers: sysreset: Do not end sysreset_walk_arg on
 -EPROTONOSUPPORT
Message-ID: <akoMHeQ2V5zfpU73@hu-varada-blr.qualcomm.com>
References: <20260703-walk-arg-fix-v1-1-64beca00d7e2@oss.qualcomm.com>
 <af5d617d-4963-44cb-81b2-c0b0b0dc4c6f@cherry.de>
 <akeOqlGa/bRWA3B7@hu-varada-blr.qualcomm.com>
 <d7e003b3-e693-4579-8e3a-b09ce9f78d10@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e003b3-e693-4579-8e3a-b09ce9f78d10@cherry.de>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA3OCBTYWx0ZWRfX44lAmzSZoIoR
 Up7RKbdQXVT4ETrMIT4frqXhPQ6Xyg+95r5AYF4CO/b5djIReQFLekr4VtNiDnNr9MeHAGiQuIW
 +yrPolDXP4dH/O6pRV0qCZ6b/r6tsk0=
X-Proofpoint-ORIG-GUID: UJ89gs6bC28QQfUThb-GGwcfsnadC5bZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA3OCBTYWx0ZWRfX8c5xLEeqQh8R
 3vvMt9cGO4sq7StRa4PXJvTejqqNkWNBjEQFoHUU/3pDB/re0vgdo6/ehmwERGEpyTD6bNfO984
 gd2sL1874o+5JsiDTzvpWfSr8bic+ip5BkwXh3mWGsOUGW+ZPDo6oJYp9fdKSzZGmr3MotkxCIM
 BNe5YVWP9YOYtKWUlefb4dVOoW3AvCFss8kRlRCmfub/aeptwNLpXPYBnu+jBBUhE96ELU/X/BC
 LE4QNKZVil/GUmQb2HHvl9pRewS255kZjcmoyO+E6V+gR+hU6MNXJMPdDtn8xpboeawekDvRFcu
 Y8E47H7hmfLqlNZkQSJSWVKD1XU0D2AakCcH18YKTgKkNHl6kEFaFnJ7tbLU4agy89HRxvjJP4B
 ZoAOXhASHPXR3S/6HTbq0Lv2j5kU3Y2fTkyki45z2mrWvVOTPHCgUdLG5mXc2/HSFGsGLXkNZjK
 eGzQPVqIPWn+PG6IlRw==
X-Proofpoint-GUID: UJ89gs6bC28QQfUThb-GGwcfsnadC5bZ
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4a0c24 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iAvd1xM0ckeScaDkMOcA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050078
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

On Fri, Jul 03, 2026 at 12:37:04PM +0200, Quentin Schulz wrote:
> Hi Varada,
>
> On 7/3/26 12:27 PM, Varadarajan Narayanan wrote:
> > On Fri, Jul 03, 2026 at 12:11:30PM +0200, Quentin Schulz wrote:
> > > Hi Varada,
> > >
> > > Thanks for the patch!
> > >
> > > On 7/3/26 9:24 AM, Varadarajan Narayanan wrote:
> > > > If there are multiple sysreset devices implementing request_arg callback,
> > > > the first sysreset device will consume the args and may return
> > > > EPROTONOSUPPORT if it doesn't implement the given argument. This will stop
> > > > the loop.
> > > >
> > > > Since -EPROTONOSUPPORT is used to indicate absence of support for that
> > > > argument, subsequent drivers should be given a chance to see if they handle
> > > > it. Hence do not terminate the loop on -EPROTONOSUPPORT return code.
> > > >
> > > > Fixes: fcb48b89813b ("drivers: sysreset: Add sysreset op that can take arguments")
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > > ---
> > > >    drivers/sysreset/sysreset-uclass.c | 23 +++++++++++++----------
> > > >    1 file changed, 13 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > > > index f25e09e9cd0..0fc096e7f0f 100644
> > > > --- a/drivers/sysreset/sysreset-uclass.c
> > > > +++ b/drivers/sysreset/sysreset-uclass.c
> > > > @@ -89,14 +89,12 @@ int sysreset_walk_arg(int argc, char * const argv[])
> > > >    	struct udevice *dev;
> > > >    	int ret = -ENOSYS;
> > > > -	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
> > > > -		for (uclass_first_device(UCLASS_SYSRESET, &dev);
> > > > -		     dev;
> > > > -		     uclass_next_device(&dev)) {
> > > > -			ret = sysreset_request_arg(dev, argc, argv);
> > > > -			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
> > > > -				break;
> > > > -		}
> > > > +	for (uclass_first_device(UCLASS_SYSRESET, &dev);
> > > > +	     dev;
> > > > +	     uclass_next_device(&dev)) {
> > > > +		ret = sysreset_request_arg(dev, argc, argv);
> > > > +		if (ret == -EINPROGRESS)
> > > > +			break;
> > > >    	}
> > > >    	return ret;
> > > > @@ -153,6 +151,7 @@ void reset_cpu(void)
> > > >    int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> > > >    {
> > > >    	enum sysreset_t reset_type = SYSRESET_COLD;
> > > > +	int ret;
> > > >    	if (argc > 2)
> > > >    		return CMD_RET_USAGE;
> > > > @@ -165,8 +164,12 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> > > >    	mdelay(100);
> > > >    #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> > > > -	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
> > > > -		return 0;
> > > > +	if (argc > 1) {
> > > > +		ret = sysreset_walk_arg(argc, argv);
> > > > +		if (ret == -EINPROGRESS)
> > > > +			return 0;
> > > > +		log_err("No handler for reset command arguments (%d)\n", ret);
> > >
> > > Just use printf to be consistent with the rest of the function.
> > >
> > > But here's possibly another logic bug I think. If we pass -w to reset, this
> > > will try all available sysreset devices if any can handle the -w argument
> > > and then print that there's no handler for the reset command argument, which
> > > is to be expected.
> > >
> > > So I'm wondering if we shouldn't bypass sysreset_walk_arg() entirely when -w
> > > is given as argument to the reset command.
> > >
> > > Also, *any* argument starting with -w should do the warm reset, e.g. reset
> > > -warm should do it too as that's the current logic we have (we only check
> > > the first two characters of the argument).
> >
> > Would this be ok?
> >
> > int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> > {
> > 	enum sysreset_t reset_type = SYSRESET_COLD;
> > 	int ret;
> >
> > 	if (argc > 2)
> > 		return CMD_RET_USAGE;
> >
> > 	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> > 		reset_type = SYSRESET_WARM;
> > 	}
> > #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> > 	else if (argc > 1) {
> > 		ret = sysreset_walk_arg(argc, argv);
> > 		if (ret == -EINPROGRESS)
> > 			return 0;
> > 		printf("No handler for reset command arguments (%d)\n", ret);
>
> I don't think printing ret is interesting here as it'll be the return code
> of the last attempted sysreset device (so either ENOSYS if there is no
> sysreset device at all, or if the last one doesn't support request_arg
> callback, or -EPROTONOSUPPORT if it supports args but not the arg we pass
> it).
>
> We should also tell the user what we're doing in this case: a cold reset.
>
> > 	}
> > #endif
> > 	printf("resetting ...\n");
> > 	mdelay(100);
> >
> > 	sysreset_walk_halt(reset_type);
> >
> > 	return 0;
> > }
> >
> > If this seems ok, will post v2 with this change.
> >
>
> No, because it'll do the reset before printing it's doing a reset (and will
> also not do the delay).
>
> But if you move the whole if block after the mdelay() then I think it's
> fine.

Not posting the next version since this is getting reverted per [1].
Please let me know if I have missed something.

Thanks
Varada

1 - https://lore.kernel.org/u-boot/20260703-revert-sysreset-v2-1-ac999d2ff82f@cherry.de/
