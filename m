Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D293C3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 18:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC00C886B1;
	Mon,  1 Jul 2024 20:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="tgsLlOt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549D3886B6; Mon,  1 Jul 2024 20:07:02 +0200 (CEST)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E6488670
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 20:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346904.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 461GpqEb014093; Mon, 1 Jul 2024 18:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=POD051818;
 bh=ohiKA6nnSQ/H/F57/pj/RFPFcVwySb+k5Gc6Unaw1rE=;
 b=tgsLlOt11vMZ6J4zQDyGOU/Gb8oEU5NuaYaUVNTp9CF7Id4Wh8aBp8nQtI1ySBcVUKMH
 iOLaPbQybF4CKhPm1NsVk+C4e5Mho/d3UJaclEVxuNn4dmr4SesckjGu4gMwvGu5G7hD
 btYC2PlDO+P81wzPkSbu6kDuOjS5u2+cUyMd++VHW+OSW2Rbi86QrAW6jSzf2hBvhWqK
 iNn9TbriXkzO0NYzDX7nuA4HXITlCqvK3wmKf33MAzZUqyblQ21ec6aJFEkSuh9MQMpP
 zPmuZA7nJThOIB9nJWNkby0C3j12E1v98fPfFlqncMbMNwbDChkOMwGnXbJuazd6ooJD aA== 
Received: from xusxph009rp050.rtx.com (xusxph009rp050.rtx.com [128.13.125.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 402av0y96g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Jul 2024 18:06:57 +0000
Received: from xusxph005rp020.corp.ray.com ([128.13.121.224])
 by xusxph009rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 461I6uC1021511
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jul 2024 18:06:57 GMT
Received: from crulimr02.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph005rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 461I6uDO002663
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Jul 2024 18:06:56 GMT
X-Received: from localhost (unknown [10.148.204.208])
 by crulimr02.rockwellcollins.com (Postfix) with ESMTP id 5E38230041CA;
 Mon,  1 Jul 2024 13:06:56 -0500 (CDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 18:06:56 +0000
Message-Id: <D2EEI1UVCSAR.25E0OJILODS4F@collins.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] tools: patman: fix `pip install` with Python 3.12
From: "Brandon Maier" <brandon.maier@collins.com>
To: "Simon Glass" <sjg@chromium.org>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240604163134.1149752-1-brandon.maier@collins.com>
 <CAFLszTg++xwrcHyt-3hficWSMm=wBJ+bS1oTrjcDY7HYJD7pEg@mail.gmail.com>
 <CAFLszTgc5D52ARKVANyWOimyB6VpbtwZ_S+jzO8vtEPyXKRmkA@mail.gmail.com>
In-Reply-To: <CAFLszTgc5D52ARKVANyWOimyB6VpbtwZ_S+jzO8vtEPyXKRmkA@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_18,2024-07-01_01,2024-05-17_01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_18,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010136
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010137
X-Proofpoint-GUID: 0KMmEvr8yqrTW3Xf9phlLcPSmj4XfUdX
X-Proofpoint-ORIG-GUID: 0KMmEvr8yqrTW3Xf9phlLcPSmj4XfUdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_18,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2406180000 definitions=main-2407010136
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

Hi Simon,

On Mon Jul 1, 2024 at 2:34 PM UTC, Simon Glass wrote:
> Hi Brandon,
>
> On Wed, 5 Jun 2024 at 03:13, Simon Glass <sjg@chromium.org> wrote:
> >
> > On Tue, 4 Jun 2024 at 10:31, Brandon Maier <brandon.maier@collins.com> =
wrote:
> > >
> > > Installing patman with `cd ./tools/patman && pip install -e .` fails
> > > with the error below.
> > >
> > > As described in the error output, the license line is not allowed to =
be
> > > only defined in the setup.py.
> > >
> > > > $ cd ./tools/patman && pip install -e .
> > > > Obtaining file:///.../u-boot/tools/patman
> > > >   Installing build dependencies ... done
> > > >   Checking if build backend supports build_editable ... done
> > > >   Getting requirements to build editable ... error
> > > >   error: subprocess-exited-with-error
> > > >
> > > >   =C3=97 Getting requirements to build editable did not run success=
fully.
> > > >   =E2=94=82 exit code: 1
> > > >   =E2=95=B0=E2=94=80> [61 lines of output]
> > > >       /tmp/pip-build-env-mqjvnmz8/overlay/lib/python3.12/site-packa=
ges/setuptools/config/_apply_pyprojecttoml.py:76:
> > > >           _MissingDynamic: `license` defined outside of `pyproject.=
toml` is ignored.
> > > >       !!
> > > >
> > > >       *************************************************************=
*******************
> > > >       The following seems to be defined outside of `pyproject.toml`=
:
> > > >
> > > >       `license =3D 'GPL-2.0+'`
> > > >
> > > >       According to the spec (see the link below), however, setuptoo=
ls CANNOT
> > > >       consider this value unless `license` is listed as `dynamic`.
> > > >
> > > >       https://packaging.python.org/en/latest/specifications/pyproje=
ct-toml/#declaring-project-metadata-the-project-table
> > > >
> > > >       To prevent this problem, you can list `license` under `dynami=
c` or alternatively
> > > >       remove the `[project]` table from your file and rely entirely=
 on other means of
> > > >       configuration.
> > > >       *************************************************************=
*******************
> > > >
> > > >       !!
> > >
> > > Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> > > CC: Simon Glass <sjg@chromium.org>
> > > ---
> > >  tools/patman/pyproject.toml | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Unfortunately this causes 'make pip' to fail. Can you please take a look?

The `make pip` uses `python -m build` which seems to handle this
differently.

I removed the license line from setup.py entirely, as the pyproject doc
says it's not needed if a license classifier is used. That now works
with both `pip install` and `python -m build`.

Thanks,
Brandon

>
> Regards,
> Simon

