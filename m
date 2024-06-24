Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9FEC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC01883E7;
	Mon, 24 Jun 2024 14:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="DHhDu2qI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3EC882E6; Mon, 24 Jun 2024 09:13:21 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B7F876D3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 09:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1719213199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fx0hNN9C4oCd58e3WqWTS47xNm3hcALdfWSgGacZTU=;
 b=DHhDu2qI+XDWPRACZH4uBxdXsksVPKSQodWTymbppYp8mIFZZT2djOv8MYKWQX987+mqV9
 vJFGgDGx/B+FckR2DphqWk4VmiEWKlUKRah1xTvkxHlSowxpxYNchdilFXSk5Tg6kbSj4a
 YWMHGkDMLJi09pLtd0neEXVj8AG0l5M=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-55-b9P6NRBrNTyuJxNQ84R83g-1; Mon, 24 Jun 2024 09:13:17 +0200
X-MC-Unique: b9P6NRBrNTyuJxNQ84R83g-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR0P278MB0076.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 07:13:15 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 07:13:14 +0000
Date: Mon, 24 Jun 2024 09:13:10 +0200
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 19/19] CI: Allow running tests on sjg lab
Message-ID: <ZnkchlJmYdVCkQV+@toradex.com>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-20-sjg@chromium.org>
In-Reply-To: <20240623203213.1571666-20-sjg@chromium.org>
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR0P278MB0076:EE_
X-MS-Office365-Filtering-Correlation-Id: 088fbc00-c10e-458e-5f0d-08dc941d1d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kTfAEQLyF35u0Yj+tnesKM0GhB2liD5E9xEVcmEryxAaYPci5NSexSxYz+GC?=
 =?us-ascii?Q?UKpgIPuwVc+RYla5oEQUkS50KA2ubvmhzEClDWltwU74h/lndcuecfBSuqEV?=
 =?us-ascii?Q?dqQIWthhPp0QfD6c/gU2xtgmUn+SNKZh0bXZKdge93z0/o67+581lTrhV4Jc?=
 =?us-ascii?Q?2xjBAftGoXodOrzNIE1Mo3AFQfokBGE1eS8hBXDisPN/p2CFfePdj0NYDIKg?=
 =?us-ascii?Q?4X+jTu7K5Tv8oQ7izXvdjA1V9rZoDTLljr+9kXoBqO2NMDnoN69yzzH2g+Wi?=
 =?us-ascii?Q?boGpOkZ2ZCfG1UO4XgjI+B70SGEJQifagsFRnDdGs/IpreLqxa48OMk7oWBu?=
 =?us-ascii?Q?gOJU+wLmfOnY9eg6rr/PYt/hnm+fBnFN9/xS7k9VKmt75n3zTRoWSSMub7dn?=
 =?us-ascii?Q?HxfNMiBQYsRkbOj0CXSmvoyPNQjuJVmyvaYhkVHgBLEbYbfpDXI+Wvl+7E3z?=
 =?us-ascii?Q?kTrc/SMPZj1TOZelvS+4+eV7byWDDxHdRAryudcjuMa728ZDlv37lMLCikR4?=
 =?us-ascii?Q?tXoFhh6Pw4oXDX1EJe1cPvPcZf+Pux70Mf1izW1u0CdVHfgInJwooY7hNFSW?=
 =?us-ascii?Q?6OGjmbrNHEJDiDf7yBC5M83erwb/+FhSfgJZKnTqQ4GiL/pMeCXpvinvLEqt?=
 =?us-ascii?Q?xUNpDk3o42GufLWQF3JbDFkg1IquN2q03NC/FCLSCmKnlkEE1Pnfozcfbwny?=
 =?us-ascii?Q?t4/cK1Y+JxOpc5POa8lMceWilsslhpFD4okahzBD09nU803TvZ11/95+AABR?=
 =?us-ascii?Q?tHqIBZha3k8RgyIDA6dQK9SNEUSXxL574KQa0lC3axYWLr1TITSgLGG4fnpa?=
 =?us-ascii?Q?En+uPEYZnQkJk/4K132VqatNpKPDaJyQtzIS97z8+gxWRaOULAJO5L+D7Yc0?=
 =?us-ascii?Q?6pcniqeQRmUNUCX9x6x2J6eZQ8pMsBgMuV8KHfdHiEj5TBmFstER9Lcv3VGj?=
 =?us-ascii?Q?k8uBZiatAwpZyqMFMtoa0hrht+uhwcF6Ihb+UUryYatvB90husgeVlhqqKV+?=
 =?us-ascii?Q?UUkE6eQuxN6vb0IMf7PJY70rpaTTPfCLIet3tpZfQPnx/BovuPQI2wN+Rw52?=
 =?us-ascii?Q?CAp83Zo4z/dsAzsWyAEUuwWen61dyNIjucqOsBySqQPcuPb3iWD4/aGkjBIt?=
 =?us-ascii?Q?rFOzZPbcjX5wH6KQ2epuUkvMV05Esc5M4d49ukgP9WFiauVUyUl58bkl8eqI?=
 =?us-ascii?Q?z2Cv6Hc/ZZmjxsYCuDI9K/mI/3dXPn9Hv80kwTAkzTyBX/nrXDY2wezHNnvf?=
 =?us-ascii?Q?rlMdW4wGO1FCo9zbSWU/Zmhm3Tr54HyWZOhAaiIrCc2KVtz1q/jeY+ViMff/?=
 =?us-ascii?Q?YwtN+Irar+B5x9L/TX6u0gF/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WhI1enlCluRygWHt6H+5Vi1Crk492YCMK1fUxbIyYWqbfkG1i4/B9qZQz5CK?=
 =?us-ascii?Q?2s8LvBmQZJoAIqsX3sg4nSRoFGUWcb4hXnClxtfAv+24ETcbq58E3kZiL2ej?=
 =?us-ascii?Q?NXt6xeU3NmrCI/wOMONYUH9n3RyQdc1fgJiQCgubwPGO+MGa1TV3QE49leNa?=
 =?us-ascii?Q?4VJHyytWkBNClh1aDWwfzCIFOPZ9+oWTZAFp7ZoX5hRjpkO+zr7oLe0G9yo7?=
 =?us-ascii?Q?dWEAp5d0hL2hH0J5LmMAheffW+ml+rFdJzqRUNJh9dR0p+OTO3I7C3LjFq6W?=
 =?us-ascii?Q?esIKHNquPwLSWYcwCl0XJkjFyL2Ctjxigxuye8gGVPn5xDaIu5SbLCdG6V7W?=
 =?us-ascii?Q?32lwXFmfRXi5Nh97ZRSuPPphBGZ95QB2zZMQKHRkyooPVZzEDSpplUV5grfB?=
 =?us-ascii?Q?YWkETYdGfIS1fxX7enmhfUH5T0K/W5MlWXOfqFYEfsD82OAMW7gW3WBTn4M4?=
 =?us-ascii?Q?c/MBmQuB0o1Wu3w6tr6YiIvy3KMFmJZIg0TAzoSI84wYfv2aEJDeXyYUKhcQ?=
 =?us-ascii?Q?qTcT9v73M51tjUVXTk2Nlfv3OLq2vJZAX+oVSVmrEOafwPoUD+H5rxgjGM0l?=
 =?us-ascii?Q?gsMPPgQi85vwWEJgi6S1a6IoIb9KZu/r3OLyIsrU7K8jEDBA24b5IrrnMPrq?=
 =?us-ascii?Q?0WoDAeDAVMv623aQiThNqLGbPCDiem1CGHR+coIh5QT0+jxocS+jJyfJQlzE?=
 =?us-ascii?Q?dx0SaS7DqABwTHmvn3Q1Ldm8S/N51zIlQP6uEQDj6Yq/MAn250ejMLeDayMK?=
 =?us-ascii?Q?j6FQqL/txX9OOaMSawzLokx8hfgXdzQeli6UwATY7yh238khrZC6l65HdVKl?=
 =?us-ascii?Q?PSRAerQriqlZJFPYvcNSDtn2x+B7kqf/b55ap6/IMJuHfa9a+HO5AR0OOT5t?=
 =?us-ascii?Q?CFTfzHdItct3wJQ/ycB7a0oQ3FMtmKxJE3NIq429K4k7SXFjmR1vZgv43HMF?=
 =?us-ascii?Q?zvTkquYHwCuh6fr4xL/K7VsYaAGgcLoFU9wysxr0e0IiU+O5HWD6tNQXMmkM?=
 =?us-ascii?Q?yFjrMKhtV3kdSPa3wobE2KsiMrZ+UC9sX+ORNpGpsgjE62zfW8djazFA+RlI?=
 =?us-ascii?Q?EGKZfLYmkGOSsPc1shq5aqgNXPPbsNMDsRReWzwoR0h614Il3YcXcn9mVJ01?=
 =?us-ascii?Q?d53ryxT/tBALmQy5GMbdQMDQidnW7bXjKaKK2FZxOSYoJyhzjR+MLE1HlW3C?=
 =?us-ascii?Q?711YcR51M2Mg2WnpCvRpkxnkxngCeOh8KKUKH0OV/b2rfXewFRY4l+AfXGfY?=
 =?us-ascii?Q?JxzRAZTh9kSEMNZtduJRscRrniyr84Gh2ATOtei6Ue5av++SyMjL1n9xpLUg?=
 =?us-ascii?Q?MkgP+e/OivtZn6o+616OxR4C1QzbvodzNBq9a6Yb1fQnx8EV9fM6uCG+KgLc?=
 =?us-ascii?Q?tfDe6SibLOVQOCq2RP1AbwrzrYDkVloxeo9B7t5mmGimuiJ3aW18JXl0jia5?=
 =?us-ascii?Q?jnysp3WV07mG5WnRItgZ3K8w1avRWvvLbmHz1EZApWpbWevolYrgvitn6xpl?=
 =?us-ascii?Q?St4ZZiJt3b9nSZwR2ucTrbrK9NEPrEYL1H5pzvRiek1mbeIt3OPK7d0fQkGi?=
 =?us-ascii?Q?eFVvorjGyMunu6SEH7QnnDyiGEb5+vu/NvNYQxqS/hLQ2lAtKc2UlBHa6cFk?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088fbc00-c10e-458e-5f0d-08dc941d1d2f
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:13:14.6210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCHIDJjEJJHYRAaa3d380gntrcRBCHtqX/Z5crh+lUZMpLKLiB35hY4pQkVLQV+oHuoG0c8KKJDmzrvhnniVh+9NoKpReu0OAbTjK65MR7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0076
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 24 Jun 2024 14:52:21 +0200
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

On Sun, Jun 23, 2024 at 02:32:13PM -0600, Simon Glass wrote:
> Add a way to run tests on a real hardware lab. This is in the very early
> experimental stages. There are only 23 boards and 3 of those are broken!
> (bob, ff3399, samus). A fourth fails due to problems with the TPM tests.
>=20
> To try this, assuming you have gitlab access, set SJG_LAB=3D1, e.g.:
>=20
>    git push -o ci.variable=3D"SJG_LAB=3D1" dm HEAD:try
>=20
> This relies on the two previous series targeted at -next as well as the
> bugfix series for -master
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

> ---
>=20
> Changes in v3:
> - Split out most patches into two new series and update cover letter
>=20
> Changes in v2:
> - Avoid running a docker image for skipped lab tests
>=20
>  .gitlab-ci.yml | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 165f765a833..75c18a0f2f7 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -17,6 +17,7 @@ stages:
>    - testsuites
>    - test.py
>    - world build
> +  - sjg-lab
> =20
>  .buildman_and_testpy_template: &buildman_and_testpy_dfn
>    stage: test.py
> @@ -482,3 +483,155 @@ coreboot test.py:
>      TEST_PY_TEST_SPEC: "not sleep"
>      TEST_PY_ID: "--id qemu"
>    <<: *buildman_and_testpy_dfn
> +
> +.lab_template: &lab_dfn
> +  stage: sjg-lab
> +  rules:
> +    - if: $SJG_LAB =3D=3D "1"
> +      when: always
> +    - when: manual
> +  tags: [ 'lab' ]
> +  script:
> +    - if [[ -z "${SJG_LAB}" ]]; then
> +        exit 0;
> +      fi
> +    # Environment:
> +    #   SRC  - source tree
> +    #   OUT  - output directory for builds
> +    - export SRC=3D"$(pwd)"
> +    - export OUT=3D"${SRC}/build/${BOARD}"
> +    - export PATH=3D$PATH:~/bin
> +    - export PATH=3D$PATH:/vid/software/devel/ubtest/u-boot-test-hooks/b=
in
> +
> +    # Load it on the device
> +    - ret=3D0
> +    - echo "role ${ROLE}"
> +    - export strategy=3D"-s uboot -e off"
> +    # export verbose=3D"-v"
> +    - ${SRC}/test/py/test.py --role ${ROLE} --build-dir "${OUT}"
> +        --capture=3Dtee-sys -k "not bootstd"|| ret=3D$?
> +    - U_BOOT_BOARD_IDENTITY=3D"${ROLE}" u-boot-test-release || true
> +    - if [[ $ret -ne 0 ]]; then
> +        exit $ret;
> +      fi
> +  artifacts:
> +    when: always
> +    paths:
> +      - "build/${BOARD}/test-log.html"
> +      - "build/${BOARD}/multiplexed_log.css"
> +    expire_in: 1 week
> +
> +rpi3:
> +  variables:
> +    ROLE: rpi3
> +  <<: *lab_dfn
> +
> +opi_pc:
> +  variables:
> +    ROLE: opi_pc
> +  <<: *lab_dfn
> +
> +pcduino3_nano:
> +  variables:
> +    ROLE: pcduino3_nano
> +  <<: *lab_dfn
> +
> +samus:
> +  variables:
> +    ROLE: samus
> +  <<: *lab_dfn
> +
> +link:
> +  variables:
> +    ROLE: link
> +  <<: *lab_dfn
> +
> +jerry:
> +  variables:
> +    ROLE: jerry
> +  <<: *lab_dfn
> +
> +minnowmax:
> +  variables:
> +    ROLE: minnowmax
> +  <<: *lab_dfn
> +
> +opi_pc2:
> +  variables:
> +    ROLE: opi_pc2
> +  <<: *lab_dfn
> +
> +bpi:
> +  variables:
> +    ROLE: bpi
> +  <<: *lab_dfn
> +
> +rpi2:
> +  variables:
> +    ROLE: rpi2
> +  <<: *lab_dfn
> +
> +bob:
> +  variables:
> +    ROLE: bob
> +  <<: *lab_dfn
> +
> +ff3399:
> +  variables:
> +    ROLE: ff3399
> +  <<: *lab_dfn
> +
> +coral:
> +  variables:
> +    ROLE: coral
> +  <<: *lab_dfn
> +
> +rpi3z:
> +  variables:
> +    ROLE: rpi3z
> +  <<: *lab_dfn
> +
> +bbb:
> +  variables:
> +    ROLE: bbb
> +  <<: *lab_dfn
> +
> +kevin:
> +  variables:
> +    ROLE: kevin
> +  <<: *lab_dfn
> +
> +pine64:
> +  variables:
> +    ROLE: pine64
> +  <<: *lab_dfn
> +
> +c4:
> +  variables:
> +    ROLE: c4
> +  <<: *lab_dfn
> +
> +rpi4:
> +  variables:
> +    ROLE: rpi4
> +  <<: *lab_dfn
> +
> +rpi0:
> +  variables:
> +    ROLE: rpi0
> +  <<: *lab_dfn
> +
> +snow:
> +  variables:
> +    ROLE: snow
> +  <<: *lab_dfn
> +
> +pcduino3:
> +  variables:
> +    ROLE: pcduino3
> +  <<: *lab_dfn
> +
> +nyan-big:
> +  variables:
> +    ROLE: nyan-big
> +  <<: *lab_dfn
> --=20
> 2.34.1
>=20

