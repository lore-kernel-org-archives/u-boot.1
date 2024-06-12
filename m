Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F06C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 12:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14E8886E2;
	Wed, 12 Jun 2024 14:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="H3kna0u8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387A68867D; Wed, 12 Jun 2024 10:43:33 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C75988168
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 10:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1718181810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOWqZUTJSLTK7Qn86BhA4FMbo3OL+upGRNPXweiw+AY=;
 b=H3kna0u866Xzbb5i96GtzSCZm7WowaKUvA/OQa7ds15X9TmPYY7a9BRHKiw03NgyqfbXK3
 9BymBh9lWOj9DQN6w3UbAQvBowLPdGB+DcD0yKQDyKJEUE+I2qjsw43Eb9CtKRsJ2ZWoPU
 Q//eeX5FZRvcUJW6Nj93rwi+w2KgcTs=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-GcRxHSHzOEOvnNGSFtuw3A-1; Wed, 12 Jun 2024 10:43:29 +0200
X-MC-Unique: GcRxHSHzOEOvnNGSFtuw3A-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by GV0P278MB1096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 08:43:27 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::69a7:1995:40d7:53cc%7]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 08:43:27 +0000
Date: Wed, 12 Jun 2024 10:43:24 +0200
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 42/42] CI: Allow running tests on sjg lab
Message-ID: <ZmlfrPaPExYjt2Gg@toradex.com>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-43-sjg@chromium.org>
In-Reply-To: <20240611200156.2245525-43-sjg@chromium.org>
X-ClientProxiedBy: ZR0P278CA0126.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::23) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|GV0P278MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 53696c44-22cd-4deb-b5da-08dc8abbba8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jCv24n0mUVCH+RH2EVoNl1C3tzOvo6pCbOeuG8B0kGzBtq21K9Oy6EPL/6vL?=
 =?us-ascii?Q?5jFu41y0/jsUL2hUnmEg4j/2V1Vq9wGUWpu5WBojYt+RSdN7Ph0ZJkfoNeKJ?=
 =?us-ascii?Q?AZgMYjNbj9pl0wHRls2qhu81jZ26E0YmfWd2/jgO5kUxmnhMQ4k3YpjX66Xt?=
 =?us-ascii?Q?a3iYiJfV+e0Zv81ug1MSdPDEXI+NzBRUn3kDmKrYbr78sjCyirLXxlZPA0KI?=
 =?us-ascii?Q?4MXVi31YlzJ+ITX23eGkzw1bbalG5n7wyPuHPZPYSGE2BsQdZQYJGAwmv+dy?=
 =?us-ascii?Q?OQT2fye4oegt26ttfEijw/TZKHXNsFEeXN1nuV68r9Ntt0TD79tH+W1cz9gG?=
 =?us-ascii?Q?ZUj8F4dGrq+3e3R367BF1NE0d+GeKspqa/3YkYBCfztfMXLYcGoEHayNvY2c?=
 =?us-ascii?Q?IPtHy0gL8fLSnH+zcvgqWFT0ISbjMRje+vKCujlZXdhY2S27nyyeTd2n7aBo?=
 =?us-ascii?Q?L9JIEUyQfkBD/uL2b8cqCQJI1S3jlmOR+tkEG64ihs0SmJkWTStSKL9ZSc8d?=
 =?us-ascii?Q?flnCpM+qr1pSIRIHBiLZ5b5wl/EMi9r/3CdsgMbll+0nwI8F0rALJ2BTIt+4?=
 =?us-ascii?Q?uPV6jWMQZHO0zgaccsyrydeRFlsj+ocs/mo1gSlPMwpk399GFlhE6hKo6A2s?=
 =?us-ascii?Q?o4K60uTwANDRiB6AC2nJdAbcUQ1qyqtZ+EaB/oHENvAUTMmzIgpld4NgknMs?=
 =?us-ascii?Q?D7eNnV8A3O6MVPJeRxiGeA2DJJxNkHWBK2sLasyO43R8Pu5wD/esYDJYy3AZ?=
 =?us-ascii?Q?JendLdZpykquveqMT9evDSus57z5LVyZk3sJrcRnLgPr1oijSUhG5BOzwswC?=
 =?us-ascii?Q?ZVWF7zQ4WyiqzP64eOaxKEwskXCZUFS+S94Z1mDpZBv/ia4Rrps+cCr8C3df?=
 =?us-ascii?Q?2MZJHGDDHBvYM5Ksih+PyqUXVeoQfkIjF5M2z27ENNTLGvscwsf5z3ZT5Pm3?=
 =?us-ascii?Q?2Grda1CIZLDWK3HcO++zWjfZt48MpMRYnXJuP1oXjt8jvVOdPVn63XOJi0Gg?=
 =?us-ascii?Q?Ia4XUk2jLQ+ttq1CaPdiDcG3wDOQX21R6MDAzsPdA0rscvW1rfQfnBAwkmpz?=
 =?us-ascii?Q?43hCDdDvOc8exb/RQE0T7d7ep1TuNGRpfeFeJth0TSqafrBCWATvaKHZPei/?=
 =?us-ascii?Q?IqQsuQzSdnqdDUdu/o8JZceTPA5HA2PCetmt/+UOHbOjXU3KY78nM0TqIbLW?=
 =?us-ascii?Q?5sMnJmU6s2GmeAqjt1fyM0pbDEo3w/pHsTCmaqqPKsggOPpmE0Vqy+If4Ds5?=
 =?us-ascii?Q?9dE06f8eXTr3dfaYJrDWuEhpp8iQFbNsB3Gfo5PQ0AiY1JIHiWLZZf/KYeF6?=
 =?us-ascii?Q?2JgqpUE1syDbjyhn7iZ4OqjD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230032)(1800799016)(366008)(376006); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jC034IjDSmM4Qx0Eo8VS5sfCQhTRkegrxU999l2PCm45kUGE+DcviZjsP3FY?=
 =?us-ascii?Q?6sU1g6mwrvGsPhR3Wil7pAWUwuuSXUP3szzTtTdYBTUWMg9mwNN5QtFTdfVz?=
 =?us-ascii?Q?1/M8vo87r9u9j1cF3K1TnW2Xj9VcNJIIUREsQPmSFm8j24Y3L6+NS3k43eUf?=
 =?us-ascii?Q?PtFN8TqX7wg5AZJIXanyK+scSayhAidwnLBp/fKpMJJUqxS2xghLfNf6gHb8?=
 =?us-ascii?Q?YzOoOlgM24Lo/1bImKgEKPc89lRRbRn7ZbI6Yn9Jb+XiSrIZllaj61/sI/1s?=
 =?us-ascii?Q?XcqCnJikQjf/LRpHuib+eIRiZcO1e6LMYB4Kuwt+w9RAUQb5v+h1CxGci9tS?=
 =?us-ascii?Q?YyoSiT9rC8qQRG3S5uQso15gNT6pQ+3f12qy6V44tkQIsZP+RDQbpoQE9ikN?=
 =?us-ascii?Q?0uMe/XhNiNrkpxLUJ4KDfNs1UwExEz4+js49r2mqbG9t0geogdS8ggRHCv7/?=
 =?us-ascii?Q?Ic/OYbBwbNMW0r5lfih7scRi3bxBXt2eLxq3dXPm7pdWAuIKQkK9VW0D1Suz?=
 =?us-ascii?Q?fQNEuTiOmU7edmyARS9yKmhi/csiIU78TGpSY3i7QLuXUm7hv8qPkrzpoA12?=
 =?us-ascii?Q?W0AVwmSKsAQMT9KguU0f76+4lnmwiZpZSgWSxL/bzuSyVgglbvtwYwDNS/aQ?=
 =?us-ascii?Q?Mqkl+ymrTp0WvIs9QntQjcFNnU/1QA6ZjShjmz2uim2q3S/UFlgi3x6uy/Ps?=
 =?us-ascii?Q?qbc33jUFWEEDlv3H2/O2KhT7xuZ5m7zVXarFFDTsDeRYy8vlp8h31Wa07mX0?=
 =?us-ascii?Q?/BKSWYPcnEOBFIs82Ub9Q0Ifjze7fBEtb87VIOOoFBN8FTTT7N6QjA+mU3z1?=
 =?us-ascii?Q?7eK6GDgJ+Cw8ThLravw0nzgRsFqF4BjBKC7bVg6A36GE5engVawsiVUYkNKc?=
 =?us-ascii?Q?tgxFYMa3KxbI5aQFt0196bZv7GW9K16KxDUTVpbR5kxyreyBIvyFtB+V4rwd?=
 =?us-ascii?Q?bV/1aI+YGHW9GbjDt2RjLJ2OCreZiMOuM+GM6w274UKT/2FqIo8vg03i5Hm+?=
 =?us-ascii?Q?RQZ4GS4EWFJHmxI2nUEd4V9svTm97cYn5Tytc7LSHwRJ2KOMWFYHX/s44wGt?=
 =?us-ascii?Q?9ospcaXTeZT6sHGV9ppA9LNFZlaD3L6aYw38lKe8A49jDgYyhl8sbpxLU8lG?=
 =?us-ascii?Q?azY889fpsIP0shq3C4789YEX9Ge4v3/IUJG9uub0BDDf7kZ+BpmxY4ebdT1J?=
 =?us-ascii?Q?vBXHqTWnmekIKw1siVIslXjw1jyNyOR7tf4aWn0ixUbbdIzqmHV/lMI5rO9A?=
 =?us-ascii?Q?U02Kl3MZvCz6RDvMTPpx3/nv2txJi4i2RfxfchjEZIJMA9jqpLseBTkiQlfo?=
 =?us-ascii?Q?NWFvTcgQnzvUiYvsAryQDY/JMUfpAabCmtyLtMZX2Xfx2p6Jou7ysBVMxaiO?=
 =?us-ascii?Q?av8ljkqep8lFGGA27Ry71uD4rc58NfyR8lmNr+/3OfPRVvPGa6J7n5HpYiML?=
 =?us-ascii?Q?BlOhKXOHg65DMYt/VWZKizk6UMHvmVBmVGW4p/AonDc0NnEu73A/JyKHy6df?=
 =?us-ascii?Q?us+8EmJ4pb+alloC0cgQ9VN0X+P4sR9G2uqJKtEG+WcaCfY3/zwmJ0b4Lt82?=
 =?us-ascii?Q?p4VsUah13ZBCndCDT+P9DMYPb5J3vcJqqvyQuhjyL1gGFvlFNE1zFC/eLeJC?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53696c44-22cd-4deb-b5da-08dc8abbba8e
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:43:27.5720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT9FsoXWPURUYTSHLm5NXMMpBScjI4w5jCK/kVM+nbnCkuPVMfpXnrYGR933GcIxL4M7Njn9aanBVbGasGEzByDF2EYITA8d9GRwUaxJhdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1096
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 12 Jun 2024 14:49:51 +0200
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

On Tue, Jun 11, 2024 at 02:01:56PM -0600, Simon Glass wrote:
> Add a way to run tests on a real hardware lab. This is in the very early
> experimental stages. There are only 23 boards and 3 of those are broken!
> (bob, ff3399, samus). A fourth fails due to problems with the TPM tests.
>=20
> To try this, assuming you have gitlab access, set SJG_LAB=3D1, e.g.:
>=20
>    git push -o ci.variable=3D"SJG_LAB=3D1" dm HEAD:try
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .gitlab-ci.yml | 151 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 165f765a833..6c362340341 100644
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
> @@ -482,3 +483,153 @@ coreboot test.py:
>      TEST_PY_TEST_SPEC: "not sleep"
>      TEST_PY_ID: "--id qemu"
>    <<: *buildman_and_testpy_dfn
> +
> +.lab_template: &lab_dfn
> +  stage: sjg-lab
> +  rules:
> +    - when: always
> +  tags: [ 'lab' ]
> +  script:
> +    - if [[ -z "${SJG_LAB}" ]]; then
> +        exit 0;
> +      fi

Hi Simon,

Perhaps it would be better to move the check to rules:if?
I do know there's a lot of GitLab CI limitation when it comes to
variables, so not completely sure if this will work, but:

rules:
  - if: $SJG_LAB =3D=3D "1"
    when: always
  - when: manual

My concern is that every of these jobs you added will spin up a docker
image even if you don't want to.

/Andrejs

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

