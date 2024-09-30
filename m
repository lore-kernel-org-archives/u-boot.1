Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51091CF64B3
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D12088F32;
	Mon, 30 Sep 2024 15:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="br0w7RRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A7888D9B; Mon, 30 Sep 2024 13:28:29 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B7488618
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 13:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0047963.ppops.net [127.0.0.1])
 by m0047963.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 48UBGeAV010347
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=outbound; bh=4
 gO/g6371NcFhP/vWsEav1xw97z7o/N6D4VMYUijULs=; b=br0w7RRxDa0DOjaCB
 0iF4mMTcyuH4fF1Fvj7Sih5tXGK/ymHdGjIfIpdJWpvnsqupadC+daFjju8ZaQCY
 iVVlXzir+MEBSg6OFAiCNGjBhmffzJc6eMBCf9l7Z+WximnCSsUuPolB0S7bT3OO
 xuR3zE48kBQAt+Q5pqShiIwez9YgpYGX8+7vzpAzBxT3Lp1M7e7lC6JLkvzLoEZU
 8AJ+Qh4ZPEQRcOJ7BvAdsBEcV8Dvuy1Vh4tDYEAAW91lZC1lrnZxQSr6sjccmFaU
 wf+IeQPevENVALM8HFA3u/vKIXptzupVI3PdvqwqRLjJKNxKkQ/ItspHVxZcTCg0
 U+RXg==
Date: Mon, 30 Sep 2024 14:28:11 +0300
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
Message-ID: <ZvqJJ7DOhxpEBgXl@zoo11.em.health.ge.com>
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
 <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
 <20240927204046.GW4252@bill-the-cat>
 <CAOMZO5DAUD3WR5z8ZxPkVhnv_2VZpYaHRziEvZ7MHvwooNS8Jg@mail.gmail.com>
 <CAFLszTiUQBJvaU_bhUYdsujo-oeeT8RCDguu+pYQ9YEppqqALg@mail.gmail.com>
 <20240930004623.GA5579@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930004623.GA5579@bill-the-cat>
X-Proofpoint-GUID: 0Gmi4oXh92S3A9cxVhkkDTcNNiTVm-GT
X-Proofpoint-ORIG-GUID: 0Gmi4oXh92S3A9cxVhkkDTcNNiTVm-GT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0
 suspectscore=0 mlxlogscore=674 lowpriorityscore=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409300082
X-Mailman-Approved-At: Mon, 30 Sep 2024 15:00:33 +0200
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

On Sun, Sep 29, 2024 at 06:46:23PM -0600, Tom Rini wrote:
> On Sun, Sep 29, 2024 at 04:49:17PM -0600, Simon Glass wrote:
> > Hi Fabio,
> > 
> > On Sun, 29 Sept 2024 at 14:53, Fabio Estevam <festevam@gmail.com> wrote:
> > >
> > > Hi Simon, Marek, and Tom,
> > >
> > > On Fri, Sep 27, 2024 at 5:47???PM Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > > Please can you coordinate with Marek as we need to sort out the test
> > > > > coverage for this etype, before adding more functionality. I did a
> > > > > starting point, now in -next, which should help.
> > > >
> > > > Well, when someone has both time and understanding of the tools and the
> > > > frameworks, we can expand the automatic tests while still having
> > > > functional testing as people use the feature.
> > >
> > > Do you think this patch should be applied as is? Could the tests be
> > > handled later?
> > >
> > > Please let me know.
> > 
> > Who is going to handle the tests later and when?
> 
> Someone, once how to write and run the tests is documented. That's a
> big hurdle this private thread has shown, to me at least.
> 
> -- 
> Tom

Hi,

I fixed a minor issue in the patch, and sent a revised version.

Seems that you don't have the testing quite defined yet, so I don't know
what I can contribute there. Maybe something can be done with the CSF
parser to check that the signing works correctly?

However, I think this feature is quite benign, and it would be great to
get some functional testing in for this feature, as Tom said. For us,
this is an important feature, so we have done extensive testing
internally to verify that it works.

Best,
Brian
