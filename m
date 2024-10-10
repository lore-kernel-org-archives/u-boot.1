Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813D4CF11E9
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 12:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9AF890B9;
	Thu, 10 Oct 2024 14:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="grZ81x+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4263F89026; Thu, 10 Oct 2024 13:38:37 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CE188EF8
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 13:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0048205.ppops.net [127.0.0.1])
 by m0048205.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 49AAro8M043789
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=outbound; bh=p
 cmgQgXwhnpy1wwkNtsxVc3+wLhtHKkigNCk30kuDWg=; b=grZ81x+u+wv+eC9t7
 4l1ZE0aoLDfU/BF5uE9eGlD2wfDHdSnvhLY/RkIWcAJkJGiGP7IGzCXOdkuWvB1M
 l2dpteHL6gd5BUaw2EZS/HVUlRtg6ClWGyoZk6fmIjrzKjX+iaoDSA54IuWR+n89
 pxAD8C31xnCXOElaPAewH4ZmZVg/3FRdRyEhlPyAzWE1GfETSWk1j0qmMw4rNw27
 EMXw5/Z5ugIV7E9xTKIRTZrV5fHhDAFY4lCLk7vvGB8WxU0ZW8ua2/rMbXonZz2t
 l4fxwg2OZfoAu4cBBAGrYj/sPH1iGfanCgTRjFin2/AlQOUAGGnQc6YgiGKUq9kn
 sEWNQ==
Date: Thu, 10 Oct 2024 14:38:28 +0300
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] WIP: binman: expand test coverage to nxpimx8mcst
Message-ID: <Zwe8tG-f0lvhJOlp@zoo11.em.health.ge.com>
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
 <CAFLszTj26G9WatN_fmksAkT4wiZfQ=sAnT8Ny5bZAfc55eYgCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTj26G9WatN_fmksAkT4wiZfQ=sAnT8Ny5bZAfc55eYgCw@mail.gmail.com>
X-Proofpoint-GUID: fjBG0d-9EGPlPPdClEmZDmy2jP6x1WCP
X-Proofpoint-ORIG-GUID: fjBG0d-9EGPlPPdClEmZDmy2jP6x1WCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_08,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=628 lowpriorityscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100077
X-Mailman-Approved-At: Thu, 10 Oct 2024 14:50:10 +0200
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

On Tue, Oct 08, 2024 at 07:55:26PM -0600, Simon Glass wrote:
> 
> WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> 
> Hi Brian,
> 
> On Mon, 7 Oct 2024 at 07:02, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> >
> > Add coverage for IMX8M code siging. Create PKI tree and other assets
> > required by `cst' using `hab4_pki_tree.sh' script in `cst_3.4.1' [1].
> >
> > [1] https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nxp.com%2Fwebapp%2FDownload%3FcolCode%3DIMX_CST_TOOL_NEW&data=05%7C02%7Cbrian.ruley%40gehealthcare.com%7C6c5f10f7a5924f834a9108dce8057a0f%7C9a309606d6ec4188a28a298812b4bbbf%7C0%7C0%7C638640357480346828%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=%2FFjvh%2BAUwpiUxyePSbhmW386iDV65%2BbJHwUiTWwOgok%3D&reserved=0
> >
> > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > ---
> 
> Please can you check the indentation?
>
Fixed it.

> I don't see the .pem files in your patch?
> 
Argh! Sorry about that, I didn't realize that .pem files were ignored
by git :)

> Also we should really tidy up the etype so that it can read keys from
> the input path, or perhaps use an entryarg to point to the file.
> Having paths in the image description is not ideal.
> 
I sent a new patch preceeding this one, but I've rebased everything on
top of [PATCH v4 2/2] binman: add fast authentication method for i.MX8M
signing, I hope that's fine? The etype will now look for the
certificates and keys relative to the input directory. I've also added
the ability to specify an extra input directory to search first.

Best,
Brian
