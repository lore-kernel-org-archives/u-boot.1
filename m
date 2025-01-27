Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F0CC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 19:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175CA812C8;
	Mon, 27 Jan 2025 20:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="bnWZbdld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1230D81671; Mon, 27 Jan 2025 20:24:12 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0498129B
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 20:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sfranco@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHAZVzICi3VuZGo2W/bk9+p099wyoEHlyJU4oeZ/ijgNYyw3mhGtxZOgLT+bdRDcdD2jX1zwAVhYayMbz7zr26iXLaBGJpVtCwD4CMMQj1IRl+OLYtWwzs2JfjG2ik1vVdAb/3ZyhAcdesRWwkxSpric676JapWh9ZT216sBfJjTD/1JhBzK3Nd5EW3qM8drTlkvqQPPM/wPKKhcm5TYJunEUT/y7vzDX3pwl+65nbqoxdv0SU3OblTCvGMcFe+kzwvUoWqj+4ZHGhj6SQV7NPAyurbAkijrPVTIeJq3fOz5z119JIeMn2Is/VJOQiMf5GC46Qu4ZHWrqL0QNFFC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwf3YAb8bShaLE9qrX0dVirAK4OX9C7LND7R2Xr+fm0=;
 b=HQrkCeQ2UbfjhKSPAtzigGywCMTaWM9aYj6F1y7MYDPI0IWGeGpk9Fn4zeZ5TcTNImetO4EFKzw4ZB0bFBzG+jCDEOvDWGYT0qwEta56JXT3vBhHIh1xB9ObI2oQOnzG1Xzjy02WlvXyHj2i4OVdMLgoWYvJKm3g3zQzRq89JAcxoWXvM/Et0yh3PSoWbktsDLx5oq0aXDvw4kiLuYG/ge7eBlO6P0iTBks18JJ9JKR09qfGSkIxubo31YMpJmb8NF183sTtXqxyH3CcLmQVrWZkP6A0fdyq+wLDUbbwkGNgAJvjsxQ5/fNxIIoU+7/vNOiVS5KRaV4ADPgVR2DfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwf3YAb8bShaLE9qrX0dVirAK4OX9C7LND7R2Xr+fm0=;
 b=bnWZbdldarABr/ELCtpzAvuKxY1C9KMajQ91Im0VXGp4tzQ3TUaZYtObDPtQQiCrdsDrz6XO/s58Fkyl0zK8C2LJIaCfol3dfH5770JRmsZ7CSqSIl3ieiD0nMeptC81llTyei8LETvmWh9e2eQFmWgy1GstwXJ0K78NromG8N/+6iRmitragsk2YAmz1dUwQmoG0FeoTwVngzVPSFZsoevI3yYpT7uF2/dfPza134w8x47I98OlxxQi+eWl4iAyi2kgSMOC+fJR4NcNsMx0sxEUe+k+n8QEvDVmIyI7YaCAJpaJPqhLI7qIthsbkOk0g2uXvUibyJ1HcYrsbIAo+Q==
Received: from CH0PR18MB5484.namprd18.prod.outlook.com (2603:10b6:610:192::9)
 by CH3PR18MB5953.namprd18.prod.outlook.com (2603:10b6:610:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 19:24:07 +0000
Received: from CH0PR18MB5484.namprd18.prod.outlook.com
 ([fe80::7cce:7612:74c2:f7d2]) by CH0PR18MB5484.namprd18.prod.outlook.com
 ([fe80::7cce:7612:74c2:f7d2%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 19:24:07 +0000
From: Scott Franco <sfranco@axiado.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Current u-boot crashes on sandbox build
Thread-Topic: Current u-boot crashes on sandbox build
Thread-Index: AQHbcPBZMhG8P6S6NEu7tvkmtyvvgQ==
Date: Mon, 27 Jan 2025 19:24:07 +0000
Message-ID: <CH0PR18MB5484C3C43C708D756817728ACBEC2@CH0PR18MB5484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB5484:EE_|CH3PR18MB5953:EE_
x-ms-office365-filtering-correlation-id: a43ab6f0-2891-482d-7a5f-08dd3f082b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YLxpM2sNOMKH+nP5oapfuUp/XrpEaYjZ0sUg/XCAhHDu6UDmkBEOfKK4v3?=
 =?iso-8859-1?Q?j6K1ueV5e2fyV6wBMAcpWcmBYBqrphh47K4/RwzpwUjULn1QWKcr+2sj1G?=
 =?iso-8859-1?Q?NDpxZU/fyebGfVZyjAehuZfAoYuwSy4aY3mz/uWb2W4DseqW53hUanm6pq?=
 =?iso-8859-1?Q?1xFVHXeOl7uRxOMMw8SbJlBbe49dNPddeHe1n7a6MbBZeWG8hWDx96WsMa?=
 =?iso-8859-1?Q?tjGxTbOlVKPh6sK6RfKzFW+0hX5D5jb74YpFZw3d5ZkUQd7cZV7STv8Zht?=
 =?iso-8859-1?Q?GwRexvhCFNYe/nsNlhMm4+dYmKZjKtfwozwYBHfxrxoiGxYc3GPNrTtcWA?=
 =?iso-8859-1?Q?OkV/z/9B60ib7LO2ZxkhuwnsSUxj726CbkAY+HGdjj382nWssCZKeVRa0Q?=
 =?iso-8859-1?Q?rZaR4qBVQJuehXShajvxUUUjmKcE3KlpFtvP8+a9cIesvRDuAmKlxxsp2O?=
 =?iso-8859-1?Q?UZqnTvP7TjV3Rr/g/0iJFZoQcX2UAFvnvcnSHTNB/J0OwbWnzBI4htGmtM?=
 =?iso-8859-1?Q?w3tgugtmzoHXIByRDW/JT3SIjuMA+Wr9hSlyGugjgukDBuV/+VDL/hR+Kd?=
 =?iso-8859-1?Q?WyfujmFUVRzB1X2+tVqzVpcdZNVNN658gQG2kwMEkMjhFnsGppEeG0b/Xr?=
 =?iso-8859-1?Q?Vnmeh554F4iF/S576zTNqc+yk2ebQXnrbJSh4eFQWA55tHzVeIG7UOfIaT?=
 =?iso-8859-1?Q?luHCD1JlvRdkM7zw+j0wFNLAn4BOvaMTKgb6qTinBnkhMQjS/Q16hAIt0D?=
 =?iso-8859-1?Q?wDsSrhHsWgPFvBkKebdORbCzxYkSYVGgl+s5G3GdwNJ8PtQFCxpFk6TVI0?=
 =?iso-8859-1?Q?prTd45ZUTSShO2q1mQyHTI/X6DbaeNPR25Xz1p0uVYWs12vt+lEl3rUHsH?=
 =?iso-8859-1?Q?aN1iKOJh/iuuwaHHWDz7xlU5txBaq7TVFgCMz9wpD0POiEWW/S9FqcWyLp?=
 =?iso-8859-1?Q?cNzAjrGgpVAoRdqittJcWViMD9QCMG67jxRQ7T4E1UFFkPERujibEtk2Ek?=
 =?iso-8859-1?Q?vMsEKZZMy2F+Z1ge5sq0wKnEOQ/VDcgGR8W1Kb/oWNd7P69rsy61r182cm?=
 =?iso-8859-1?Q?3FBza3sFvlIsqzmUDKOfOVC1NdD/iO2Tk+UApWRY83JlBYyRx1HE0Pcol6?=
 =?iso-8859-1?Q?UKegAzGILg5zyaObWdbfzZ+51Z4WE+whkqCxGy/v1ivymO5sj5Q1KN3ZEx?=
 =?iso-8859-1?Q?sG6Pv+CoLxtvGQdcPI3jcxyW8cUTRGZvgnumlS5PRqMLFywIwDw7tUAAmD?=
 =?iso-8859-1?Q?WwpQ4nH1wAB7oTllFXf3ITmCHrq9ndnjz8IzsqLkidetNLnF/KziA+4IfF?=
 =?iso-8859-1?Q?S/v08NAOAHFnPYi72TdRn2Cry3/gUJL/XcX7mKGYkP6LEgNNfrJviinUwB?=
 =?iso-8859-1?Q?nGiEGRs0F/ee3uMUaOrAkDY70I2HMDLEGyf18Pp9Jn6KfDlcn+QaUPInyj?=
 =?iso-8859-1?Q?9ZsD9FMg/ajgwZnCJrLHVsgiOCSwUtWpcxNVSOjFgqKNGQytxQAUnXDZT4?=
 =?iso-8859-1?Q?9EwhUoyMEe9GBwKe+k7Xh7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR18MB5484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q9rnceimp4fQRgAhmwOlpG/OdSut1VqHq+87w3d5ZVgF+ShctBtlF4dDat?=
 =?iso-8859-1?Q?IeElb3ABUe8kpgf3SdawmZbK4JgiEcCaNPraeKSkwa4G3ZEALG1+exy61Y?=
 =?iso-8859-1?Q?Lsj+lqJ5ZrXbLmH/PHAFzcG56HWHsORsLcRPrPZtrPuvLhZlwLkye0Z1IT?=
 =?iso-8859-1?Q?tgXbnd/q/X6g/2mm6Cw0DTV6siaYbn3urY+FE41vds7owJnhUrotAlii7d?=
 =?iso-8859-1?Q?WSlXIuH9Z71T73A+luGWEmL6kJfL5wQTdsWMrZwFNMXtjkUP+SBnqv5ER5?=
 =?iso-8859-1?Q?QH5oy/SIg+ZAfrFwtcYK7mQHB1sYV5qr+rVDlBczlZZttTJ9SRX9ua+Ao/?=
 =?iso-8859-1?Q?6PCeOpTw5H1++4ZXhMWjwyFP6f7bX3Bcn8us/nbnogKzZztOcqp254BAzT?=
 =?iso-8859-1?Q?FmBkk0hRiNiEVRhlz5cMwhSBCIgbtdUD4FF2e9FM8+AND7mPWbsnGiWNgm?=
 =?iso-8859-1?Q?ijajfmLtEBWjn0vjLxTAGb0jYlBxVuh5k1IKz6pIEtgp4L78GVVhlTQBp+?=
 =?iso-8859-1?Q?pDt8J/xtbNRFeUO+4PQ0LoXxXVVVgPHZZxZSQxqUc0+cbxum5ALbQBtKBN?=
 =?iso-8859-1?Q?C9ag2mKZ00x7OpjNKfUTgKY+X7wKNBCUrRro9W01tiBJnJ39Kh0AH0wnwk?=
 =?iso-8859-1?Q?wgb9AIWWAYJFKpx9VQ2Fd7mfUhXHWt8RfrLmf8cECZmrjGMgG25tj2Qw91?=
 =?iso-8859-1?Q?nrvQszCwlQzg5gHz92aKu1vBOGmxYLQulhyL96cyxwJ6YHve6NhwNpreFt?=
 =?iso-8859-1?Q?Q44Drv7qoBDMxGkuhoQMGcx/ITzPONh7vcgLNwmVYTN9HZqF9lqEeSScMy?=
 =?iso-8859-1?Q?SgzplYTzcHc47xQuzs6YqWYiQQurXZl6EQ4j+xOKcSk4kOhxYl+vRg74zC?=
 =?iso-8859-1?Q?CzbrcZuERbihbj15M1i89acy7MKMGxhfriNQvsFYwjuINgFgGq2U5mNzfZ?=
 =?iso-8859-1?Q?Nije3k6Zz3hTEhN9VqdJ25uET5KzvZLEwPmG3sFFtZbWCX6KYak6zXUjyX?=
 =?iso-8859-1?Q?C2aDunBbYN5ybU9Dko6rDPMQq8rNyuSoPU1QJH/cFjsRkHQoOACoLL6SPr?=
 =?iso-8859-1?Q?Bkq/aWc5ava+w2SzpT7bmXyUjDxYXSD9FtvTnb5ik4LAv0569Q+n/JUG7q?=
 =?iso-8859-1?Q?yeZ67M8MBuSvFRngEimiy39xqPFHjCEZaIe9tBuppl5j9qDb27JZb6udcV?=
 =?iso-8859-1?Q?tht4Oxi+lFNayJJFkK0AkQtEteOI/L2vbVCcGjEhzBBu0rFiaxnCwhRVUe?=
 =?iso-8859-1?Q?Vk1K12UQ2RC6NF7nCYOk58PK7MnQgUQKUE2xza6FBVH/cPtvqeP17ZT/c2?=
 =?iso-8859-1?Q?al8y71VLnOjN3kOPK8ndxtf2Di61jKsnbiFc9E4VcLcleJSTeOxH/BAxUZ?=
 =?iso-8859-1?Q?aqW8G/KII8VSc9qajYlw6SgGXV8lpGWA1JyLnkxoJzSURfrmQ7h+BlJMKq?=
 =?iso-8859-1?Q?Kh4JmfMv3/Z9SZh4thGCy2OiGViXbtjjOZUyIzMgvQXEDOZOaWa4XwMH+r?=
 =?iso-8859-1?Q?Ft+Dzt4MFyIYwjtrSFs8CAMiJgXCfLS7qkiR8XUGHXDIR6kvcXHdjQe8Dp?=
 =?iso-8859-1?Q?cpY9f/zd/j6Gy0Z004T4e2DjlhmIMwoQC7RcDTJnVa7YNx6Mmn5G6jgKvm?=
 =?iso-8859-1?Q?RlIALhQtIbOb8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB5484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43ab6f0-2891-482d-7a5f-08dd3f082b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 19:24:07.3182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+ARB1oFRmg+WrFsL4M7PahOEBESwII4BZ81TchQPfdwnN1YzwIafi7lMyHh4VCdyu8mmOrErWausojSxHXKSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5953
X-Mailman-Approved-At: Mon, 27 Jan 2025 20:24:43 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

scott-franco@scott-franco-ThinkPad-P15-Gen-2i:~/projects/u-boot$ ./u-boot
Bloblist at b000 not found (err=3D-2)


U-Boot 2024.10 (Jan 24 2025 - 17:24:46 -0800)

DRAM:  256 MiB
Core:  28 devices, 14 uclasses, devicetree: board
NAND:  0 MiB
MMC:
Loading Environment from nowhere... OK
Warning: device tree node '/config/environment' not found
In:    serial
Out:   serial,vidconsole
Err:   serial,vidconsole
Net:   No ethernet found.

Hit any key to stop autoboot:  0
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------  -------=
---------
Scanning global bootmeth 'efi_mgr':
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Missing TPMv2 device for EFI_TCG_PROTOCOL
Missing RNG device for EFI_RNG_PROTOCOL
Hunting with: simple_bus
Found 2 extension board(s).
Hunting with: mmc
Hunting with: nvme
Hunting with: qfw
Hunting with: scsi
scanning bus for devices...
Hunting with: spi_flash
Hunting with: virtio
Scanning bootdev 'qfw_sandbox.bootdev':
Segmentation fault (core dumped)

Host details:

Ubuntu 24.04 LTS
scott-franco-ThinkPad-P15-Gen-2i

Build:


make sandbox_defconfig

The failure was seen on release versions back until v2024.01, which worked.

Thanks!

Scott Franco
Axiado Corp.


