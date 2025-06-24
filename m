Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C26C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D559E82C2F;
	Tue, 24 Jun 2025 15:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="B7G32K5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0B682D21; Tue, 24 Jun 2025 12:25:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C1A82C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBe6mvdJVLS0HWMqpdr6yJ+At687icZLnpBTDuTUO0Jw1V4AuTgx/fYjZzK6DW4MLYaGHYxuB2w+3g72VxXgTmbxNCKI/+T4oYUhkExGsklb0KZRRK4j7L4H3knczszcRyf0OQwJTew3fgyk/2t+4wZs6RGAnpszfT3URniD8VgsIpcXUANQ8loFbkkg348LS+8IQmmm71q5vT8RDye3BTZu2RsikhRdtIFcJj1/X5ebEh15I6WALYLMIwnis3EkhkHV+utm2Z8YCGjGZMidb0b6huXqMkCKet1WrBtTmFJnp071QVx36xcrsD4iaJprNRe6VI7+VLudG0cLeEAAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/OULeqrDWN+Z4kcQc3Cn351tAv87QRBYbe84o8vBrs=;
 b=q0vm494KedHF4FzUAkWAicDY7SCqQ7U7sUNWabxSuSNsdEAEXVLLilPr2ueUJR77cWVg6z8zL+tCwA9pzzs8HNAF0TN5ft+kQRHcVzOXXU3QpWRJMRZX3lrrfqFsCMFgxrQwZqsoayF3tb8JRxYNYKD/zfz7tJdwyvKG8bq6hbUb5K3WN0OBLRGIddwVcAONKk9tAMjwnKzM4bspjACws8NrMoGagEusdploOfBAfj2pFBFBv4fyj3Aec85PB7tqQoXnex8+1ZtEHwvG1qG2HyRbhUkXsrfSNRVA7oMWMxmwVFJ3CxuhglAs8/8DMAsc3fG6QGXa/1ooXLzlvDGPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/OULeqrDWN+Z4kcQc3Cn351tAv87QRBYbe84o8vBrs=;
 b=B7G32K5TF6qnMuGReS1QFomrgJgQPi//zX816JdUkE9M9mAwSuwdStMJuHSJyoQKFPEOccno5LpQN9pZddppgwlmCv9bxi+j6kQvBG9Wtr7dXtZ+yHKMVwcfC6iCAPmv5tA/ga8SPPZR3u+Zm2PFTDM5OeFhePC+w4hLMMy2s+uUGBuJ6IgY1LSpSjHAw54baMWTYfEd61X9bu+cdrEwDOTYKhxBT6teBqKch2dbxgThmYMOHSBTwhymjERdZWt9f/6Ync8MmTAatG1EFM4ujhVShkj+MNDhx95P6FXxCMMAjSWMSLO86F5iHWAHKQrX8436qITMZpE6cYRFmvhUYw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AS1PR09MB5543.eurprd09.prod.outlook.com (2603:10a6:20b:4a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:25:01 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:25:01 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v2 00/11] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v2 00/11] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHb5PI8GyijdjAN9EWRMauNpUMVhw==
Date: Tue, 24 Jun 2025 10:24:57 +0000
Message-ID: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AS1PR09MB5543:EE_
x-ms-office365-filtering-correlation-id: ac3f3b12-5d49-4f3e-9772-08ddb3095eba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kpeYAy09t6J/LKEv5RMnq5ROU/wCxXdvbWUiH+3u37eR5x2SUacIrf3c3M?=
 =?iso-8859-1?Q?+0J42ei8GW0hF31TU4ruTJVijS10lDsUz+aq1g1P6qCiLa4k6jUC0xBbnm?=
 =?iso-8859-1?Q?7gAp1/UyYSUgC8BZUMJWXrYBXRFTgmrNjx4XJ3fXG5oXVCdh69N09MlOOZ?=
 =?iso-8859-1?Q?f8+UNkHYEcDHe/Vf0ZzD31ktYiVegwp90aKv4np5tRSPk6Uy+85zFH9es8?=
 =?iso-8859-1?Q?6I8bbbxvVgxxLUed5k2NHKYRhYaRZrYoPBZ6n02I0HqGJPEtvueolHdyPQ?=
 =?iso-8859-1?Q?GLKvSxzg8XaI+D2nqy1ndwyIZ7IwBZZ8FWTWD6wRaOoz1xHkhnWqlbQw9+?=
 =?iso-8859-1?Q?0XvCOMdHJQcmFVFuMjoxvfnSSi+0dih6XYFDfuQulkdkD5TauIPfH0hi0q?=
 =?iso-8859-1?Q?VuoAafMHicd7B35idu75UH+VxJWVTluUQIvEIAhnQJiRIKxJSJxd0ouCi0?=
 =?iso-8859-1?Q?hQmKxaWAM4Um7JkbfGH0Zwg3HRQpvWdY9spPU/Idh8ILP0p03or85mhp9h?=
 =?iso-8859-1?Q?VpN2oD6hGsMW1Igou6fi0th6YNmUX8L355gG83ixJvLPEX/VB4TesgH7z7?=
 =?iso-8859-1?Q?GlZSDil127OUwE5HQzOII+FRqvIEINoisD3lFAcpucixco1iMCle2LHnGq?=
 =?iso-8859-1?Q?MiWAMh4MwNHT2DHNrLRVayDwBEwfcD7VpMseL4bS9JNABci0IV7RFVbCZI?=
 =?iso-8859-1?Q?DDY7Xm+ug8GnQpAgC+bsGj5lkZ9w/VtunoOYb75M3qhAUZNe+v6vWpe5U3?=
 =?iso-8859-1?Q?8yzsFO8DGB/es7LfsLb0fp8H02W/t8qLh6HAvgyYEf2+5h1M+r4YhwizuE?=
 =?iso-8859-1?Q?LyyCyBiAn05qSBBBpq+V+Hq6QWOMDAbv54edUEnt3ZXm/VHwZ/SyXFtOeX?=
 =?iso-8859-1?Q?7/k06trRCNBZ4wvRtlJuNaxZbRpk12eviBBizGSvHwh3qGNcn9fQfwM4I1?=
 =?iso-8859-1?Q?Y8lTQ9arQPqsOH1dVK+vRbZXUbMNw+Liv+PnzJQGpwiNjyi3DgyLEkRa8u?=
 =?iso-8859-1?Q?sCMwjdB8TMTvldAP4EAZnntvORuKzKNwi48BZ3Vc2qDs9tB0XhepGWVpk2?=
 =?iso-8859-1?Q?k55UEq3hsjk7+KZjGBsX12n6J9KVZxWUdteTsYL21ssLT4Hz72gUt66A3P?=
 =?iso-8859-1?Q?hUnfdq+jVUKV9HziyQ0WkCqF6m9K5Ya/AxK82KKuiyqGAEoLfg/C026MYX?=
 =?iso-8859-1?Q?SDw0KnKLiMQRgE3euuodxixfiw5Mt4Dnn2jIOR2SlgDVNUTcmYVFlJTvHM?=
 =?iso-8859-1?Q?t9dChHWsGZfO6eh1zT8DpKUHyIhnWKiNPJmaOIMxoO0MrpZWmHI5nfWPp/?=
 =?iso-8859-1?Q?KOYoNZBJbMnJ7cBkAcKFLjbjBLJOm49/7wwQ+p3ht8e+32Wpv7VkuLNq/1?=
 =?iso-8859-1?Q?ddPqh53vDVsKcSfX7R/yKtzAhaOOz6Lipp70KIwm4nyqjoC/n8eyYp8CK1?=
 =?iso-8859-1?Q?VQiqJZyPFkj7DIIHzbszF/4ZGkt1k3YCjQmS7xvVmmm+7hUdAOs2H+2rAW?=
 =?iso-8859-1?Q?1d0XD4AR8hHoFmhnmPYcASk/eBEGLHm5GY2MNhdnYQOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H0yA1UJpWjRgRA7GxxSkwjIX6jCo6tLQ+RKTD8aXGNDBxIyBZZtnzDi/6X?=
 =?iso-8859-1?Q?hrfSC3hbs2T0OL6V2XS0sIrVFdnzhpOM8/S3OFDIuUqhOByyXg2lsBXb2p?=
 =?iso-8859-1?Q?ubIe3WETMqZqhu78Xf6+8KRIE92zsEXGGe9U9k74zlkCFJqP/txhLoRKL0?=
 =?iso-8859-1?Q?sG96IGwlkB7Ltk2Y4DPQoaSQ/ne2LKfV8lEjJqIAVfv5Ygqxv1jvMR/nE8?=
 =?iso-8859-1?Q?NpZ3YSBjG4fGqJqvw9t1LexDk7l4vbBicTQNrAn8f+yMMxgzpGuomo6Ea7?=
 =?iso-8859-1?Q?wyuiR5nBF4fMIG42YitOteLiu5Rc3CtL6CSU8lCK66nSwBYOwpjuD2AvAO?=
 =?iso-8859-1?Q?nw2TlM7CDxe4hyDNVcLhJT9+RHviPn1Io+nqlqQXPN+MsYIZCyOad5EQ0s?=
 =?iso-8859-1?Q?vg3KbublyzqejLsP1KdPN7urSMIlXIOQfe8Tge2FLoN/FTZSJk+1zr/XdV?=
 =?iso-8859-1?Q?6yl06FWCXxrOJtIz8CoIFdsNZxhaL8yE5zu4KbVOQldAP6pEk53/QeXABO?=
 =?iso-8859-1?Q?iRlX6TVTL5e0MPw1XZOjEreJWvjxljkTFf0RW/EF9ZP+PWWUitXkMBWVnU?=
 =?iso-8859-1?Q?DM5lFhUjxuNndbKetrVhVjszfyaE0bQkuOYQGL7U9ayTKnS9Jyuv1HcWcL?=
 =?iso-8859-1?Q?pt9lD9bX5XHqHQNQyf2O46eoilzED/g0QcNLEI/J6lYtPpyk9BAVNuQgPT?=
 =?iso-8859-1?Q?xUXHnIXW5dbVVb3HZszU54BIW0izhQ4XelNXe5Z3IUl0AVYcZSnaUiIA3I?=
 =?iso-8859-1?Q?aXVLI2YOG6bk7qXC6+OeTUIB9mBdb4IiYPnEjVLkbjsb2bwIKiSNvX8uxV?=
 =?iso-8859-1?Q?zubq78wL/8l8lErMlqkvbqKhiZ0sgTQoKA+0+D9SMfUGj8790mkD0ZAbVy?=
 =?iso-8859-1?Q?RNAra3JXH3K7bAOt8Gp4IM06LQYKlF16nEs7IFdlwG1qKzdudAp7lm7f/9?=
 =?iso-8859-1?Q?QAaAT7kIONCKpOFNbFkLPKBocDm/BUI3574IheI/wpTHbmrVBJn4a0u++K?=
 =?iso-8859-1?Q?0z9lJEXErjWa1AiIWKWioMZ1YBZCzDcHyRT56tupByejhpsbqS/v1K/8HW?=
 =?iso-8859-1?Q?UmjwWDjcchD+5uMqwx9mORTfW6IOl77a2wfO9HIp5emM1XwjBBc1Oyr4ud?=
 =?iso-8859-1?Q?7fw8XUgVmsNPHDC+Lqz733t7aMM5QMwJsE+l2peR32+zZR31G6MBwNVcwF?=
 =?iso-8859-1?Q?BT9R4HEmurwLKrQYObLZ+04N8+FqCEWT/AuMVOiFBEsK8y38izpebAYIFA?=
 =?iso-8859-1?Q?WVNcbNBZlYjFEXILY/ngbZvqKhRLNDT/OsTEAV9egZSHc6j9PE0m+dDJOV?=
 =?iso-8859-1?Q?yXz1jdxoGyuGhydhPHQX8a9Up7BdC00AjTFcrLJGqcuysXs4TQICUKXRpf?=
 =?iso-8859-1?Q?gtwzgQwX/cmniJInRMQ85Rr6QdcKZLGOMDKQ/BvRAu+FC7q2fBdtamtmPS?=
 =?iso-8859-1?Q?h8y/stoZFl0rryN4RwpGW1Ai7ApD4Q/JDEWEBvPq6DOebjZCrQkB9KrRxr?=
 =?iso-8859-1?Q?86QUIjuJHA5Inf8hPGr1iXi7RqXxF8sXonX/hsksdWPsrIlx0KSlnqGQsx?=
 =?iso-8859-1?Q?3Aag6ZQOJWGTnswOMW9QGhppjF1vNUZ+oKRT4lxMa1M1A4NFC3hwpoO3xY?=
 =?iso-8859-1?Q?ROXZsBC7tAF780ycE0WIIACJbhkPSVzUuFDuSeZ/6nqeclRTcPtknhOg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3f3b12-5d49-4f3e-9772-08ddb3095eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:24:58.1406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErNb6k39NkVVBT421hZHdher5yVZzOrDXXUCEQz2TxtDjV5VNDvgTOshxqN3lEqsvbrMNE1mh0TbW0KgZcE94zMhIAE5TZ0TSsbiKYe15Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5543
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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

This patch series adds platform support for the P8700 processor
running on the Boston board.

P8700-F is a high-performance RV64GC SoC that supports hardware
multithreading and optional multi-cluster configurations.

----
changes in v2:
- 03/11 - Remove redundant pcie_xilinx_probe() and update commit
	  message accordingly.
----

Chao-ying Fu (10):
  riscv: Add initial support for P8700 SoC
  gpio: Add GPIO driver for Intel EG20T
  pci: xilinx: Avoid writing memory base/limit for root bridge
  riscv: Add support for MIPS GIC syscon on RISC-V SoCs
  net: pch_gbe: Add PHY reset and MAC address fallback for RISC-V
  libfdt: Allow non-64b aligned memreserve entries
  riscv: p8700: Add software emulation for AMO* instructions
  riscv: p8700: Add Coherence Manager (CM) and IOCU support
  riscv: boston: Add support for LED character display command
  cmd: riscv: Add 'startharts' command to start multiple harts

Uros Stajic (1):
  timer: p8700: Add support for reading time from memory-mapped mtime

 arch/riscv/Kconfig                          |  22 ++
 arch/riscv/cpu/Makefile                     |   2 +
 arch/riscv/cpu/p8700/Kconfig                |  15 +
 arch/riscv/cpu/p8700/Makefile               |  10 +
 arch/riscv/cpu/p8700/cache.c                |  84 ++++++
 arch/riscv/cpu/p8700/cm-iocu.c              |  75 +++++
 arch/riscv/cpu/p8700/cm.c                   |  92 ++++++
 arch/riscv/cpu/p8700/cpu.c                  |  22 ++
 arch/riscv/cpu/p8700/dram.c                 |  37 +++
 arch/riscv/cpu/p8700/emu-amo.S              | 254 +++++++++++++++++
 arch/riscv/cpu/p8700/p8700_platform_setup.S | 155 ++++++++++
 arch/riscv/cpu/start.S                      |   8 +
 arch/riscv/dts/Makefile                     |   1 +
 arch/riscv/dts/boston-p8700.dts             | 253 +++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h      |  61 ++++
 arch/riscv/include/asm/arch-p8700/p8700.h   | 144 ++++++++++
 arch/riscv/include/asm/global_data.h        |   2 +
 arch/riscv/include/asm/io.h                 |  86 ++++++
 arch/riscv/lib/Makefile                     |   1 +
 arch/riscv/lib/interrupts.c                 | 299 ++++++++++++++++++++
 arch/riscv/lib/mips_gic.c                   |  47 +++
 board/mips/boston-riscv/Kconfig             |  51 ++++
 board/mips/boston-riscv/MAINTAINERS         |  15 +
 board/mips/boston-riscv/Makefile            |  10 +
 board/mips/boston-riscv/boston-lcd.h        |  20 ++
 board/mips/boston-riscv/boston-regs.h       |  38 +++
 board/mips/boston-riscv/boston-riscv.c      |   9 +
 board/mips/boston-riscv/checkboard.c        |  43 +++
 board/mips/boston-riscv/config.mk           |  15 +
 board/mips/boston-riscv/display.c           |  33 +++
 board/mips/boston-riscv/iocu.c              | 104 +++++++
 board/mips/boston-riscv/lowlevel_init.S     |  20 ++
 board/mips/boston-riscv/reset.c             |  15 +
 cmd/Kconfig                                 |  14 +
 cmd/Makefile                                |   2 +
 cmd/display.c                               |  51 ++++
 cmd/start_harts.c                           | 103 +++++++
 configs/boston-p8700_defconfig              |  95 +++++++
 doc/README.LED_display                      |  26 ++
 drivers/clk/Kconfig                         |   2 +-
 drivers/gpio/Kconfig                        |   7 +
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/eg20t-gpio.c                   | 138 +++++++++
 drivers/net/pch_gbe.c                       |  36 ++-
 drivers/net/pch_gbe.h                       |   1 +
 drivers/pci/pcie_xilinx.c                   |   9 +
 drivers/timer/riscv_timer.c                 |   7 +
 include/asm-generic/global_data.h           |   5 +
 include/configs/boston-riscv.h              |  11 +
 include/interrupt.h                         |  19 ++
 include/led-display.h                       |  33 +++
 net/eth-uclass.c                            |   2 +
 scripts/dtc/libfdt/fdt_ro.c                 |  11 +-
 53 files changed, 2610 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/emu-amo.S
 create mode 100644 arch/riscv/cpu/p8700/p8700_platform_setup.S
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
 create mode 100644 arch/riscv/lib/mips_gic.c
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/display.c
 create mode 100644 board/mips/boston-riscv/iocu.c
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 cmd/display.c
 create mode 100644 cmd/start_harts.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 doc/README.LED_display
 create mode 100644 drivers/gpio/eg20t-gpio.c
 create mode 100644 include/configs/boston-riscv.h
 create mode 100644 include/led-display.h

--=20
2.34.1
